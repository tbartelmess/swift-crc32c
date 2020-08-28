//
//  File.c
//  
//
//  Created by Thomas Bartelmess on 2020-08-27.
//

#include <x86intrin.h>
#include <stdio.h>
#include "include/CIntelCRC.h"

unsigned int intel_crc(unsigned int c, const unsigned char* data, size_t length) {
    unsigned int crc = 0xFFFFFFFF;
    for (int i = 0; i < length; i++) {
        crc = _mm_crc32_u8(crc, *data++);
    }
    return crc ^ 0xFFFFFFFF;
}
