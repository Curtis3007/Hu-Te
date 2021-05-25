//
//  AppRouter.swift
//  Hu&Te
//
//  Created by BigSur on 24/05/2021.
//

import Foundation
import UIKit

class AppRouter {
    static let shared = AppRouter()
    
    var rootNavigation: UINavigationController?
    
    func updateRootView() {
        let token = UserDefaultHelper.shared.accessToken
        if token != nil {
            openHome()
        } else {
            openLogin()
        }
    }
    
    func pushTo(viewController: UIViewController) {
        viewController.hidesBottomBarWhenPushed = true
        rootNavigation?.pushViewController(viewController, animated: true)
    }
    
    func openLogin() {
        guard let appDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate, let windowApp = appDelegate.window else { return }
        //---
        AppRouter.shared.rootNavigation = nil
        windowApp.rootViewController = UINavigationController(rootViewController: LoginViewController(presenter: LoginPresenter()))
    }
    
    func openHome() {
        guard let appDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate, let windowApp = appDelegate.window else { return }
        //---
        
        windowApp.rootViewController = UINavigationController(rootViewController: HomeViewController(presenter: HomePresenter()))
    }
}
