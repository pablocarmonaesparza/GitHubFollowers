//
//  UIViewController+.swift
//  GitHubFollowers
//
//  Created by Pablo Carmona Esparza on 12/20/22.
//

import UIKit

extension UIViewController {
    
    func presentGitHubFollowersAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            
            let alertVC = AlertViewController(title: title, message: message, buttonTitle: buttonTitle)
            
            alertVC.modalPresentationStyle  = .overFullScreen
            alertVC.modalTransitionStyle    = .crossDissolve
            
            self.present(alertVC, animated: true)
        }
    }
    
}
