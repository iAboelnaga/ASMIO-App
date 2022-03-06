//
//  UnderlineLabel.swift
//  ASMIO App
//
//  Created by Ahmed Aboelnaga on 06/03/2022.
//
import UIKit

class UnderlinedLabel: UILabel {
    override var text: String? {
        didSet {
            setLabelText()
        }
    }
    
    private func setLabelText() {
        guard let text = text else { return }
        let textRange = NSRange(location: 0, length: text.count)
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.underlineStyle,
                                    value: NSUnderlineStyle.single.rawValue,
                                    range: textRange)
        self.attributedText = attributedText
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setLabelText()
    }
}
