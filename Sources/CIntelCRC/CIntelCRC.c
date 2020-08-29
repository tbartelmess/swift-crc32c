#include <x86intrin.h>
#include <stdio.h>

#include "include/CIntelCRC.h"
#include "Lookup.h"

#define LONG_SHIFT 8192
#define SHORT_SHIFT 256

static inline uint32_t shift(const uint32_t table[][256], uint32_t crc)
{
    return table[0][crc & 0xff]
        ^ table[1][(crc >> 8) & 0xff]
        ^ table[2][(crc >> 16) & 0xff]
        ^ table[3][crc >> 24];
}

uint32_t intel_crc(uint32_t crc, const uint8_t* data, size_t length)
{
    const uint8_t* next = data;
    const uint8_t* end;

    uint64_t crc0;
    uint64_t crc1;
    uint64_t crc2;

    crc0 = crc;

    while (length && ((uint8_t)next & 7) != 0) {
        crc0 = _mm_crc32_u8((uint32_t)(crc0), *next);
        next++;
        length--;
    }

    while (length >= 3 * LONG_SHIFT) {
        crc1 = 0;
        crc2 = 0;
        end = next + LONG_SHIFT;
        do {
            crc0 = _mm_crc32_u64(crc0, *(const uint64_t *)(next));
            crc1 = _mm_crc32_u64(crc1, *(const uint64_t *)(next + LONG_SHIFT));
            crc2 = _mm_crc32_u64(crc2, *(const uint64_t *)(next + 2 * LONG_SHIFT));
            next += 8;
        } while (next < end);
        crc0 = shift(long_shifts.dword_table, (uint32_t)(crc0)) ^ crc1;
        crc0 = shift(long_shifts.dword_table, (uint32_t)(crc0)) ^ crc2;
        next += 2 * LONG_SHIFT;
        length -= 3 * LONG_SHIFT;
    }

    while (length >= 3 * SHORT_SHIFT)
    {
        crc1 = 0;
        crc2 = 0;
        end = next + SHORT_SHIFT;
        do {
            crc0 = _mm_crc32_u64(crc0, *(const uint64_t *)(next));
            crc1 = _mm_crc32_u64(crc1, *(const uint64_t *)(next + SHORT_SHIFT));
            crc2 = _mm_crc32_u64(crc2, *(const uint64_t *)(next + 2 * SHORT_SHIFT));
            next += 8;
        } while (next < end);
        crc0 = shift(short_shifts.dword_table, (uint32_t)(crc0)) ^ crc1;
        crc0 = shift(short_shifts.dword_table, (uint32_t)(crc0)) ^ crc2;
        next += 2 * SHORT_SHIFT;
        length -= 3 * SHORT_SHIFT;
    }

    end = next + (length - (length & 7));
    while (next < end) {
        crc0 = _mm_crc32_u64(crc0, *(const uint64_t *)(next));
        next += 8;
    }
    length &= 7;

    while (length) {
        crc0 = _mm_crc32_u8((uint32_t)(crc0), *next);
        next++;
        length--;
    }

    return (uint32_t)(crc0);
}
