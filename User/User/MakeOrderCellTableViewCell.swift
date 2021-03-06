//
//  MakeOrderCellTableViewCell.swift
//  User
//
//  Created by User on 9/22/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class MakeOrderCellTableViewCell: UITableViewCell {

    @IBOutlet weak var makeOrderIconImageOutlet: UIImageView!
    @IBOutlet weak var imageInsideImageMakeOrderOutlet: UIImageView!
    @IBOutlet weak var makeOrderTopMenuLabelOutlet: UILabel!
    @IBOutlet weak var makeOrderBottomMenuLabelOutlet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension MakeOrderCellTableViewCell {
    func fillCellInfo(topImage: UIImage, bottomImage: UIImage, topMenuLabelOutletText: String, bottomMenuLabelOutletText: String) {
        self.makeOrderIconImageOutlet.image = topImage
        self.imageInsideImageMakeOrderOutlet.image = bottomImage
        self.makeOrderTopMenuLabelOutlet.text = topMenuLabelOutletText
        self.makeOrderBottomMenuLabelOutlet.text = bottomMenuLabelOutletText
    }
}
