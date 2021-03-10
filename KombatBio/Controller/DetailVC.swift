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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var fandomButton: UIButton!
    
    private var playerLayer = AVPlayerLayer()
    private var playerLooper : AVPlayerLooper?
    
    var audioQueueStallObserver : Any?
    
    var videoURL: URL?
    var selectedFighter: Characters?
    
    let segueID = "goToFinishersVC"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fandomButton.layer.borderColor = UIColor.white.cgColor
        fandomButton.layer.borderWidth = 1
        configureView()
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
            audioQueueStallObserver = player.observe(\.timeControlStatus, options: [.new, .old], changeHandler: { [weak self]
                (playerItem, change)  in
                if #available(iOS 10.0, *) {
                    switch (playerItem.timeControlStatus) {
                    case AVPlayerTimeControlStatus.paused:
                        self?.activityIndicator.isHidden = false
                    case AVPlayerTimeControlStatus.playing:
                        self?.activityIndicator.isHidden = true
                        print("Media Playing")
                    case AVPlayerTimeControlStatus.waitingToPlayAtSpecifiedRate:
                        self?.activityIndicator.isHidden = false
                    }
                }
                else {
                    // Fallback on earlier versions
                }
            })
        }
    }
    
    //TODO: implement MMVM
    func configureView() {
        if let selectedFigher = selectedFighter, let imageURL = URL(string: selectedFigher.fullSizeImageURL) {
            fighterImage.kf.setImage(with: imageURL)
            videoURL = URL(string: selectedFigher.introVideo)
            fighterName.text = selectedFigher.name
            fighterMotto.text = selectedFigher.motto
            fighterDescription.text = selectedFigher.description
        }
        
    }
  
    @IBAction func fandomButtonTapped(_ sender: UIButton) {
        if let fandomURL = selectedFighter?.fandomURL, let url = URL(string: fandomURL) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func finishersButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: segueID, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueID {
            guard let destinationVC = segue.destination as? FinishersVC else {return}
            let endingVideoID = selectedFighter?.storyEndingVideoID
            let fighterName = selectedFighter?.name
            let comboVideoID = selectedFighter?.comboVideoID
            let finisherVideoID = selectedFighter?.finisherVideoID
            
            destinationVC.endingVideoID = endingVideoID
            destinationVC.fighterName = fighterName
            destinationVC.combovideoID = comboVideoID
            destinationVC.finisherVideoID = finisherVideoID
        }
    }
    
}
