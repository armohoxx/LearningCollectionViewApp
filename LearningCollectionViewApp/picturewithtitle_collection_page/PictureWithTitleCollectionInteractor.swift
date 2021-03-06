//
//  PictureWithTitleCollectionInteractor.swift
//  LearningCollectionViewApp
//
//  Created armyxx on 12/11/2564 BE.
//  Copyright © 2564 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import Moya
import Mapper

class PictureWithTitleCollectionInteractor: PictureWithTitleCollectionInteractorProtocol {
    
    weak var presenter: PictureWithTitleCollectionPresenterProtocol?
    
    var dataPictureArray: [DataPicture] = []
    var dataPicture: DataPicture?
    
    func setData() {
        NetworkAdapter.request(target: .showMap, success: { (response) in
            do {
                //เพราะมี array อยู่ใน data เลยต้องเป็น NSDictionary ก่อน
                if let jsonObj = try response.mapJSON() as? NSDictionary {
                    
                    //ข้อมูลอยู่ใน array data จึงต้องแปลงอีกที
                    if let jsonObjData = jsonObj["data"] as? [NSDictionary] {
                        jsonObjData.forEach { result in
                            self.dataPicture = DataPicture.from(result)
                            
                            self.dataPictureArray.append(self.dataPicture!)
                        }
                        self.presenter?.getData(pictureData: self.dataPictureArray)
                    }
                }
                
            } catch {
                print("error")
            }
        })
        { (error) in
            print(error)
        }
    }
}

