import XCTest
@testable import CodableX

final class CodableXTests: XCTestCase {
    func codableX_test<T: Codable>(_ type: T.Type, _ data: String) {
        var decoded: T?
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data.data(using: .utf8)!)
            decoded = decodedData
            print(decodedData)
            let encoded = try JSONEncoder().encode(decodedData)
            print(String(data: encoded, encoding: .utf8)!)
        } catch (let error) {
            fatalError(error.localizedDescription)
        }
        XCTAssertNotNil(decoded)
    }
    
    func testOneOf() {
        codableX_test(OneOfTest.self, #"{"data":1,"custom":{"name":"DS"}}"#)
    }
    
    func testOneOfArray() {
        codableX_test(OneOfArrayTest.self, #"{"defaultArray":[{"name":1}, 1, "2"]}"#)
    }
    
    func testNullableOneOf() {
        codableX_test(NullableOneOfTest.self, #"{"optional":1}"#)
    }
    
    func testDefault() {
        codableX_test(DefaultTest.self, #"{"defaultInt":3,"defaultCustom":{"array":[1,"hello"]},"defaultSet":["a"]}"#)
    }
    
    func testNull() {
        codableX_test(NullTest.self, #"{"int":1}"#)
    }
    
    func testEquatable() {
        let any1: AnyCodable = EquatableTest(string: "hello", int: 1) as AnyCodable
        let any2: AnyCodable = EquatableTest(string: "hello", int: 1) as AnyCodable
        XCTAssertTrue(AnyEquatable(any1) == AnyEquatable(any2))
    }
    
    func testForce() {
        codableX_test(ForceTest.self, #"{"force":1}"#)
    }
    
    func testCompact() {
        codableX_test(CompactTest.self, #"{"compacts":[1,2,3,null,4,null,5]}"#)
    }
    
    func testForceArray() {
        codableX_test(ForceArrayTest.self, #"{"bools":[1,"false",0,true,"1"],"ints":[1,"2",3.5,true]}"#)
    }
    
    func testNullableForce() {
        codableX_test(NullableForceTest.self, #"{"bool":1}"#)
    }
    
    func testCustomDefault() {
        codableX_test(CustomDefaultTest.self, #"{"bool": false}"#)
    }
    
    func testJsonable() {
        codableX_test(JsonableTest.self, #"{"jsonObj":{"one":1,"two":"two","three":null}}"#)
    }
    
    static var allTests = [
        ("testOneOf", testOneOf),
        ("testOneOfArray", testOneOfArray),
        ("testOptionalOneOf", testNullableOneOf),
        ("testDefault", testDefault),
        ("testNull", testNull),
        ("testEquatable", testEquatable),
        ("testForce", testForce),
        ("testCompact", testCompact),
        ("testForceArray", testForceArray),
        ("testNullableForce", testNullableForce),
        ("testCustomDefault", testCustomDefault),
    ]
}
