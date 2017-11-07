//
//  MangaTableViewCell.swift
//  AniAppDemo
//
//  Created by Nikita Agarwal on 06/11/17.
//  Copyright © 2017 Nikita Agarwal. All rights reserved.
//

import Foundation
import UIKit

class MangaTableViewCell: UITableViewCell {
    @IBOutlet weak var mangaImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var alternativeTitlesLabel: UILabel!
    @IBOutlet weak var creatorsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let backgroundView = UIView(frame: frame)
        //backgroundView.backgroundColor = UIColor.blackColor()
        selectedBackgroundView = backgroundView
    }
}
