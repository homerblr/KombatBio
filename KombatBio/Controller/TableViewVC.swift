//
//  ViewController.swift
//  KombatBio
//
//  Created by Mikhail Kisly on 23.02.21.
//

import UIKit
import Kingfisher

class TableViewVC: UIViewController {
    var fighter : [Characters] = []
    private var viewModel : TableViewVMProtocol?
    
    private let segueID = "goToDetail"
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: FighterCell.nibName, bundle: nil), forCellReuseIdentifier: FighterCell.cellID)
        viewModel = MainScreenViewModel()
        viewModel?.fetchFightersModelFirebase { [weak self] in
            self?.tableView.reloadData()
        }
    }
}


//MARK: TableView Data Source, Delegate
extension TableViewVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.fighterModel.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FighterCell.cellID, for: indexPath) as? FighterCell else {fatalError("fatal error at cellForRowAt indexPath tableview's method")}
        
        //viewModel?.configureCell(forIndexPath: indexPath, cell: cell)
        
        if let model = viewModel?.fighterModel[indexPath.row] {
            DispatchQueue.main.async {
                cell.fighterImage.image = nil
                cell.fighterMotto.text = model.motto.uppercased()
                cell.fighterName.text = model.name
                cell.fighterImage.kf.setImage(with: URL(string: model.fullSizeImageURL))
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueID, sender: indexPath)
    }
    
    
    //MARK: Prepare for Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueID {
            guard let destinationVC = segue.destination as? DetailVC else {return}
            guard let row = (sender as? NSIndexPath)?.row else {return}
            let selectedFighter = viewModel?.fighterModel[row]
            destinationVC.selectedFighter = selectedFighter
        }
    }
}

