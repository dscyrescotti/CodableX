import XCTest
@testable import CodableX

final class ForcableTests: XCTestCase {
    func testForcable() {
        decode(ForcableTest.self, str) { value in
            XCTAssertEqual(value.int, 3)
            XCTAssertEqual(value.bool, false)
            XCTAssertNil(value.optional)
            encode(value) { (v, data) in
                let decoded = decode(ForcableTest.self, data)
                XCTAssertEqual(value.bool, decoded.bool)
                XCTAssertEqual(value.int, decoded.int)
                XCTAssertNil(decoded.optional)
            }
        }
    }
}

struct ForcableTest: Codable {
    @Forcable<Int, DefaultOptions> var int: Int
    @Forcable<Bool, DefaultOptions> var bool: Bool
    @OptionalForcable<Int, DefaultOptions> var optional: Int?
}

fileprivate let str = #"{"int":"3", "bool":0.0}"#
