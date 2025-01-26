//
//  BaseHostingController.swift
//  MarvelComics
//
//  Created by Gary Dos Santos de Andrade on 26/1/25.
//

import SwiftUI

class BaseHostingController<Content>: UIHostingController<Content> where Content: View {
    private let hideTabBar: Bool
    
    init(rootView: Content, hideTabBar: Bool = false) {
        self.hideTabBar = hideTabBar
        super.init(rootView: rootView)
    }
    
    required init?(coder: NSCoder) {
        self.hideTabBar = false
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide the tab bar when the view is loaded if needed
        if let tabBarController = self.tabBarController, hideTabBar {
            tabBarController.tabBar.isHidden = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the tab bar again when the view disappears
        if let tabBarController = self.tabBarController, hideTabBar {
            tabBarController.tabBar.isHidden = false
        }
    }
}
