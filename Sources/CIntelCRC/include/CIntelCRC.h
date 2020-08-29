#include <stdlib.h>
#include <stdint.h>
unsigned int intel_crc(unsigned int c, const unsigned char* data, size_t length);
uint32_t crc32c_append_hw(uint32_t crc, const uint8_t * buf, size_t len);
