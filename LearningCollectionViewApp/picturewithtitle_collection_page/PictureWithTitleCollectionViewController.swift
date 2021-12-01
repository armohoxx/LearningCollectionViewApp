//
//  PictureWithTitleCollectionViewController.swift
//  LearningCollectionViewApp
//
//  Created armyxx on 12/11/2564 BE.
//  Copyright © 2564 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class PictureWithTitleCollectionViewController: UIViewController, PictureWithTitleCollectionViewProtocol {

	var presenter: PictureWithTitleCollectionPresenterProtocol?
    let layout = UICollectionViewFlowLayout()
    let searchController = UISearchController(searchResultsController: nil)
    var searching = false
    var searchingMap = [DataPicture]()
    var picture: [DataPicture] = []
    
    //อ้างอิง collection view
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Map With Name"
        navigationController?.navigationBar.backgroundColor = .secondarySystemBackground
        
        layout.itemSize = CGSize(width: 200, height: 200)
        collectionView.collectionViewLayout = layout
        
        //register nib file ของ collection view cell
        collectionView.register(PictureWithTextCollectionViewCell.nib(), forCellWithReuseIdentifier: PictureWithTextCollectionViewCell.identifier)
        
        //ต้องกำหนด property นี้เสมอ
        collectionView.delegate = self
        collectionView.dataSource = self
        
        configureSearchController()
        self.presenter?.getDataFromInteractor()
    }
    
    private func configureSearchController() {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Search Map"
    }
    
    func showData(pictureData: [DataPicture]) {
        self.picture = pictureData
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension PictureWithTitleCollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let idItem = picture[indexPath.item].images_id
        let nameItem = picture[indexPath.item].images_name
        let fullimage = picture[indexPath.item].fullimage
        let thumbimage = picture[indexPath.item].thumbimage
        
        let dataPicture = DataPicture.init(images_id: idItem,
                                       images_name: nameItem,
                                       fullimage: fullimage,
                                      thumbimage: thumbimage)
        
        self.presenter?.notifyViewMapDetail(dataDetail: dataPicture)
    }
}

extension PictureWithTitleCollectionViewController: UICollectionViewDataSource, UISearchResultsUpdating, UISearchBarDelegate {
    
    //ระบุจำนวน cell ในกลุ่ม
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if searching {
            return searchingMap.count
        } else {
            //จำนวนข้อมูลในอาร์เรย์คือจำนวน cell
            return picture.count
        }
    }
    
    //กำหนดข้อมูลให้เเต่ละเซลล์
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PictureWithTextCollectionViewCell.identifier, for: indexPath) as! PictureWithTextCollectionViewCell
        
        if searching {
            cell.configure(with: searchingMap[indexPath.item])
        } else {
            //เเต่ละ cell เท่ากับ ข้อมูลใน array picture เเต่ละ row
            cell.configure(with: picture[indexPath.item])
        }
    
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        
        if !searchText.isEmpty {
            searching = true
            searchingMap.removeAll()
            for mapPicture in picture
            {
                if mapPicture.images_name!.lowercased().contains(searchText.lowercased())
                {
                    searchingMap.append(mapPicture)
                }
            }
        } else {
            searching = false
            searchingMap.removeAll()
            searchingMap = picture
        }
        collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchingMap.removeAll()
        collectionView.reloadData()
    }
}

//เป็นการกำหนดขนาดของ cell ที่จะเเสดงใน collection view
extension PictureWithTitleCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 400, height: 450)
    }
}