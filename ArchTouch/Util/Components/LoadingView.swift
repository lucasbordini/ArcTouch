//
//  LoadingView.swift
//  ArchTouch
//
//  Created by Lucas Bordini Ribeiro de Araujo on 13/02/20.
//  Copyright © 2020 Lucas Bordini Ribeiro de Araujo. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    @IBOutlet weak private var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed(LoadingView.nameOfClass, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = UIScreen.main.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
