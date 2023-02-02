//
//  GitHubFollowersItemInfoViewController.swift
//  GitHubFollowers
//
//  Created by Pablo Carmona Esparza on 1/31/23.
//

import UIKit

class GitHubFollowersItemInfoViewController: UIViewController {
    
    
    let stackView       = UIStackView()
    let itemInfoViewOne = GitHubFollowersItemInfoView()
    let itemInfoViewTwo = GitHubFollowersItemInfoView()
    let actionButton    = GitHubFollowersButton()
    
    var user: UserModel!
    weak var delegate: UserInfoVCDelegate! 
    
    init(user: UserModel) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        configureBackgroundView()
        layoutUI()
        configureStackView()
        configureActionButton()
        
    }
    
    
    private func configureBackgroundView() {
        
        view.layer.cornerRadius = 18
        view.backgroundColor    = .secondarySystemBackground
        
    }
    
    
    private func configureActionButton() {
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    @objc func actionButtonTapped() {}
    
    
    private func layoutUI() {
        
        view.addSubview(stackView)
        view.addSubview(actionButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
            
        ])
    }
    
    
    private func configureStackView() {
        
        stackView.axis          = .horizontal
        stackView.distribution  = .equalSpacing
        
        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)
        
    }

}
