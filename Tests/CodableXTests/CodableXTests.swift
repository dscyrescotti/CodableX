import XCTest
@testable import CodableX

final class CodableXTests: XCTestCase {
    func testOneOf() {
        let data = #"{"data":1,"custom":{"name":"DS"}}"#
        var decoded: OneOfTest?
        do {
            let decodedData = try JSONDecoder().decode(OneOfTest.self, from: data.data(using: .utf8)!)
            decoded = decodedData
            let encodedData = try JSONEncoder().encode(decodedData)
            XCTAssertEqual(String(data: encodedData, encoding: .utf8)!, data)
        } catch (let error) {
            print(error.localizedDescription)
        }
        XCTAssertNotNil(decoded)
    }
    
    func testOneOfArray() {
        let data = #"{"defaultArray":[{"name":1}]}"#
        var decoded: OneOfArrayTest?
        do {
            let decodedData = try JSONDecoder().decode(OneOfArrayTest.self, from: data.data(using: .utf8)!)
            decoded = decodedData
            let encodedData = try JSONEncoder().encode(decodedData)
            XCTAssertEqual(String(data: encodedData, encoding: .utf8)!, data)
        } catch (let error) {
            print(error.localizedDescription)
        }
        XCTAssertNotNil(decoded)
    }
    
    func testOptionalOneOf() {
        let data = #"{"optional":1}"#
        var decoded: OptionalOneOfTest?
        do {
            let decodedData = try JSONDecoder().decode(OptionalOneOfTest.self, from: data.data(using: .utf8)!)
            decoded = decodedData
            print(decodedData)
            let encodedData = try JSONEncoder().encode(decodedData)
            XCTAssertEqual(String(data: encodedData, encoding: .utf8)!, data)
        } catch (let error) {
            print(error.localizedDescription)
        }
        XCTAssertNotNil(decoded)
    }
    
    static var allTests = [
        ("testOneOf", testOneOf),
        ("testOneOfArray", testOneOfArray)
    ]
}
