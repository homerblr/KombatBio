//
//  FighterCell.swift
//  KombatBio
//
//  Created by Mikhail Kisly on 23.02.21.
//

import UIKit

class FighterCell: UITableViewCell {
    
    @IBOutlet weak var fighterName: UILabel!
    @IBOutlet weak var realName: UILabel!
    @IBOutlet weak var fighterGender: UILabel!
    
    @IBOutlet weak var fighterImage: UIImageView!
    
    static let cellID = "FighterCell"
    static let nibName = "FighterCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
