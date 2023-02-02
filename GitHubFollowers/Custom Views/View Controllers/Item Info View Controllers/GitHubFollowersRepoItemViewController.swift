//
//  GitHubFollowersRepoItemViewController.swift
//  GitHubFollowers
//
//  Created by Pablo Carmona Esparza on 1/31/23.
//

import UIKit

class GitHubFollowersRepoItemViewController: GitHubFollowersItemInfoViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
    
    
    override func actionButtonTapped() {
        delegate.didTapGitHubPorfile(for: user)
    }
    
}
