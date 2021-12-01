//
//  MapDetailPageInteractor.swift
//  LearningCollectionViewApp
//
//  Created armyxx on 25/11/2564 BE.
//  Copyright © 2564 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import CoreLocation

class MapDetailPageInteractor: CLLocationManager, MapDetailPageInteractorProtocol, CLLocationManagerDelegate {

    weak var presenter: MapDetailPagePresenterProtocol?
    let locationManager = CLLocationManager()
    var latitude: Double?
    var longitude: Double?
    var dataDetailPictureArray: [DataDetailPicture] = []
    var dataDetailPicture: DataDetailPicture?

    func getLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.requestAlwaysAuthorization()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.first != nil {
            let locValue: CLLocationCoordinate2D = manager.location!.coordinate
            self.latitude = locValue.latitude
            self.longitude = locValue.longitude
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager, status: CLAuthorizationStatus) {
        if(status == CLAuthorizationStatus.denied) {
            self.presenter?.notifyDisabledPopUp()
        }
    }

    func setDataPictureDetail(dataPicture: DataPicture) {
        let image_id = dataPicture.images_id
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05, execute: {
            NetworkAdapter.request(target: .showData(id: image_id, lat: self.latitude ?? 0, lng: self.longitude ?? 0, type: "json"),
                success: { (response) in
                    do {
                        if let jsonObj = try response.mapJSON() as? NSDictionary {
                            if let jsonObjData = jsonObj["data"] as? [NSDictionary] {
                                jsonObjData.forEach { result in
                                    self.dataDetailPicture = DataDetailPicture.from(result)
                                    self.dataDetailPictureArray.append(self.dataDetailPicture!)
                                }
                                
                                self.presenter?.getDataPictureDetail(pictureDetailData: self.dataDetailPictureArray)
                            }
                        }
                    } catch {
                            print("error")
                    }
                })
                { (error) in
                    print(error)
                }
        })
    }
}