//
//  UIView+Extensions.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

import UIKit

extension UIView {
    @discardableResult
    func style<V>(_ style: Style<V>) -> V {
        let view = self as! V
        style.apply(to: view)
        return view
    }
    
    func setHidden(_ hidden: Bool) {
        self.isHidden = hidden
    }
}
