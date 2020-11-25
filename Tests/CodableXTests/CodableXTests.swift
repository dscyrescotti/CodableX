import XCTest
@testable import CodableX

final class CodableXTests: XCTestCase {
    func testOneOf() {
        let data = #"{"data":1,"custom":{"name":"DS"}}"#
        var decoded: OneOfTest?
        do {
            let decodedData = try JSONDecoder().decode(OneOfTest.self, from: data.data(using: .utf8)!)
            decoded = decodedData
            _ = try JSONEncoder().encode(decodedData)
        } catch (let error) {
            fatalError(error.localizedDescription)
        }
        XCTAssertNotNil(decoded)
    }
    
    func testOneOfArray() {
        let data = #"{"defaultArray":[{"name":1}, 1, "2"]}"#
        var decoded: OneOfArrayTest?
        do {
            let decodedData = try JSONDecoder().decode(OneOfArrayTest.self, from: data.data(using: .utf8)!)
            decoded = decodedData
            _ = try JSONEncoder().encode(decodedData)
        } catch (let error) {
            fatalError(error.localizedDescription)
        }
        XCTAssertNotNil(decoded)
    }
    
    func testOptionalOneOf() {
        let data = #"{"optional":1}"#
        var decoded: NullableOneOfTest?
        do {
            let decodedData = try JSONDecoder().decode(NullableOneOfTest.self, from: data.data(using: .utf8)!)
            decoded = decodedData
            _ = try JSONEncoder().encode(decodedData)
        } catch (let error) {
            fatalError(error.localizedDescription)
        }
        XCTAssertNotNil(decoded)
    }
    
    func testDefault() {
        let data = #"{"defaultInt":3,"defaultCustom":{"array":[1,"hello"]},"defaultSet":["a"]}"#
        var decoded: DefaultTest?
        do {
            let decodedData = try JSONDecoder().decode(DefaultTest.self, from: data.data(using: .utf8)!)
            decoded = decodedData
            _ = try JSONEncoder().encode(decodedData)
        } catch (let error) {
            fatalError(error.localizedDescription)
        }
        XCTAssertNotNil(decoded)
    }
    
    func testNull() {
        let data = #"{"int":1}"#
        var decoded: NullTest?
        do {
            let decodedData = try JSONDecoder().decode(NullTest.self, from: data.data(using: .utf8)!)
            decoded = decodedData
            _ = try JSONEncoder().encode(decodedData)
        } catch (let error) {
            fatalError(error.localizedDescription)
        }
        XCTAssertNotNil(decoded)
    }
    
    func testEquatable() {
        let any1: AnyCodable = EquatableTest(string: "hello", int: 1) as AnyCodable
        let any2: AnyCodable = EquatableTest(string: "hello", int: 1) as AnyCodable
        XCTAssertTrue(AnyEquatable(any1) == AnyEquatable(any2))
    }
    
    func testString2Bool() {
        XCTAssertTrue(Bool("true")!)
        XCTAssertFalse(Bool("false")!)
    }
    
    func testForce() {
        let data = #"{"force":1}"#
        var decoded: ForceTest?
        do {
            let decodedData = try JSONDecoder().decode(ForceTest.self, from: data.data(using: .utf8)!)
            decoded = decodedData
            _ = try JSONEncoder().encode(decodedData)
        } catch (let error) {
            fatalError(error.localizedDescription)
        }
        XCTAssertNotNil(decoded)
    }
    
    func testCompact() {
        let data = #"{"compacts":[1,2,3,null,4,null,5]}"#
        var decoded: CompactTest?
        do {
            let decodedData = try JSONDecoder().decode(CompactTest.self, from: data.data(using: .utf8)!)
            decoded = decodedData
            _ = try JSONEncoder().encode(decodedData)
        } catch (let error) {
            fatalError(error.localizedDescription)
        }
        XCTAssertNotNil(decoded)
    }
    
    static var allTests = [
        ("testOneOf", testOneOf),
        ("testOneOfArray", testOneOfArray),
        ("testOptionalOneOf", testOptionalOneOf),
        ("testDefault", testDefault),
        ("testNull", testNull),
        ("testEquatable", testEquatable),
        ("testForce", testForce),
        ("testCompact", testCompact)
    ]
}
