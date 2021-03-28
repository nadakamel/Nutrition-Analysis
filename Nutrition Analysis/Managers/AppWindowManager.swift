//
//  AppWindowManager.swift
//  Nutrition Analysis
//
//  Created by Nada Kamel on 23/03/2021.
//

import UIKit

enum AppWindowManager {
    static func setupWindow() {
        let window = self.window ?? UIWindow.init(frame: windowFrame)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "recipe")
        let navigationController = UINavigationController(rootViewController: controller)
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }
}

private extension AppWindowManager {
    static var window: UIWindow? {
        get {
            return (UIApplication.shared.delegate as? AppDelegate)?.window
        }
        set {
            (UIApplication.shared.delegate as? AppDelegate)?.window = newValue
        }
    }

    static var windowFrame: CGRect {
        return UIScreen.main.bounds
    }
}

