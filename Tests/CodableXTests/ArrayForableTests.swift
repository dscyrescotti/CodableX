import XCTest
@testable import CodableX

final class ArrayForcableTests: XCTestCase {
    func testArrayForcable() {
        decode(ArrayForcableTest.self, str) { value in
            XCTAssertEqual(value.bools.count, 5)
            XCTAssertEqual(value.ints.count, 1)
            XCTAssertEqual(value.strings.count, 4)
            XCTAssertEqual(value.doubles.count, 2)
            encode(value) { v, data in
                let decoded = decode(ArrayForcableTest.self, data)
                XCTAssertEqual(decoded.bools, v.bools)
                XCTAssertEqual(decoded.ints, v.ints)
                XCTAssertEqual(decoded.strings, v.strings)
                XCTAssertEqual(decoded.doubles, v.doubles)
            }
        }
    }
}

struct ArrayForcableTest: Codable {
    @ArrayForcable<Bool, DefaultOptions> var bools: [Bool]
    @ArrayForcable<Int, DefaultOptions> var ints: [Int]
    @ArrayForcable<Double, DefaultOptions> var doubles: [Double]
    @ArrayForcable<String, DefaultOptions> var strings: [String]
}

fileprivate let str = #"{"bools":[1,0,"true","false","1",1.0],"ints":["1",true,1.9],"doubles":["1.8",true,2],"strings":[1,1.0,true,false]}"#
