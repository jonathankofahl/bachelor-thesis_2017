//
//  ExtensionCALayer.swift
//  BA_JonathanKofahl
//
//  Created by Jonathan Kofahl on 12.06.17.
//
// https://stackoverflow.com/questions/14792238/uiviews-border-color-in-interface-builder-doesnt-work
//
//  Causes Crashes of the IBDesignables in Storyboard, deactivated
//

import UIKit
/*
@IBDesignable extension UIView {
    @IBInspectable var borderColor:UIColor? {
        set {
            layer.borderColor = newValue!.cgColor
        }
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            else {
                return nil
            }
        }
    }
    @IBInspectable var borderWidth:CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    @IBInspectable var cornerRadius:CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
}
*/

// We need this little Extension to CALayer, because when we set the borderColor of an UI element. Iin the Storyboard Attributes we can only set a Color of type UIColor. But for the boderColor we need a cgColor. With this extension the Color is converted from UIColor to cgColor.

extension CALayer {
    var borderUIColor: UIColor {
        set {
            self.borderColor = newValue.cgColor
        }
        
        get {
            return UIColor(cgColor: self.borderColor!)
        }
    }
}
