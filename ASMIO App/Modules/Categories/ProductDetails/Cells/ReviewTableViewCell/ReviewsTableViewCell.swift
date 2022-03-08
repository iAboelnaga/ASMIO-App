//
//  ReviewsTableViewCell.swift
//  ASMIO App
//
//  Created by Ahmed Aboelnaga on 06/03/2022.
//

import UIKit

enum RatingType: String {
    case excellent = "Excellent"
    case good = "Good"
    case average = "Average"
    case belowAverage = "Below Average"
    case poor = "Poor"
}

class ReviewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    func configure(with star: Star?, type: RatingType) {
        nameLabel.text = type.rawValue
        countLabel.text = star?.count?.description
        handleProgressColor(for: type)
        if let percentage = star?.percentage {
            progressView.progress = Float(percentage)
        }else {
            progressView.progress = 0
        }
    }

    private func handleProgressColor(for type: RatingType) {
        switch type {
        case .excellent:
            progressView.progressTintColor = UIColor(hexString: "#4AAD52")
        case .good:
            progressView.progressTintColor = UIColor(hexString: "#FFC727")
        case .average:
            progressView.progressTintColor = UIColor(hexString: "#F7E642")
        case .belowAverage:
            progressView.progressTintColor = UIColor(hexString: "#A5D63A")
        case .poor:
            progressView.progressTintColor = UIColor(hexString: "#EA3938")
        }
    }
    
}
