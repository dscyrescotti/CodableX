import XCTest
@testable import CodableX

final class DefaultableTests: XCTestCase {
    func testDefaultable() {
        decode(DefaultableTest.self, str) { value in
            XCTAssertEqual(value.bool, false)
            XCTAssertEqual(value.string, "")
            XCTAssertEqual(value.double, 0.0)
            XCTAssertEqual(value.int, 0)
            XCTAssertEqual(value.dict, [:])
            encode(value) { (v, data) in
                let decoded = decode(DefaultableTest.self, data)
                XCTAssertEqual(value.bool, decoded.bool)
                XCTAssertEqual(value.string, decoded.string)
                XCTAssertEqual(value.double, decoded.double)
                XCTAssertEqual(value.int, decoded.int)
                XCTAssertEqual(value.dict, decoded.dict)
            }
        }
    }
}

struct DefaultableTest: AnyCodable {
    @Defaultable var int: Int
    @Defaultable var string: String
    @Defaultable var double: Double
    @Defaultable var bool: Bool
    @Defaultable var dict: [String: Bool]
}

fileprivate let str = #"{"dict":null}"#
