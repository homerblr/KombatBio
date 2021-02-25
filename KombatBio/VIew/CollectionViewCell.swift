//
//  CollectionViewCell.swift
//  KombatBio
//
//  Created by Mikhail Kisly on 24.02.21.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var fighterImage: UIImageView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var fighterName: UILabel!
    
    static let cellID = "CollectionViewCell"
    static let nibName = "CollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
}
