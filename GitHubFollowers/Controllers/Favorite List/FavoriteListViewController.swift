//
//  FavoriteListViewController.swift
//  GitHubFollowers
//
//  Created by Pablo Carmona Esparza on 12/19/22.
//

import UIKit
import SwiftUI

class FavoriteListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBlue
    }
}

// MARK: Creating Preview -
struct FavoriteListView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> FavoriteListViewController { return FavoriteListViewController() }
    func updateUIViewController(_ uiViewController: FavoriteListViewController, context: Context) {}
    typealias UIViewControllerType = FavoriteListViewController
}

struct FavoriteListView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteListView().edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}
