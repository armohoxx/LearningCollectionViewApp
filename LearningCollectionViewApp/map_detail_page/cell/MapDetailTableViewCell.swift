//
//  MapDetailTableViewCell.swift
//  LearningCollectionViewApp
//
//  Created by armyxx on 25/11/2564 BE.
//

import UIKit
import Kingfisher

class MapDetailTableViewCell: UITableViewCell {
    
    static let identifier = "MapDetailTableViewCell"
    
    @IBOutlet weak var labelSoi: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDistants: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(with pictureDetailData: DataDetailPicture) {
        let distants = pictureDetailData.distants!.components(separatedBy: ".")
        
        labelSoi.text = pictureDetailData.numsort
        labelName.text = pictureDetailData.name_main
        labelDistants.text = "\(distants[0]) กม."
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "MapDetailTableViewCell", bundle: nil)
    }
    
}
