//
//  SpecificationsTableViewCell.swift
//  ASMIO App
//
//  Created by Ahmed Aboelnaga on 06/03/2022.
//

import UIKit

class SpecificationsTableViewCell: UITableViewCell {
    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var value: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with specification: Specification?, index: Int) {
        keyLabel.text = specification?.key
        value.text = specification?.value
        if index % 2 == 0 {
            contentView.backgroundColor = UIColor.backGroundColor
        }else {
            contentView.backgroundColor = UIColor(hexString: "#F1F2F5")
        }
    }
    
}
