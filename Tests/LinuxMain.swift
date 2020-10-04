import XCTest

import CRC32CNIOSupportTests
import CRC32CTests

var tests = [XCTestCaseEntry]()
tests += CRC32CNIOSupportTests.__allTests()
tests += CRC32CTests.__allTests()

XCTMain(tests)
