import CIntelCRC
import Foundation

/// CRC32C checksum generator.
///
/// The CRC checksum can be updated incrementally as more data becomes available.
///
/// Basic usage:
/// ```
/// Create a CRC generator
/// var crc = CRC32C()
///
/// // Feed in data
/// crc.update([0x01, 0x02, 0x03])
///
/// // Get the result
/// crc.value
/// ```
public struct CRC32C {

    /// The current CRC32C value
    private(set) public var value: UInt32 = 0

    public mutating func update(_ data: Data) {
        update(Array<UInt8>(data))
    }

    public mutating func update(_ data: [UInt8]) {
        value = data.withUnsafeBytes { (ptr) in

            intel_crc(value, ptr.bindMemory(to: UInt8.self).baseAddress, data.count)
        }
    }
}
