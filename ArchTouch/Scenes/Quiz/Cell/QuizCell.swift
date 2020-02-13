//
//  QuizCell.swift
//  ArchTouch
//
//  Created by Lucas Bordini Ribeiro de Araujo on 12/02/20.
//  Copyright © 2020 Lucas Bordini Ribeiro de Araujo. All rights reserved.
//

import UIKit

class QuizCell: UITableViewCell {
    
    @IBOutlet weak private var hitLabel: UILabel!
    
    func setupCell(hit: String) {
        hitLabel.text = hit
    }
}
