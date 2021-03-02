//
//  ContainerVC.swift
//  KombatBio
//
//  Created by Mikhail Kisly on 25.02.21.
//

import UIKit

class ContainerVC: UIViewController {

    
    @IBOutlet weak var container: UIView!
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    let story = UIStoryboard(name: "Main", bundle: nil)

    lazy var gridVC = story.instantiateViewController(identifier: "gridVC")
    lazy var tableViewVC = story.instantiateViewController(identifier: "tableViewVC")
        

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
       
       
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
    
    private func setup() {
       
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

@nonobjc extension UIViewController {
    func add(_ child: UIViewController, frame: CGRect? = nil) {
        addChild(child)

        if let frame = frame {
            child.view.frame = frame
        }

        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
