import XCTest
@testable import CodableX

final class CodableXTests: XCTestCase {
    func testOneOf() {
        let data = #"{ "data": 1, "custom": { "name": "DS" } }"#.data(using: .utf8)!
        var decoded: OneOfTest?
        do {
            decoded = try JSONDecoder().decode(OneOfTest.self, from: data)
        } catch (let error) {
            print(error.localizedDescription)
        }
        XCTAssertNotNil(decoded)
    }
    
    static var allTests = [
        ("testOneOf", testOneOf),
    ]
}
