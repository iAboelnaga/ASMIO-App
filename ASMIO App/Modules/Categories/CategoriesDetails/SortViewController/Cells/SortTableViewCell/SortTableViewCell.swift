//
//  SortTableViewCell.swift
//  ASMIO App
//
//  Created by Ahmed Aboelnaga on 06/03/2022.
//

import UIKit

class SortTableViewCell: UITableViewCell {
    @IBOutlet weak var sortOptionNameLabel: UILabel!
    @IBOutlet weak var selectedImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with name: String, selection: Bool) {
        sortOptionNameLabel.text = name
        selectedImageView.isHidden = !selection
    }
    
}
