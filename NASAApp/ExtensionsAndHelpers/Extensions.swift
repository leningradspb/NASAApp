//
//  Extensions.swift
//  NASAApp
//
//  Created by Eduard Sinyakov on 10.04.2021.
//

import UIKit

extension UITableViewCell {
    static var identifier: String {
        "\(self)"
    }
}

extension UICollectionReusableView {
    static var identifier: String {
        "\(self)"
    }
}


extension UIView {
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { self.addSubview($0) }
    }
}

extension UIStackView {
    func addArranged(subviews:[UIView]) {
        subviews.forEach { self.addArrangedSubview($0) }
    }
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") { cString.removeFirst() }

        if (cString.count) != 6 {
            self.init(hex: "ffffff")
            return
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
