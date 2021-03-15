//
//  ContainerVC.swift
//  KombatBio
//
//  Created by Mikhail Kisly on 25.02.21.
//

import UIKit
import SwiftyGif


class ContainerVC: UIViewController {
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    let story = UIStoryboard(name: "Main", bundle: nil)
    lazy var gridVC = story.instantiateViewController(identifier: "gridVC")
    lazy var tableViewVC = story.instantiateViewController(identifier: "tableViewVC")
    let logoAnimationView = LogoAnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(logoAnimationView)
        logoAnimationView.pinEdgesToSuperView()
        logoAnimationView.logoGifImageView.delegate = self
        setupChildViews()
        self.title = "Loading fighters..."
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logoAnimationView.logoGifImageView.startAnimatingGif()
        
    }
    
    private func setupChildViews() {
        addChild(gridVC)
        addChild(tableViewVC)
        container.addSubview(gridVC.view)
        container.addSubview(tableViewVC.view)
        gridVC.didMove(toParent: self)
        tableViewVC.didMove(toParent: self)
        gridVC.view.frame = container.bounds
        tableViewVC.view.frame = container.bounds
        //        let constraints = [NSLayoutConstraint(item: tableViewVC.view, attribute: .leading, relatedBy: .equal, toItem: <#T##Any?#>, attribute: <#T##NSLayoutConstraint.Attribute#>, multiplier: 1.0, constant: <#T##CGFloat#>)]
        gridVC.view.isHidden = false
        tableViewVC.view.isHidden = true
    }
    
    @IBAction func segmentedControlTapped(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            gridVC.view.isHidden = false
            tableViewVC.view.isHidden = true
        case 1:
            tableViewVC.view.isHidden = false
            gridVC.view.isHidden = true
        default:
            break
        }
    }
}

extension ContainerVC: SwiftyGifDelegate {
    func gifDidStop(sender: UIImageView) {
        logoAnimationView.isHidden = true
        self.title = "Choose your fighter"
    }
}


extension UIView {
    func pinEdgesToSuperView() {
        guard let superView = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        leftAnchor.constraint(equalTo: superView.leftAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        rightAnchor.constraint(equalTo: superView.rightAnchor).isActive = true
    }
}
