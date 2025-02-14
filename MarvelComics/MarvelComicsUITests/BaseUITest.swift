import XCTest
import MarvelComicsShared

class BaseUITest: XCTestCase {
    private let defaultLaunchArguments = [
        CustomLaunchArgument.uiTests.rawValue, "YES"
    ]
    var app: XCUIApplication = XCUIApplication()
    
    // MARK: Setup & Teardown
    
    override func setUp() {
        XCUIDevice.shared.orientation = .portrait
        launchApp()
    }
    
    override func tearDown() {
        super.tearDown()
        app.terminate()
    }
}

// MARK: - Private functions -

extension BaseUITest {
    private func launchApp(withArguments arguments: [String] = []) {
        app.launchArguments =  arguments + defaultLaunchArguments
        app.launch()
    }
}
