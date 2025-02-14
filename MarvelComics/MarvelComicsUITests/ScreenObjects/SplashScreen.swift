import MarvelComicsShared
import XCTest

enum SplashScreen {
    private static var app: XCUIApplication = XCUIApplication()
    private static let imageViewLogo = app.images.matching(identifier: AccessibilityIdentifiers.Splash.imageViewLogoID).firstMatch
    public static let loaderGif = app.images.matching(identifier: AccessibilityIdentifiers.Splash.loaderGifID).firstMatch
    
    static var isImageViewVisible: Bool {
        imageViewLogo.waitForVisibility()
    }
    
    static var isloaderGifPresent: Bool {
        loaderGif.exists
    }
}
