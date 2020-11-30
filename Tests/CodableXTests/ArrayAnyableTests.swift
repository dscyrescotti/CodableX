import XCTest
@testable import CodableX

final class ArrayAnyableTests: XCTestCase {
    func testArrayAnyable() {
        decode(ArrayAnyableTest.self, str) { value in
            XCTAssertEqual(value.array.count, 4)
            XCTAssertEqual(value.array[0] as! Int, 1)
        }
        encode(data) { (value, data) in
            let decoded = decode(ArrayAnyableTest.self, data)
            XCTAssertEqual(decoded.array.count, value.array.count - 1)
            XCTAssertEqual(decoded.array[3] as! Double, value.array[3] as! Double)
        }
    }
    
    static var allTests = [
        ("testArrayAnyable", testArrayAnyable)
    ]
}

struct ArrayAnyableTest: Codable {
    @ArrayAnyable<DefaultOptions> var array:[Any]
}

fileprivate let str = #"{"array": [1,"swift",true,5.0,{"name":"DS"}]}"#
fileprivate let data = ArrayAnyableTest(array: [1,true,"true",100.1,["int":1]])
