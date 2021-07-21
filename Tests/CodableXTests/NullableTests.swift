import XCTest
@testable import CodableX

final class NullableTests: XCTestCase {
    func testForcable() {
        decode(NullableTest.self, str) { value in
            XCTAssertNil(value.optional)
            encode(value) { (v, data) in
                let decoded = decode(NullableTest.self, data)
                XCTAssertNil(decoded.optional)
            }
        }
    }
    
    static var allTests = [
        ("testForcable", testForcable)
    ]
}

struct NullableTest: Codable {
    @Nullable var optional: Int?
}

fileprivate let str = #"{"int":"3", "bool":0.0}"#
