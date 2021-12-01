//
//  MapDetailPageEntity.swift
//  LearningCollectionViewApp
//
//  Created by armyxx on 29/11/2564 BE.
//

import Foundation
import Mapper
import UIKit

class DataDetailPicture: NSObject, Mappable {
    let images_id: String
    let numsort: String?
    let name_main: String?
    let name_minor: String?
    let latitude: Double?
    let longitude: Double?
    let fullimage: String?
    let thumbimage: String?
    let distants: String?
    
    required init(map: Mapper) throws {
        images_id = try map.from("images_id")
        numsort = map.optionalFrom("numsort") ?? ""
        name_main = map.optionalFrom("name_main") ?? ""
        name_minor = map.optionalFrom("name_minor") ?? ""
        latitude = map.optionalFrom("latitude") ?? 0
        longitude = map.optionalFrom("longitude") ?? 0
        fullimage = map.optionalFrom("fullimage") ?? ""
        thumbimage = map.optionalFrom("thumbimage") ?? ""
        distants = map.optionalFrom("distants") ?? ""
    }
    
    
}
