import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(AnyableTests.allTests),
        testCase(ArrayAnyableTests.allTests)
    ]
}
#endif
