//
//  ThemeService.swift
//  NASAApp
//
//  Created by Eduard Sinyakov on 01.04.2021.
//

import UIKit

class ThemeService {
    static let shared = ThemeService()
    
    var isDark: Bool {
        UIScreen.main.traitCollection.userInterfaceStyle == UIUserInterfaceStyle.dark
    }
    
    var textColor: UIColor {
        isDark ? .white : .black
    }
    
    var viewColor: UIColor {
        isDark ? .black : .white
    }
}
