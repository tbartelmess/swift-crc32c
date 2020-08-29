/// This tool generates a file with a lookup table for CRC32-C (Castagnoli)

import Foundation

extension UInt32 {
    var asHex: String {
        String(format: "%08x", self)
    }
}

let polynomial: UInt32 = 0x82F63B78
var byte: UInt8 = 0
var table: [UInt32] = .init(repeating: 256, count: 256)

for entry in 0..<256 {
    var remainder = UInt32(entry)
    for _ in 1...8 {
        if remainder & 1 == 1 {
            remainder = (remainder >> 1) ^ polynomial
        } else {
            remainder = (remainder >> 1)
        }
    }
    table[entry] = remainder
}

let itemsPerLine = 8
var lines: [[UInt32]] = []
var currentLine: [UInt32] = []

for item in table {
    currentLine.append(item)
    if currentLine.count == itemsPerLine {
        lines.append(currentLine)
        currentLine = []
    }
}
let indent = 8
let padding = (0..<indent).map { _ in " " }.joined()
let outputLines = lines.map { line -> String in
    padding + line.map {"0x\($0.asHex)"}.joined(separator: ", ")
}.joined(separator: ",\n")

print("""
let crc32LookupTable: [UInt32] = [
\(outputLines)
]
""")

