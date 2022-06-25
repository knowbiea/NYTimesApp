//
//  UIView+Ext.swift
//  NYTimesApp
//
//  Created by Arvind on 22/06/22.
//

import UIKit

@IBDesignable
extension UIView {
    @IBInspectable var cornerRadius: Double {
        get { return Double(self.layer.cornerRadius) }
        set { self.layer.cornerRadius = CGFloat(newValue) }
    }
}

