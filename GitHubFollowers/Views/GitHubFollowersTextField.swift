//
//  GitHubFollowersTextField.swift
//  GitHubFollowers
//
//  Created by Pablo Carmona Esparza on 12/19/22.
//

import UIKit

//BSP

class GitHubFollowersTextField: UITextField {
    
    // MARK: Base -
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    // MARK: Seguro -
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Personalización -
    private func configure() {
        
        layer.cornerRadius = 16
        layer.borderWidth  = 2
        layer.borderColor  = UIColor.systemGray4.cgColor
        
        textColor                   = .label
        tintColor                   = .label
        textAlignment               = .center
        font                        = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth   = true
        minimumFontSize             = 12
        
        backgroundColor     = .tertiarySystemBackground
        autocorrectionType  = .no
        keyboardType        = .default
        returnKeyType       = .go
        placeholder         = "Enter a username"
        
        translatesAutoresizingMaskIntoConstraints = false
    }

}
