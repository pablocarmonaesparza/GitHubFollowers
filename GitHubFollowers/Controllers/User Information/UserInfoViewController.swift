//
//  UserInfoViewController.swift
//  GitHubFollowers
//
//  Created by Pablo Carmona Esparza on 1/23/23.
//

import UIKit

protocol UserInfoVCDelegate: class {
    func didTapGitHubPorfile(for user: UserModel)
    func didTapGetFollowers(for user: UserModel)
}

class UserInfoViewController: UIViewController {
    
    let headerView  = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    
    let dateLabel   = GitHubFollowersBodyLabel(textAlingment: .center, font: .body)
    
    var itemViews: [UIView] = []
    var username : String!
    
    weak var delegate: FollowerListVCDelegate!

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        configureViewController()
        layoutUI()
        getUserInfo()
        
    }
    
    
    func configureViewController() {
        
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        
    }
    
    
    func getUserInfo() {
        
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async { self.configureUIElements(with: user) }
            case .failure(let error):
                self.presentGitHubFollowersAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
        
    }
    
    
    func configureUIElements(with user: UserModel) {
        
        let repoItemVC          = GitHubFollowersRepoItemViewController(user: user)
        repoItemVC.delegate     = self
        
        let followerItemVC      = GitHubFollowersItemViewController(user: user)
        followerItemVC.delegate = self
        
        self.add(childVC: repoItemVC, to: self.itemViewOne)
        self.add(childVC: followerItemVC, to: self.itemViewTwo)
        self.dateLabel.text = "GitHub since \(user.createdAt.convertToDisplayFormat())"
        self.add(childVC: GitHubFollowersUserInfoHeaderViewController(user: user), to: self.headerView)
        
    }
    
    
    func layoutUI() {
        
        let padding     : CGFloat = 20
        let itemHeight  : CGFloat = 140
        
        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        
        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }
    
        NSLayoutConstraint.activate([
        
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
            
        ])
    }
    
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}

extension UserInfoViewController: UserInfoVCDelegate {
    
    func didTapGitHubPorfile(for user: UserModel) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGitHubFollowersAlertOnMainThread(title: "Invalid URL", message: "The url attached to this user is invalid.", buttonTitle: "Ok")
            return
        }
        
        presentSafariVC(with: url)
        
    }
    
    func didTapGetFollowers(for user: UserModel) {
        
        guard user.followers != 0 else {
            presentGitHubFollowersAlertOnMainThread(title: "No followers", message: "This user has no followers. What a shame 🥲", buttonTitle: "So sad")
            return
        }
        
        delegate.didRequestFollowers(for: user.login)
        dismissVC()
    }
}
