//
//  MovieCell.swift
//  flix
//
//  Created by Darrel Muonekwu on 4/7/19.
//  Copyright © 2019 Darrel Muonekwu. All rights reserved.
//


import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var summeryLabel: UILabel!
    
    
    func makeTitleLabelLight() {
        
        titleLabel.textColor = UIColor.green
        summeryLabel.textColor = UIColor.green
        
    }
}
