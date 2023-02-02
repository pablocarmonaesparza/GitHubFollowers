//
//  GitHubFollowersItemViewController.swift
//  GitHubFollowers
//
//  Created by Pablo Carmona Esparza on 1/31/23.
//

import UIKit

class GitHubFollowersItemViewController: GitHubFollowersItemInfoViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
    
    
}
