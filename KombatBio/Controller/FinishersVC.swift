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
   
        
        if let endingVideoId = endingVideoID, let combovideoID = combovideoID,  let fighterName = fighterName, let finisherVideoID = finisherVideoID {
            endingView.load(withVideoId: endingVideoId)
            comboView.load(withVideoId: combovideoID)
            fatalityView.load(withVideoId: finisherVideoID)
            self.title = fighterName
        }
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
