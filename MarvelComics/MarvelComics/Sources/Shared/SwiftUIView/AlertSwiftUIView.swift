//
//  AlertViewController.swift
//  MarvelComics
//
//  Created by Gary Dos Santos de Andrade on 26/1/25.
//

import SwiftUI

struct AlertSwiftUIView: UIViewControllerRepresentable {
    let model: Alert.Model
    let showAlert: Bool

    public init(model: Alert.Model, showAlert: Bool = true) {
        self.model = model
        self.showAlert = showAlert
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if showAlert {
            showAlert(on: uiViewController, model: model)
        } else {
            hideAlert(on: uiViewController)
        }
    }
    
    private func showAlert(on viewController: UIViewController, model: Alert.Model) {
        let alertView = Alert.MainView(model: model)
        let alertViewController = UIHostingController(rootView: alertView)
        alertViewController.modalPresentationStyle = .overFullScreen
        alertViewController.view.backgroundColor = .white.withAlphaComponent(0.7)
        viewController.present(alertViewController, animated: true, completion: nil)
    }
    
    private func hideAlert(on viewController: UIViewController) {
        guard let presentedViewController = viewController.presentedViewController as? UIHostingController<Alert.MainView> else {
            return
        }
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}
