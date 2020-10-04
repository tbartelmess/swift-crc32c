import NIO
import CRC32C

extension ByteBuffer {
    public func crc32(at: Int, length: Int) -> UInt32 {
        guard let view = self.viewBytes(at: at, length: length) else {
            return ~0
        }
        var crc = CRC32C()
        crc.update(view)
        crc.finalize()
        return crc.value
    }
}
