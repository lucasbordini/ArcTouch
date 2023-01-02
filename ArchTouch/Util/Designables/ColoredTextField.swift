//
//  ColoredTextField.swift
//  ArchTouch
//
//  Created by Lucas Bordini Ribeiro de Araujo on 12/02/20.
//  Copyright © 2020 Lucas Bordini Ribeiro de Araujo. All rights reserved.
//

import UIKit

@IBDesignable class ColoredTextView: UITextView {
    
    @IBInspectable
    public var background: UIColor? {
        set {
            backgroundColor = newValue
        } get {
            return backgroundColor
        }
    }
}
