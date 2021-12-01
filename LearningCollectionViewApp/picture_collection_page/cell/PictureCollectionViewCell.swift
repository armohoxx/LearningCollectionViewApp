//
//  PictureCollectionViewCell.swift
//  LearningCollectionViewApp
//
//  Created by armyxx on 16/11/2564 BE.
//

import UIKit

class PictureCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PictureCollectionViewCell"

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(with image: UIImage) {
        imageView.image = image
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "PictureCollectionViewCell", bundle: nil)
    }
}
