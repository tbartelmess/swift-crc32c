import XCTest
import CRC32C

final class Swift_CRC32Tests: XCTestCase {
    func testSimpleNumbersCRC32() {
        let numbers:[UInt8] = [0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef]
        let expected: UInt32 = 0x2F720F20
        var crc = CRC32C()
        crc.update(numbers)
        crc.finalize()
        XCTAssertEqual(crc.value, expected)
    }

    func testSimpleData() {
        let numbers:[UInt8] = [0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef, // 64 bit
                               0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef, // 128 bit
                               0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef] // 192 bit
        let expected: UInt32 = 0xBE6DF95B
        let data = Data(numbers)
        var crc = CRC32C()
        crc.update(data)
        crc.finalize()
        XCTAssertEqual(crc.value, expected)
    }

    func test192BitValue() {
        let numbers:[UInt8] = [0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef, // 64 bit
                               0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef, // 128 bit
                               0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef] // 192 bit
        let data = Data(numbers)
        var crc = CRC32C()
        crc.update(data)
        crc.finalize()
    }


    static var allTests = [
        ("testSimpleNumbersCRC32", testSimpleNumbersCRC32),
        ("testSimpleData", testSimpleData),
        ("test192BitValue", test192BitValue)
    ]
}
