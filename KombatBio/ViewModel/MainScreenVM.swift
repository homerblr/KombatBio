//
//  MainScreenVM.swift
//  KombatBio
//
//  Created by Mikhail Kisly on 23.02.21.
//

import UIKit
import Kingfisher

protocol IMainScreenViewModel {
    func fetchFightersModel()
    func configureCell(forIndexPath indexPath: IndexPath, cell: FighterCell)
    //var boxPhotoModel : Box<[PhotoObject]> {get}
    var fighterModel : [Characters] {get}
    var fighterProvider: DataProviderProtocol {get}
    //var loadingButtonBox: Box<ButtonState> {get}
}

class MainScreenViewModel: IMainScreenViewModel {

    var fighterModel : [Characters] = []
    var fighterProvider: DataProviderProtocol = DataProvider(loader: DataSource())
    
//    var boxPhotoModel: Box<[PhotoObject]> = Box([PhotoObject]())
//    let loadingButtonBox = Box<ButtonState>(.doingNothing)
    
    func fetchFightersModel() {
        //loadingButtonBox.value = .downloading
        fighterProvider.fetchFighters { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.fighterModel = response
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func configureCell(forIndexPath indexPath: IndexPath, cell: FighterCell) {
        let model = fighterModel[indexPath.row]
        cell.fighterImage.image = nil
        DispatchQueue.main.async {
            cell.fighterGender.text = "Gender: \(model.gender)"
            cell.fighterName.text = "Nickname: \(model.name)"
            cell.realName.text = "Real name: \(model.realName)"
            cell.fighterImage.kf.setImage(with: URL(string: model.thumbImageURL))
        }
    }
    
}
