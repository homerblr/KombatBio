//
//  CollectionViewVM.swift
//  KombatBio
//
//  Created by Mikhail Kisly on 24.02.21.
//

import UIKit
import Kingfisher


protocol ICollectionViewViewModel {
    func fetchFightersModel()
    func fetchFightersModelFirebase(completion: @escaping ()->())
    func configureCell(forIndexPath indexPath: IndexPath, cell: CollectionViewCell)
    var fighterModel : [Characters] {get}
    var fighterProvider: DataProviderProtocol {get}
}

class CollectionViewVM: ICollectionViewViewModel {
  
    var fighterModel: [Characters] = []
    var fighterProvider: DataProviderProtocol = DataProvider(loader: DataSource())
    
    
    func fetchFightersModel() {
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
    
    func configureCell(forIndexPath indexPath: IndexPath, cell: CollectionViewCell) {
        let model = fighterModel[indexPath.row]
        cell.fighterImage.image = nil
        cell.layer.borderColor = UIColor.cellBorderColor.cgColor
        cell.layer.borderWidth = 1
        DispatchQueue.main.async {
            cell.fighterName.text = model.name
            cell.fighterImage.kf.setImage(with: URL(string: model.thumbImageURL))
        }
    }
    
    
}
