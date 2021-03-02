//
//  DetailVC.swift
//  KombatBio
//
//  Created by Mikhail Kisly on 26.02.21.
//

import UIKit
import AVKit
import Kingfisher

class DetailVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var fighterImage: UIImageView!
    @IBOutlet weak var fighterName: UILabel!
    @IBOutlet weak var fighterMotto: UILabel!
    @IBOutlet weak var fighterDescription: UILabel!
    @IBOutlet weak var playerView: UIView!
    
    private var playerLayer = AVPlayerLayer()
    private var playerLooper : AVPlayerLooper?
    var videoURL: URL?
    var selectedFighter: Characters?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        playVideo()
    }
    
    func playVideo() {
        if let url = videoURL {
            let playerItem = AVPlayerItem(url: url)
            let player = AVQueuePlayer(playerItem: playerItem)
            playerLayer.player = player
            playerLayer.videoGravity = .resizeAspectFill
            playerView.layer.addSublayer(playerLayer)
            playerLooper = AVPlayerLooper(player: player, templateItem: playerItem)
            playerLayer.frame = playerView.bounds
            player.play()
        }
    
    }
    func configureView() {
       
        if let selectedFigher = selectedFighter, let imageURL = URL(string: selectedFigher.fullSizeImageURL) {
            fighterImage.kf.setImage(with: imageURL)
            videoURL = URL(string: selectedFigher.introVideo)
            fighterName.text = selectedFigher.name
            fighterMotto.text = selectedFigher.motto
            fighterDescription.text = selectedFigher.description
        }
       
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
