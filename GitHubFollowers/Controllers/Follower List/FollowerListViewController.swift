//
//  FollowerListViewController.swift
//  GitHubFollowers
//
//  Created by Pablo Carmona Esparza on 12/19/22.
//

import UIKit
import SwiftUI

protocol FollowerListVCDelegate: class {
    func didRequestFollowers(for username: String)
}

class FollowerListViewController: UIViewController {
    
    
    enum Section { case main }
    
    
// MARK: Contsantes & Variables -
    var username            : String!
    var followers           : [FollowerModel] = []
    var filteredFollowers   : [FollowerModel] = []
    var collectionView      : UICollectionView!
    var dataSource          : UICollectionViewDiffableDataSource<Section, FollowerModel>!
    var page                : Int = 1
    var hasMoreFollowers    : Bool = true
    var isSearching         : Bool = false
    
    
// MARK: Vista Fija (Se ejecuta solo la primera vez) -
    override func viewDidLoad() {
        super.viewDidLoad()
    // Funcion para obtener la lista
        configureCollectionView()
        configureViewController()
        configureSearchController()
    // Funcion para obtener los Followers
        getFollowers(username: username, page: page)
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
    
    
    func configureSearchController() {
        let searchController                    = UISearchController()
        searchController.searchResultsUpdater   = self
        searchController.searchBar.delegate     = self
        searchController.searchBar.placeholder  = "Search for a username"
//        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController         = searchController
    }


    
// MARK: Obtener Followers -
    func getFollowers(username: String, page: Int) {
        
        showLoadingView()
        
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            
            guard let self = self else { return }
            
            self.dismissLoadingView()
            
            switch result {
            case.success(let followers):
                if followers.count < 100 { self.hasMoreFollowers = false }
                self.followers.append(contentsOf: followers)
                
                if self.followers.isEmpty {
                    let message = "This user doesn't have any followers. Go follow them 😄."
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: message, in: self.view)
                        return
                    }
                }
                self.updateData(on: self.followers)
                
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
    func updateData(on followers: [FollowerModel]) {
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
        
        if offseyY > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let activeArray         = isSearching ? filteredFollowers : followers
        let follower            = activeArray[indexPath.item]
        
        let destinationVC       = UserInfoViewController()
        destinationVC.username  = follower.login
        destinationVC.delegate  = self
        let navController       = UINavigationController(rootViewController: destinationVC)
        present(navController, animated: true)
    }
    
}



extension FollowerListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearching = true
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredFollowers)
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(on: followers)
    }
}

extension FollowerListViewController: FollowerListVCDelegate {
    
    func didRequestFollowers(for username: String) {
        self.username   = username
        title           = username
        page            = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        getFollowers(username: username, page: page)
    }
    
    
}
