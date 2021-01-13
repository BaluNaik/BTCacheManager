import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(BTCacheManagerTests.allTests),
    ]
}
#endif
