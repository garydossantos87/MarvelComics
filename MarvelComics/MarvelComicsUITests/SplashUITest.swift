import XCTest

class SplashUITest: BaseUITest {    
    func testSplashScreen() {
        XCTContext.runActivity(named: "Check for the Splash screen elements") { _ in
            XCTAssert(SplashScreen.isImageViewVisible, "ImageViewLogo is not visible")
            XCTAssert(SplashScreen.isloaderGifPresent, "LoaderGif is not present")
        }
    }
}
