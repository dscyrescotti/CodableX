import XCTest
@testable import CodableX

class ArrayAnyValuableTests: XCTestCase {
    func testArrayAnyValuable() {
        decode(ArrayAnyValuableTest.self, str) { value in
            XCTAssertEqual(value.array.count, 5)
            XCTAssertEqual(value.array[0].int, 1)
        }
        encode(data) { (value, data) in
            print(value)
            let decoded = decode(ArrayAnyValuableTest.self, data)
            XCTAssertEqual(decoded.array.count, value.array.count)
            XCTAssertEqual(decoded.array[2].string, value.array[2].string)
            XCTAssertEqual(decoded.array[4].dict(String.self, Int.self), ["int": 1])
        }
    }
    
    static var allTests = [
        ("testArrayAnyValuable", testArrayAnyValuable)
    ]
}

struct ArrayAnyValuableTest: Codable {
    @ArrayAnyValuable<ArrayOptions> var array: [AnyValue]
}

struct ArrayOptions: OptionConfigurable {
    static var options: [Option] = DefaultOptions.options + [.init([String: Int].self), .init([String: String].self)]
}

fileprivate let str = #"{"array": [1,"swift",true,5.0,{"name":"DS"}]}"#
fileprivate let data = ArrayAnyValuableTest(array: [1,true,"true",100.1,["int":1]].anyValues)
