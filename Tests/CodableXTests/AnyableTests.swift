import XCTest
@testable import CodableX

final class AnyableTests: XCTestCase {
    func testAnyable() {
        decode(AnyableTest.self, anyableTest) { value in
            XCTAssertEqual(value.defaultAny as! String, "\"StRing\"")
            XCTAssertEqual((value.custom1 as! AnyableInt).int, 1)
            XCTAssertEqual((value.custom2 as! AnyableBool).bool, true)
            XCTAssertEqual((value.custom3 as! AnyableString).string, "I'm a string")
            XCTAssertNil(value.optional)
        }
        encode(anyable) { value, data in
            let decoded = decode(AnyableTest.self, data) 
            XCTAssertEqual(AnyEquatable(value.defaultAny), AnyEquatable(decoded.defaultAny))
            XCTAssertEqual((value.custom1 as! AnyableString).string, (decoded.custom1 as! AnyableString).string)
            XCTAssertEqual((value.custom2 as! AnyableBool).bool, (decoded.custom2 as! AnyableBool).bool)
            XCTAssertEqual((value.custom3 as! AnyableInt).int, (decoded.custom3 as! AnyableInt).int)
            XCTAssertNotNil(value.optional)
        }
    }
    
    static var allTests = [
        ("testAnyable", testAnyable)
    ]
}

struct AnyableTest: Codable {
    @Anyable<DefaultOptions> var defaultAny: Any
    @Anyable<CustomOptions> var custom1: Any
    @Anyable<CustomOptions> var custom2: Any
    @Anyable<CustomOptions> var custom3: Any
    @OptionalAnyable<DefaultOptions> var optional: Any?
}

struct AnyableInt: AnyCodable {
    var int: Int
}

struct AnyableString: AnyCodable {
    var string: String
}

struct AnyableBool: AnyCodable {
    var bool: Bool
}

struct CustomOptions: OptionConfigurable {
    static var options: [Option] = [
        .init(AnyableInt.self),
        .init(AnyableString.self),
        .init(AnyableBool.self),
    ]
}

fileprivate let anyableTest = #"{"defaultAny":"\"StRing\"", "custom1":{"int":1}, "custom2":{"bool":true}, "custom3":{"string":"I'm a string"}, "optional": null}"#

fileprivate let anyable = AnyableTest(defaultAny: 5.0, custom1: AnyableString(string: "Hello"), custom2: AnyableBool(bool: false), custom3: AnyableInt(int: 50), optional: 1)
