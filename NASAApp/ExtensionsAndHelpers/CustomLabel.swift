//
//  CustomLabel.swift
//  NASAApp
//
//  Created by Eduard Sinyakov on 10.04.2021.
//

import UIKit

class CustomLabel: UILabel {

    init(color: UIColor, font: UIFont) {
        super.init(frame: .zero)
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping
        self.font = font
        self.textColor = color
    }

    init(color: UIColor, font: UIFont, numberOfLines: Int, lineBreakMode: NSLineBreakMode) {
        super.init(frame: .zero)
        self.numberOfLines = numberOfLines
        self.lineBreakMode = lineBreakMode
        self.font = font
        self.textColor = color
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
