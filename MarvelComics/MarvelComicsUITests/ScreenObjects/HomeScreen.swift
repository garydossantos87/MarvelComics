import XCTest
@testable import MarvelComics

enum HomeScreen {
    private static var app: XCUIApplication = XCUIApplication()
    
    enum Comic {
        static let collectionView = app.collectionViews.matching(identifier: AccessibilityIdentifiers.Comic.collectionViewID).firstMatch
        static let tabBar = app.buttons.matching(identifier: AccessibilityIdentifiers.Comic.tabBarItemID).firstMatch
        
        static var isCollectionViewVisible: Bool {
            Comic.collectionView.waitForVisibility(with: 5.0)
        }
        
        static var isTabbarVisible: Bool {
            Comic.tabBar.waitForVisibility()
        }
        
        static func tapBarTap() {
            tabBar.tap()
        }
    }
    
    enum Character {
        public static let searchBar = app.otherElements.matching(identifier: AccessibilityIdentifiers.Character.searchBarViewID).firstMatch
        public static let tableView = app.tables.matching(identifier: AccessibilityIdentifiers.Character.tableViewID).firstMatch
        static let tabBar = app.buttons.matching(identifier: AccessibilityIdentifiers.Character.tabBarItemID).firstMatch
        
        static var isSearchBarViewVisible: Bool {
            Character.searchBar.waitForVisibility()
        }
        
        static var isTableViewVisible: Bool {
            Character.tableView.waitForVisibility()
        }
        
        static var isTabbarVisible: Bool {
            Character.tabBar.waitForVisibility()
        }
        
        static func tapBarTap() {
            tabBar.tap()
        }
    }
}
