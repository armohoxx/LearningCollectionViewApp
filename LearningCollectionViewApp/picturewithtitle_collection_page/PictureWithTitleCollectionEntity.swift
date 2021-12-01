//
//  PictureWithTitleCollectionEntity.swift
//  LearningCollectionViewApp
//
//  Created by armyxx on 16/11/2564 BE.
//

import Foundation
import Mapper
import UIKit

class DataPicture: NSObject, Mappable {
    let images_id: String
    let images_name: String?
    let fullimage: String?
    let thumbimage : String?
    
    required init(map: Mapper) throws {
        images_id = try map.from("images_id")
        images_name = map.optionalFrom("images_name") ?? ""
        fullimage = map.optionalFrom("fullimage") ?? ""
        thumbimage = map.optionalFrom("thumbimage") ?? ""
    }
    
    //สำหรับเพิ่มข้อมูลที่ต้องการ
    init(images_id: String, images_name: String?, fullimage: String?, thumbimage: String?) {
        self.images_id = images_id
        self.images_name = images_name
        self.fullimage = fullimage
        self.thumbimage = thumbimage
    }
    
}



