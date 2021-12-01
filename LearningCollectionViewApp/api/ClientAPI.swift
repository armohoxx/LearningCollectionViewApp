//
//  ClientAPI.swift
//  LearningCollectionViewApp
//
//  Created by armyxx on 18/11/2564 BE.
//

import Foundation
import Moya

enum TvisAPI {
    case showMap
    case showData(id: String, lat: Double, lng: Double, type: String)
}

extension TvisAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: "http://www.tvis.in.th")!
    }
    
    var path: String {
        switch self {
        case .showMap:
            return "/tvis_shortcut/nameimages.php"
        case .showData:
            return "/tvis_shortcut/imgshort.php"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .showMap:
            return .get
        case .showData:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .showMap:
            // for no parameter
            return .requestPlain
            
        case .showData(id: let id, lat: let lat, lng: let lng, type: let type):
            
            //for have parameters
            return .requestParameters(parameters: ["image" : "\(id)",
                                                  "latitude" : "\(lat)",
                                                  "longitude" : "\(lng)",
                                                   "output" : "\(type)"], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var sampleData: Data {
        return Data()
    }
}
