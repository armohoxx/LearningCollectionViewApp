//
//  TextCollectionViewCell.swift
//  LearningCollectionViewApp
//
//  Created by armyxx on 16/11/2564 BE.
//

import UIKit

class TextCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TextCollectionViewCell"
    
    @IBOutlet weak var labelTextView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(with textDescript: TextDescript) {
        labelTextView.text = textDescript.text
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "TextCollectionViewCell", bundle: nil)
    }

}
