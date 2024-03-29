//
//  DetailVC.swift
//  KombatBio
//
//  Created by Mikhail Kisly on 26.02.21.
//

import UIKit
import AVKit
import SafariServices
import GoogleMobileAds


class DetailVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var fighterImage: UIImageView!
    @IBOutlet weak var fighterName: UILabel!
    @IBOutlet weak var fighterMotto: UILabel!
    @IBOutlet weak var fighterDescription: UILabel!
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var fandomButton: UIButton!
    @IBOutlet weak var strengthLabel: UILabel!
    @IBOutlet weak var strength1: UILabel!
    @IBOutlet weak var strength2: UILabel!
    @IBOutlet weak var weaknessesLabel: UILabel!
    @IBOutlet weak var weakness1: UILabel!
    @IBOutlet weak var weakness2: UILabel!
    
    private var playerLayer = AVPlayerLayer()
    private var playerLooper : AVPlayerLooper?
    
    var audioQueueStallObserver : Any?
    
    var videoURL: URL?
    var selectedFighter: Characters?
    
    private let adMobID = "ca-app-pub-3155855996937060/5631423799"
    private let admobTestID = "ca-app-pub-3940256099942544/4411468910"
    
    private var interstitialAD : GADInterstitialAd?
    
    let finishersScreenSegueID = "goToFinishersVC"
    
    var detailVM : DetailScreenVMProtocol! {
        didSet {
            fighterName.text = detailVM.fighterName
            fighterMotto.text  = detailVM.fighterMotto
            fighterDescription.text = detailVM.fighterDescription
            strength1.text = detailVM.fighterStrength1
            strength2.text = detailVM.fighterStrength2
            weakness1.text = detailVM.fighterWeakness1
            weakness2.text = detailVM.fighterWeakness2
            fighterImage.kf.setImage(with: detailVM.fighterImageURL)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interstitialAD = createAD()
        interstitialAD?.fullScreenContentDelegate = self
        
        detailVM = DetailScreenVM(fighter: selectedFighter)
        playVideo(with: videoURL)
        fandomButton.layer.borderColor = UIColor.white.cgColor
        fandomButton.layer.borderWidth = 1
        
        if IAPManager.shared.isPurchased() {
            IAPManager.shared.hideAds()
        }
       
    }
    
    func playVideo(with url: URL?) {
        if let introURL = selectedFighter?.introVideo, let url = URL(string: introURL) {
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
                switch (playerItem.timeControlStatus) {
                case AVPlayerTimeControlStatus.paused:
                    self?.activityIndicator.isHidden = false
                case AVPlayerTimeControlStatus.playing:
                    self?.activityIndicator.isHidden = true
                    print("Media Playing")
                case AVPlayerTimeControlStatus.waitingToPlayAtSpecifiedRate:
                    self?.activityIndicator.isHidden = false
                }
            })
        }
    }
    
    func presentAd() {
        if !IAPManager.shared.isPurchased() {
            interstitialAD?.present(fromRootViewController: self)
        }
        
    }
    
    @IBAction func fandomButtonTapped(_ sender: UIButton) {
        if let fandomURL = selectedFighter?.fandomURL, let url = URL(string: fandomURL) {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func finishersButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: finishersScreenSegueID, sender: self)
        let timerForAds = Int.random(in: 0..<2)
        if timerForAds % 2 == 0 && interstitialAD != nil {
            presentAd()
        }
    }
    

    
    //MARK: Prepare for Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == finishersScreenSegueID {
            guard let destinationVC = segue.destination as? FinishersVC else {return}
            if let selectedFighter = selectedFighter {
                destinationVC.finishersID = .init(endingVideoID: selectedFighter.storyEndingVideoID, combovideoID: selectedFighter.comboVideoID, fighterName: selectedFighter.name, finisherVideoID: selectedFighter.finisherVideoID)
            }
        }
    }
    
}

extension DetailVC: GADFullScreenContentDelegate {
    
    //TODO: Change AdMob ID before release
    
    private func createAD() -> GADInterstitialAd {
        let ad = GADInterstitialAd()
        GADInterstitialAd.load(withAdUnitID: admobTestID, request: GADRequest()) { (ad, error) in
            if let error = error {
                print("Found an error while creating ad \(error)")
            } else {
                self.interstitialAD = ad
            }
        }
        return ad
    }
}
