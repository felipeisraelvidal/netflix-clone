import XCTest
@testable import Modules

final class NetworkingTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Modules().text, "Hello, World!")
    }
}
