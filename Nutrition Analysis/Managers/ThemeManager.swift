//
//  ThemeManager.swift
//  Nutrition Analysis
//
//  Created by Nada Kamel on 23/03/2021.
//

import UIKit

enum ThemeManager {
    static let backgroundColor = UIColor(red: 31.0/255.0, green: 33.0/255.0, blue: 36.0/255.0, alpha: 1)
    
    static func configure() {
        // MARK: - UIApperance
        configureNavigationBarAppearance()
    }
}

//MARK: - UINavigationBar Appearance
private extension ThemeManager {
    static func configureNavigationBarAppearance() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().tintColor = .black
    }
}
