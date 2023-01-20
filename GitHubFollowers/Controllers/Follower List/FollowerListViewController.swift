//
//  FollowerListViewController.swift
//  GitHubFollowers
//
//  Created by Pablo Carmona Esparza on 12/19/22.
//

import UIKit
import SwiftUI

class FollowerListViewController: UIViewController {
    
    
    enum Section { case main }
    
    
// MARK: Contsantes & Variables -
    var username        : String!
    var followers       : [FollowerModel] = []
    var collectionView  : UICollectionView!
    var dataSource      : UICollectionViewDiffableDataSource<Section, FollowerModel>!
    
    
// MARK: Vista Fija (Se ejecuta solo la primera vez) -
    override func viewDidLoad() {
        super.viewDidLoad()
    // Funcion para obtener la lista
        configureCollectionView()
        configureViewController()
    // Funcion para obtener los Followers
        getFollowers()
    // Investigar función
        configureDataSource()
       
    }
    
    
// MARK: Vista Rehusable (Se ejecuta cada vez que se llama) -
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
// MARK: Base Vista -
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
// MARK: Base Lista -
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: FLColumnFlowLayoutVC.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowersCell.self, forCellWithReuseIdentifier: FollowersCell.reuseID)
    }
    


    
// MARK: Obtener Followers -
    func getFollowers() {
        NetworkManager.shared.getFollowers(for: username, page: 1) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case.success(let followers):
                self.followers = followers
                self.updateData()
            case.failure(let error):
                self.presentGitHubFollowersAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    
// MARK: INVESTIGAR -
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, FollowerModel>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowersCell.reuseID, for: indexPath) as! FollowersCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    
//MARK: Actualizar Data
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, FollowerModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }

}

extension FollowerListViewController: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let offseyY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        
        print("Offset Y = \(offseyY)")
        print("Content Height = \(contentHeight)")
        print("Height = \(height)")
        
    }
    
}


// MARK: Preview -
//struct FollowerListView: UIViewControllerRepresentable {
//    func makeUIViewController(context: Context) -> FollowerListViewController { return FollowerListViewController() }
//    func updateUIViewController(_ uiViewController: FollowerListViewController, context: Context) {}
//    typealias UIViewControllerType = FollowerListViewController
//}
//struct FollowerListView_Previews: PreviewProvider {
//    static var previews: some View {
//        FollowerListView().edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
//    }
//}
