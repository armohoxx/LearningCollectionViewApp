//
//  MapDetailPageViewController.swift
//  LearningCollectionViewApp
//
//  Created armyxx on 25/11/2564 BE.
//  Copyright © 2564 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import Kingfisher

class MapDetailPageViewController: UIViewController, MapDetailPageViewProtocol {

	var presenter: MapDetailPagePresenterProtocol?
    var pictureDetail: [DataDetailPicture] = []
    var picture: String?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
	override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(MapDetailTableViewCell.nib(), forCellReuseIdentifier: "MapDetailTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        self.presenter?.getLocationDatafromInteractor()
    }
    
    func downloadImage(with pictureData: DataDetailPicture) {

        guard let urlImages = URL(string: pictureData.thumbimage ?? "") else { return }

        self.imageView.kf.setImage(with: urlImages) { result in
            switch result {
            case .success(let value):
                DispatchQueue.main.async {
                    self.imageView.image = value.image
                    self.imageView.contentMode = .scaleToFill
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error)
                }
            }
        }
    }
    
    func showData(dataPictureDetail: [DataDetailPicture]) {
        self.pictureDetail = dataPictureDetail
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showLocationDisabledPopUp() {
        let alertController = UIAlertController(title: "Background Location Access Disabled",
                                                message: "The app need location !!!",
                                                preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: nil)
        
        alertController.addAction(cancelAction)
        
        let openSettingAction = UIAlertAction(title: "Setting",
                                              style: .default) { (action) in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        
        alertController.addAction(openSettingAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension MapDetailPageViewController: UITableViewDelegate {
    
}

extension MapDetailPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictureDetail.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "รายละเอียดเส้นทางลัด"
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MapDetailTableViewCell.identifier, for: indexPath) as! MapDetailTableViewCell
        
        cell.configure(with: pictureDetail[indexPath.item])
        self.downloadImage(with: pictureDetail[indexPath.item])
        
//        print(pictureDetail[indexPath.item].longitude)
//        print(pictureDetail[indexPath.item].latitude)
//        print(pictureDetail[indexPath.item].distants)
        
        return cell
    }
}
