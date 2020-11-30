import XCTest
@testable import CodableX

final class CustomDefaultableTests: XCTestCase {
    func testCustomDefaultable() {
        decode(CustomDefaultableTest.self, str) { value in
            XCTAssertEqual(value.int, 10)
            encode(value) { (v, data) in
                let decoded = decode(CustomDefaultableTest.self, data)
                XCTAssertEqual(value.int, decoded.int)
            }
        }
    }
}

struct CustomDefaultableTest: Codable {
    @CustomDefaultable<Int, Configure> var int: Int
}

struct Configure: DefaultConfigurable {
    typealias T = Int
    static var defaultValue: Int = 10
}

fileprivate let str = #"{"int":null}"#
