//
//  GitHubFollowersButton.swift
//  GitHubFollowers
//
//  Created by Pablo Carmona Esparza on 12/19/22.
//

import UIKit

//BSIP

class GitHubFollowersButton: UIButton {
    
// MARK: Base -
    override init(frame: CGRect) {
        //Declare UI Button
        super.init(frame: frame)
        //Custom Code - We are building over a UI Button
        configure()
    }
    
// MARK: Seguro -
    // Declaración de que no esta con storyboard
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: Inicializador -
    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
// MARK: Personalización -
    private func configure() {
        
        layer.cornerRadius    = 16
        layer.borderColor     = UIColor.systemBackground.withAlphaComponent(0.15).cgColor
        layer.borderWidth     = 0
        layer.shadowColor     = UIColor.gray.cgColor
        layer.shadowOpacity   = 0
        layer.shadowRadius    = 0
        layer.shadowOffset    = CGSize(width: 0, height: 0)
        
        setTitleColor(.white, for: .normal)
        titleLabel?.font      = UIFont.preferredFont(forTextStyle: .headline)
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}


