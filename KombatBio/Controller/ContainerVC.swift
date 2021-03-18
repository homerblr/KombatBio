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
        self.title = "Choose your fighter"
        navigationItem.rightBarButtonItem = UIBarButtonItem.menuButton(self, action: #selector(presentSettings), imageName: "settings")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Choose your fighter"
    }
    
    @objc func presentSettings() {
        let settingsVC = story.instantiateViewController(identifier: "settingsVC")
        navigationController?.pushViewController(settingsVC, animated: true)
        navigationItem.title = "Fighters"
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


extension UIBarButtonItem {

    static func menuButton(_ target: Any?, action: Selector, imageName: String) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFit

        let menuBarItem = UIBarButtonItem(customView: button)
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 24).isActive = true

        return menuBarItem
    }
}
