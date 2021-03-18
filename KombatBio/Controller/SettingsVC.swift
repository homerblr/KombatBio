//
//  SettingsVC.swift
//  KombatBio
//
//  Created by Mikhail Kisly on 17.03.21.
//

import UIKit

class SettingsVC: UIViewController {
    
    let model = ["Remove ads","Restore purchase","Rate app","About app","About developer"]

    let story = UIStoryboard(name: "Main", bundle: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
 navigationController?.navigationBar.standardAppearance.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.standardAppearance.titlePositionAdjustment = UIOffset(horizontal: -110, vertical: 0)
    }
}


extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath)
        cell.textLabel?.text = model[indexPath.row]
    return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToSelected(indexPath: indexPath.row)
    }
    
    func goToSelected(indexPath row: Int) {
        var rowNumber = 0// УБРАТЬ
        var selectedVC = UIViewController()
        switch row {
        case 0:
            rowNumber = 0
            //selectedVC = story.instantiateViewController(identifier: storyBoardID.removeAds.rawValue)
        case 1:
            rowNumber = 1
            //selectedVC = story.instantiateViewController(identifier: storyBoardID.restorePurchase.rawValue)
        case 2:
            rowNumber = 2
            //selectedVC = story.instantiateViewController(identifier: storyBoardID.rateApp.rawValue)
        case 3:
            rowNumber = 3
            selectedVC = story.instantiateViewController(identifier: storyBoardID.aboutApp.rawValue)
            navigationController?.pushViewController(selectedVC, animated: true)
        case 4:
            rowNumber = 4
            selectedVC = story.instantiateViewController(identifier: storyBoardID.aboutDev.rawValue)
            navigationController?.pushViewController(selectedVC, animated: true)
        default:
            break
        }
    }
    
    enum storyBoardID: String {
        case aboutDev
        case aboutApp
        case rateApp
        case removeAds
        case restorePurchase
    }
}
