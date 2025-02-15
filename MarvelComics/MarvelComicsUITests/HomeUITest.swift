import XCTest

class HomeUITest: BaseUITest {
    override func setUp() {
        super.setUp()
        server.addResponse(for: .comics)
        server.addResponse(for: .characters)
    }
    
    func testHomeScreen() {
        XCTContext.runActivity(named: "Check for the Home screen elements") { _ in
            XCTAssert(HomeScreen.Comic.isCollectionViewVisible, "Comic TabbarView is not visible")
            XCTAssert(HomeScreen.Comic.isTabbarVisible, "Comic TabbarView is not visible")
            XCTAssert(HomeScreen.Character.isTabbarVisible, "Character TabbarView is not visible")
            HomeScreen.Character.tapBarTap()
            XCTAssert(HomeScreen.Character.isTableViewVisible, "Character TableView is not visible")
            XCTAssert(HomeScreen.Character.isSearchBarViewVisible, "Character SearcBarView is not visible")
        }
    }
}
