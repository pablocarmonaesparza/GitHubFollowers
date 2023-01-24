//
//  GitHubFollowersLabel.swift
//  GitHubFollowers
//
//  Created by Pablo Carmona Esparza on 12/20/22.
//

import UIKit

class GitHubFollowersLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlingment: NSTextAlignment, font: UIFont.TextStyle) {
        super.init(frame: .zero)
        self.textAlignment = textAlingment
        self.font          = UIFont.preferredFont(forTextStyle: font)
        configure()
    }
    
    private func configure() {
        
        textColor                   = .label
        adjustsFontSizeToFitWidth   = true
        minimumScaleFactor          = 0.90
        lineBreakMode               = .byTruncatingTail
        
        translatesAutoresizingMaskIntoConstraints = false
        
    }

}
