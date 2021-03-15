//
//  CollectionViewVC.swift
//  KombatBio
//
//  Created by Mikhail Kisly on 24.02.21.
//

import UIKit

class CollectionViewVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel: ICollectionViewViewModel?
    
    private let segueID = "fromGridToDetail"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = createLayout()
        collectionView.register(UINib(nibName: CollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: CollectionViewCell.cellID)
//        viewModel = CollectionViewVM()
//        viewModel?.fetchFightersModelFirebase()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = CollectionViewVM()
        viewModel?.fetchFightersModelFirebase {[weak self] in
            self?.collectionView.reloadData()
        }
    }
}

//MARK: CollectionView DataSource and Delegate
extension CollectionViewVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.fighterModel.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.cellID, for: indexPath) as? CollectionViewCell else { return UICollectionViewCell()}
        viewModel?.configureCell(forIndexPath: indexPath, cell: cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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

extension CollectionViewVC {
    /// - Tag: Grid
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
