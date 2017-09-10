//
//  ExtensionCALayer.swift
//  BA_JonathanKofahl
//
//  Created by Jonathan Kofahl on 12.06.17.
//
// https://stackoverflow.com/questions/14792238/uiviews-border-color-in-interface-builder-doesnt-work
//
//  
//

import UIKit

// We need this little Extension to CALayer, because when we set the borderColor of an UI element. In the Storyboard Attributes we can only set a Color of type UIColor. But for the boderColor we need a cgColor. With this extension the Color is converted from UIColor to cgColor.

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
