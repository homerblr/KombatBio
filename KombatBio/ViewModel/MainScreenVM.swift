//
//  MainScreenVM.swift
//  KombatBio
//
//  Created by Mikhail Kisly on 23.02.21.
//

import UIKit
import Kingfisher

protocol IMainScreenViewModel {
    func fetchFightersModelLocally()
    func configureCell(forIndexPath indexPath: IndexPath, cell: FighterCell)
    func fetchFightersModelFirebase(completion: @escaping ()->())
    var fighterModel : [Characters] {get}
    var fighterProvider: DataProviderProtocol {get}
}

class MainScreenViewModel: IMainScreenViewModel {

    var fighterModel : [Characters] = []
    var fighterProvider: DataProviderProtocol = DataProvider(loader: DataSource())
    
    
    func fetchFightersModelLocally() {
        fighterProvider.fetchFightersLocally { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.fighterModel = response
           
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchFightersModelFirebase(completion: @escaping ()->()) {
        fighterProvider.fetchFightersFirebase { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.fighterModel = response
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func configureCell(forIndexPath indexPath: IndexPath, cell: FighterCell) {
        let model = fighterModel[indexPath.row]
        cell.fighterImage.image = nil
        DispatchQueue.main.async {
            cell.fighterName.text = model.name
            cell.fighterMotto.text = model.motto.uppercased()
            cell.fighterImage.kf.setImage(with: URL(string: model.fullSizeImageURL))
        }
    }
    
}
