//
//  OrderPageCell.swift
//  User
//
//  Created by Egor Yanukovich on 9/27/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class OrderPageCell: UITableViewCell {
    
    
    @IBOutlet weak var orderDateAndIdLabel: UILabel!
    @IBOutlet weak var orderStatusImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension OrderPageCell {
    func fillCellInfo(orderDate: String, orderStatusImage: UIImage) {
        self.orderDateAndIdLabel.text = orderDate
        self.orderStatusImage.image = orderStatusImage
    }
}
