//
//  FinishersVC.swift
//  KombatBio
//
//  Created by Mikhail Kisly on 4.03.21.
//

import UIKit
import youtube_ios_player_helper

struct finishersVideosID {
    var endingVideoID: String
    var combovideoID: String
    var fighterName: String
    var finisherVideoID: String
}

class FinishersVC: UIViewController {
    
    @IBOutlet weak var endingView: YTPlayerView!
    @IBOutlet weak var comboView: YTPlayerView!
    @IBOutlet weak var fatalityView: YTPlayerView!
    
    var finishersID : finishersVideosID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.standardAppearance.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
        setIDForYoutube()
    }
    
    func setIDForYoutube() {
        if let finishersID = finishersID {
            endingView.load(withVideoId: finishersID.endingVideoID)
            comboView.load(withVideoId: finishersID.combovideoID)
            fatalityView.load(withVideoId: finishersID.finisherVideoID)
            self.title = finishersID.fighterName
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.standardAppearance.titlePositionAdjustment = UIOffset(horizontal: -110, vertical: 0)
    }
}
