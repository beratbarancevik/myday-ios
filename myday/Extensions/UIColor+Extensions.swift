//
//  UIColor+Extensions.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

import UIKit

extension UIColor {
    // MARK: - Properties
    static var tintColor = UIColor.systemGreen
    
    // MARK: - RGB
    convenience init(_ red: Int, _ green: Int, _ blue: Int, _ alpha: Double = 1.0) {
        let redValue = CGFloat(red) / 255
        let greenValue = CGFloat(green) / 255
        let blueVlue = CGFloat(blue) / 255
        let alphaValue = CGFloat(alpha)
        self.init(red: redValue, green: greenValue, blue: blueVlue, alpha: alphaValue)
    }
}
