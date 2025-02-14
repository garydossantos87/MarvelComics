import XCTest

extension XCUIElement {
    func waitForVisibility(with timeout: TimeInterval = 2.0) -> Bool {
        waitForExistence(timeout: timeout)
    }
    
    @discardableResult
    func waitForExistence(timeOut: TimeInterval = 2.0) -> Bool {
        return self.waitForExistence(timeout: timeOut)
    }
    
}
