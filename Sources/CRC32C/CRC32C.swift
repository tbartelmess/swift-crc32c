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
    public init() {}

    /// The current CRC32C value
    private(set) public var value: UInt32 = ~0

    public mutating func update(_ data: Data) {
        update(Array<UInt8>(data))
    }

    public mutating func finalize() {
          value = ~value
    }

    mutating private func crc32IntelSSE42(_ data: [UInt8]) {
        value = data.withUnsafeBytes { (ptr) in
            crc32c_append_hw(value, ptr.bindMemory(to: UInt8.self).baseAddress, data.count)
        }
    }

    mutating private func crc32Software(_ data: [UInt8]) {
        for byte in data {
            let lookupIndex = (value ^ UInt32(byte)) & 0xFF
            value = (value >> 8) ^ crc32LookupTable[Int(lookupIndex)]
        }
    }

    public mutating func update(_ data: [UInt8]) {
        #if arch(x86_64) && USE_HARDWARE
        if hasSSE42() {
            crc32IntelSSE42(data)
        } else {
            crc32Software(data)
        }
        #else
        crc32Software(data)
        #endif
    }
}
