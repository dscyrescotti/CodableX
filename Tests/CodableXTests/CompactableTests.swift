import XCTest
@testable import CodableX

final class CompactableTests: XCTestCase {
    func testCompactable() {
        decode(CompactableTest.self, str) { value in
            XCTAssertEqual(value.array.count, 5)
            encode(value) { (v, data) in
                let decoded = decode(CompactableTest.self, data)
                XCTAssertEqual(decoded.array, v.array)
            }
        }
    }
}

struct CompactableTest: Codable {
    @Compactable var array: [Int]
}

fileprivate let str = #"{"array":[1,null,2,3,null,4,5,null,null]}"#
