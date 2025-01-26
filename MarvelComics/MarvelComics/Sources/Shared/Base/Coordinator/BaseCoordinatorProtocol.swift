//
//  CoordinatorProtocol.swift
//  MarvelComics
//
//  Created by Gary Dos Santos de Andrade on 25/1/25.
//

import UIKit

protocol BaseCoordinatorProtocol: AnyObject {
    func handleNavigation(with navigation: CoordinatorNavigation)
    func setApplicationFlow(with viewController: UIViewController) -> UINavigationController?
}
