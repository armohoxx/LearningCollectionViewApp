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
    
    // Note: must be strong
    @IBOutlet private var maxWidthConstraint: NSLayoutConstraint! {
        didSet {
            //เมื่อเรียกใช้ตอนเเรกให้ false
            maxWidthConstraint.isActive = false
        }
    }
    
    var maxWidth: CGFloat? = nil {
        //ถ้าค่าว่างให้กระทำดังนี้
        didSet {
            guard let maxWidth = maxWidth else {
                return
            }
            maxWidthConstraint.isActive = true
            maxWidthConstraint.constant = maxWidth
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    public func configure(with textDescript: TextDescript) {
        labelTextView.text = textDescript.text
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "TextCollectionViewCell", bundle: nil)
    }

}
