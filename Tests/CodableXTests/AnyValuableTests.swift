import XCTest
@testable import CodableX

final class AnyValuableTests: XCTestCase {
    func testAnyValuable() {
        decode(AnyValuableTest.self, anyValuableTest) { value in
            print(value.defaultAny.value)
            XCTAssertNotNil(value.defaultAny.string)
            XCTAssertNotNil(value.custom1.anyableInt)
            XCTAssertNotNil(value.custom2.anyableBool)
            XCTAssertNotNil(value.custom3.anyableString)
            XCTAssertNil(value.option?.bool)
        }
        encode(anyValuable) { value, data in
            let decoded = decode(AnyValuableTest.self, data)
            XCTAssertNotNil(decoded.defaultAny.double)
            XCTAssertNotNil(decoded.custom1.anyableString)
            XCTAssertNotNil(decoded.custom2.anyableBool)
            XCTAssertNotNil(decoded.custom3.anyableInt)
            XCTAssertNotNil(decoded.option)
        }
    }
    
    
    static var allTests = [
        ("testAnyValuable", testAnyValuable)
    ]
}

struct AnyValuableTest: Codable {
    @AnyValuable<DefaultOptions> var defaultAny: AnyValue
    @AnyValuable<CustomOptions> var custom1: AnyValue
    @AnyValuable<CustomOptions> var custom2: AnyValue
    @AnyValuable<CustomOptions> var custom3: AnyValue
    @OptionalAnyValuable<DefaultOptions> var option: AnyValue?
}

fileprivate let anyValuableTest = #"{"defaultAny":"\"StRing\"", "custom1":{"int":1}, "custom2":{"bool":true}, "custom3":{"string":"I'm a string"}}"#

extension AnyValue {
    var anyableInt: AnyableInt? {
        value as? AnyableInt
    }
    
    var anyableBool: AnyableBool? {
        value as? AnyableBool
    }
    
    var anyableString: AnyableString? {
        value as? AnyableString
    }
}

fileprivate let anyValuable = AnyValuableTest(defaultAny: Double(5).anyValue, custom1: AnyableString(string: "Hello").anyValue, custom2: AnyableBool(bool: false).anyValue, custom3: AnyableInt(int: 50).anyValue, option: true.anyValue)
