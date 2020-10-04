import XCTest
import NIO
import CRC32CNIOSupport


final class CRCByteBufferTests: XCTestCase {


    func assertCRCByteBufferRoundTrip(bytes: [UInt8], expected: UInt32) {
        let buffer = ByteBufferAllocator().buffer(bytes: bytes)
        XCTAssertEqual(buffer.crc32(at: 0, length: buffer.readableBytes), expected)
    }
    func testSimpleNumbersCRC32() {
        let numbers:[UInt8] = [0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef]
        let expected: UInt32 = 0x2F720F20
        assertCRCByteBufferRoundTrip(bytes: numbers, expected: expected)
    }

    func testSimpleData() {
        let numbers:[UInt8] = [0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef, // 64 bit
                               0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef, // 128 bit
                               0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef] // 192 bit
        let expected: UInt32 = 0xBE6DF95B
        assertCRCByteBufferRoundTrip(bytes: numbers, expected: expected)

    }
}
