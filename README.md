# Swift-CRC32

This package implements the crc32c algorithm for error detection.

If running on an Intel CPU that supports the SSE 4.2 instruction set, the CRC calculation is hardware accelerated.

## Usage

```swift
// Create a CRC generator
var crc = CRC32C()

// Feed in data
crc.update([0x01, 0x02, 0x03])

// Finalize
crc.finalize()

// Get the result
crc.value
```

## Performance

When using an Intel CPU with a SSE 4.2 instruction set, the specialized `CRC` instruction is used. On other CPUs the calculation falls back to a generic software implemenation.

With SSE 4.2 you can expect a speedup of about 5x.

Below is a chart with the average runtime to calcluate the CRC32-C of a 1GB file on an 8th Gen "Coffee Lake" Intel Core i9 with 2.9 GHz.

![performance graph](performance.png)

## License

MIT License

Copyright (c) 2020 Thomas Bartelmess

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
