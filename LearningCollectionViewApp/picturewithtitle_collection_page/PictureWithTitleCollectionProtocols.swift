//
//  PictureWithTitleCollectionProtocols.swift
//  LearningCollectionViewApp
//
//  Created armyxx on 12/11/2564 BE.
//  Copyright © 2564 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation
import UIKit
import Moya

//MARK: Wireframe -
protocol PictureWithTitleCollectionWireframeProtocol: class {
    func routeToMapDetailPage(dataDetail: DataPicture)
}

//MARK: Presenter -
protocol PictureWithTitleCollectionPresenterProtocol: class {
    func getData(pictureData: [DataPicture])
    func getDataFromInteractor()
    func notifyViewMapDetail(dataDetail: DataPicture)
}

//MARK: Interactor -
protocol PictureWithTitleCollectionInteractorProtocol: class {

    var presenter: PictureWithTitleCollectionPresenterProtocol?  { get set }
    func setData()
}

//MARK: View -
protocol PictureWithTitleCollectionViewProtocol: class {

    var presenter: PictureWithTitleCollectionPresenterProtocol?  { get set }
    func showData(pictureData: [DataPicture])
}
