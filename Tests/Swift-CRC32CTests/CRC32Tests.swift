import XCTest
@testable import Swift_CRC32C

final class Swift_CRC32Tests: XCTestCase {
    func testSimpleNumbersCRC32() {
        let numbers:[UInt8] = [0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef]
        let expected: UInt32 = 0x2F720F20
        var crc = CRC32C()
        crc.update(numbers)
        XCTAssertEqual(crc.value, expected)
    }

    func testSimpleData() {
        let numbers:[UInt8] = [0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef]
        let expected: UInt32 = 0x2F720F20
        let data = Data(numbers)
        var crc = CRC32C()
        crc.update(data)
        XCTAssertEqual(crc.value, expected)
    }

    static var allTests = [
        ("testSimpleNumbersCRC32", testSimpleNumbersCRC32),
        ("testSimpleData", testSimpleData),
    ]
}
