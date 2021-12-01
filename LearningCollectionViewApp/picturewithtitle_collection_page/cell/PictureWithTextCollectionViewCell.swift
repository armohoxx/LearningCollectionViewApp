//
//  PictureWithTextCollectionViewCell.swift
//  LearningCollectionViewApp
//
//  Created by armyxx on 16/11/2564 BE.
//

import UIKit
import Kingfisher

class PictureWithTextCollectionViewCell: UICollectionViewCell {
    
    //กำหนด Id ให้กับ collectionviewcell
    static let identifier = "PictureWithTextCollectionViewCell"
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelView: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    public func configure(with pictureData: DataPicture) {
        
        guard let urlImages = URL(string: pictureData.fullimage ?? "") else { return }
        
        //check ข้อมูล เเสดงข้อมูล
        self.imageView.kf.setImage(with: urlImages) { result in
            switch result {
            case .success(let value):
                print("get images \(value.source)")
                self.imageView.image = value.image
            case .failure(let error):
                print(error)
            }
        }
        
        //ให้ label view = title ใน entity
        labelView.text = pictureData.images_name
        
    }

    //กำหนด nib file ที่เป็น view ของ collection view cell
    static func nib() -> UINib {
        return UINib(nibName: "PictureWithTextCollectionViewCell", bundle: nil)
    }
}
