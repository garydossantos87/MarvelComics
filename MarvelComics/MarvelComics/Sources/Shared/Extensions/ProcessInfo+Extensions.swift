import Foundation

public extension ProcessInfo {
    func contains(argument: CustomLaunchArgument) -> Bool {
        return arguments.contains(argument.rawValue)
    }
    
    var isUITests: Bool {
        return contains(argument: .uiTests)
    }
}
