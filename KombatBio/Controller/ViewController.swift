//
//  ViewController.swift
//  KombatBio
//
//  Created by Mikhail Kisly on 23.02.21.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    var fighter : [CharacterDetail] = []
    var viewModel : IMainScreenViewModel?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: FighterCell.nibName, bundle: nil), forCellReuseIdentifier: FighterCell.cellID)
        viewModel = MainScreenViewModel()
        viewModel?.fetchFightersModel()
    }

    
}
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.fighterModel.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FighterCell.cellID, for: indexPath) as? FighterCell else {return UITableViewCell()}
        
        viewModel?.configureCell(forIndexPath: indexPath, cell: cell)
        
        return cell
    }
    
    
}

