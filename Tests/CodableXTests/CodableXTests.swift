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
        let data = #"{"defaultArray":[{"name":1}]}"#
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
        var decoded: OptionalOneOfTest?
        do {
            let decodedData = try JSONDecoder().decode(OptionalOneOfTest.self, from: data.data(using: .utf8)!)
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
    
    static var allTests = [
        ("testOneOf", testOneOf),
        ("testOneOfArray", testOneOfArray),
        ("testOptionalOneOf", testOptionalOneOf),
        ("testDefault", testDefault),
    ]
}
