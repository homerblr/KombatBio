//
//  FinishersVC.swift
//  KombatBio
//
//  Created by Mikhail Kisly on 4.03.21.
//

import UIKit
import youtube_ios_player_helper

class FinishersVC: UIViewController {
    
    @IBOutlet weak var endingView: YTPlayerView!
    @IBOutlet weak var comboView: YTPlayerView!
    @IBOutlet weak var fatalityView: YTPlayerView!
    
    var endingVideoID: String?
    var combovideoID: String?
    var fighterName: String?
    var finisherVideoID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.standardAppearance.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
        setIDForYoutube()
    }
    
    func setIDForYoutube() {
        if let endingVideoId = endingVideoID, let combovideoID = combovideoID,  let fighterName = fighterName, let finisherVideoID = finisherVideoID {
            endingView.load(withVideoId: endingVideoId)
            comboView.load(withVideoId: combovideoID)
            fatalityView.load(withVideoId: finisherVideoID)
            self.title = fighterName
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.standardAppearance.titlePositionAdjustment = UIOffset(horizontal: -110, vertical: 0)
    }
}
