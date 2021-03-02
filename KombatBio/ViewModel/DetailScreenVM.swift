//
//  DetailScreenVM.swift
//  KombatBio
//
//  Created by Mikhail Kisly on 2.03.21.
//

import UIKit
import Kingfisher

class DetailScreenVM {
    
    var fighterModel: [Characters] = []
    var fighterProvider: DataProviderProtocol
    
//    func configureView(fighterName: String, fighterMotto: String, fighterImage: UIImageView, indexPath: IndexPath) {
//        
//        let model = fighterModel[indexPath.row]
//        fighterName = model.name
//        fighterMotto = model.motto
//        fighterImage.kf.setImage(with: URL(string: model.fullSizeImageURL))
//        
//        
//    }
    
    
    
    
    init(fighterProvider: DataProviderProtocol) {
        self.fighterProvider = DataProvider(loader: DataSource())
        
    }
}
