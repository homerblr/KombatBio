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
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = createLayout()

//        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.cellID)
        collectionView.register(UINib(nibName: CollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: CollectionViewCell.cellID)
        viewModel = CollectionViewVM()
        viewModel?.fetchFightersModel()
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

}

extension CollectionViewVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.fighterModel.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.cellID, for: indexPath) as? CollectionViewCell else { return UICollectionViewCell()}
        
        viewModel?.configureCell(forIndexPath: indexPath, cell: cell)
        return cell
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
//extension CollectionViewVC: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let frameSize = collectionView.frame.size
//        return CGSize(width: frameSize.width, height: frameSize.height)
//    }
//}
