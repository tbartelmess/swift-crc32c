//
//  File.h
//  
//
//  Created by Thomas Bartelmess on 2020-08-29.
//

#include <stdint.h>
extern const uint32_t crc32LookupTable[256];
extern union {
    uint32_t dword_table[16][256];
    uint64_t qword_array[2048];
} table;
extern union {
    uint32_t dword_table[4][256];
    uint64_t qword_array[512];
} long_shifts;
extern union {
    uint32_t dword_table[4][256];
    uint64_t qword_array[512];
} short_shifts;
