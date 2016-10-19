import XCTest
@testable import DatabaseConnector

class DatabaseConnectorTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(DatabaseConnector().text, "Hello, World!")
    }


    static var allTests : [(String, (DatabaseConnectorTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
