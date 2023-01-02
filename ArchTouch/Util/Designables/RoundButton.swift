//
//  RoundButton.swift
//  ArchTouch
//
//  Created by Lucas Bordini Ribeiro de Araujo on 12/02/20.
//  Copyright © 2020 Lucas Bordini Ribeiro de Araujo. All rights reserved.
//

import UIKit

@IBDesignable class RoundButton: UIButton {
    
    @IBInspectable
    public var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        } get {
            return layer.cornerRadius
        }
    }
}

