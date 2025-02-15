import XCTest

extension XCUIElement {
    func waitForVisibility(with timeout: TimeInterval = 2.0) -> Bool {
        let predicate = NSPredicate(format: "exists == true")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: self)
        return XCTWaiter.wait(for: [expectation], timeout: timeout) == .completed
    }
    
    @discardableResult
    func waitForExistence(timeOut: TimeInterval = 2.0) -> Bool {
        return self.waitForExistence(timeout: timeOut)
    }
    
}
