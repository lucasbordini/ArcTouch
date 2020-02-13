//
//  RoundView.swift
//  ArchTouch
//
//  Created by Lucas Bordini Ribeiro de Araujo on 13/02/20.
//  Copyright © 2020 Lucas Bordini Ribeiro de Araujo. All rights reserved.
//

import UIKit

@IBDesignable class RoundView: UIView {
    
    @IBInspectable
    public var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = true
        } get {
            return layer.cornerRadius
        }
    }
}
