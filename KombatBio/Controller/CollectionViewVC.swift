//
//  CollectionViewVC.swift
//  KombatBio
//
//  Created by Mikhail Kisly on 24.02.21.
//

import UIKit

class CollectionViewVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel: CollectionViewVMProtocol?
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    private let segueID = "fromGridToDetail"
    
    var filteredFighters : [Characters]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = createLayout()
        collectionView.register(UINib(nibName: CollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: CollectionViewCell.cellID)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicator.startAnimating()
        viewModel = CollectionViewVM()
        searchBar.searchTextField.text = ""
        viewModel?.fetchFightersModelFirebase {[weak self] in
            self?.filteredFighters = self?.viewModel?.fighterModel
            self?.collectionView.reloadData()
            self?.activityIndicator.isHidden = true
        }
    }
}

//MARK: CollectionView DataSource and Delegate
extension CollectionViewVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredFighters?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.cellID, for: indexPath) as? CollectionViewCell else { return UICollectionViewCell()}
        viewModel?.configureCell(forIndexPath: indexPath, cell: cell, model: filteredFighters!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueID, sender: indexPath)
//        collectionView.keyboardDismissMode = .onDrag
        searchBar.endEditing(true)
    }
    
//MARK: Prepare for Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueID {
            guard let destinationVC = segue.destination as? DetailVC else { return }
            guard let row = (sender as? NSIndexPath)?.row else { return }
            let selectedFighter = filteredFighters?[row]
            destinationVC.selectedFighter = selectedFighter
        }
    }
}

extension CollectionViewVC {
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                             heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}


extension CollectionViewVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredFighters = []
        if searchText == "" {
            filteredFighters = viewModel?.fighterModel
        } else {
            for i in viewModel!.fighterModel {
                if i.name.lowercased().contains(searchText.lowercased()) {
                    filteredFighters?.append(i)
                }
            }
        }
        collectionView.reloadData()
        
    }
}
