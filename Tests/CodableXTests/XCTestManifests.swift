import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(AnyableTests.allTests),
        testCase(AnyValuableTests.allTests),
        testCase(ArrayAnyableTests.allTests),
        testCase(ArrayAnyValuableTests.allTests),
        testCase(ArrayForcableTests.allTests),
        testCase(CompactableTests.allTests),
        testCase(CustomDefaultableTests.allTests),
        testCase(DefaultableTests.allTests),
        testCase(ForcableTests.allTests),
        testCase(JsonableTests.allTests),
        testCase(NullableTests.allTests)
    ]
}
#endif
