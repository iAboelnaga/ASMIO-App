//
//  UIViewController+Ext.swift
//  ASMIO App
//
//  Created by Ahmed Aboelnaga on 06/03/2022.
//

import UIKit

extension UIViewController {
    
    func push(_ viewController: UIViewController) {
        navigationController?.fadeTo(viewController)
    }
    
    func pop() {
        navigationController?.fadeOut()
    }
    
    func popToRoot() {
        navigationController?.popRoot()
        dismiss()
    }

    func present(_ viewController:UIViewController) {
        present(viewController, animated: true, completion: nil)
    }
    
    func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    func setRootViewController(vc: UIViewController) {
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.isNavigationBarHidden = true
        UIApplication.shared.windows.first?.rootViewController = navigationController
    }
}
