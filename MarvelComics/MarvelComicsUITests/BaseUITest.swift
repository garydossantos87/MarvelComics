import XCTest
import Swifter
@testable import MarvelComics

class BaseUITest: XCTestCase {
    private let defaultLaunchArguments = [
        CustomLaunchArgument.uiTests.rawValue, "YES"
    ]
    var app: XCUIApplication = XCUIApplication()
    let server = HttpServer()
    
    // MARK: Setup & Teardown
    
    override func setUp() {
        XCUIDevice.shared.orientation = .portrait
        try? server.start(8080)
        launchApp()
    }
    
    override func tearDown() {
        super.tearDown()
        server.stop()
        app.terminate()
    }
}

// MARK: - Private functions -

extension BaseUITest {
    private func launchApp(withArguments arguments: [String] = []) {
        app.launchArguments = arguments + defaultLaunchArguments
        app.launch()
    }
}
