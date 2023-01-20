//
//  SearchViewController.swift
//  GitHubFollowers
//
//  Created by Pablo Carmona Esparza on 12/19/22.
//

import UIKit
import SwiftUI

class SearchViewController: UIViewController {
    
//    #warning("Change this")
//    #error("Switch this")
    
    // MARK: Contsantes & Variables -
    let logoImageView      = UIImageView()
    let usernameTextField  = GitHubFollowersTextField()
    let callToActionButton = GitHubFollowersButton(backgroundColor: .systemGreen, title: "Get Followers")
    var isUsernameEntered: Bool { return !usernameTextField.text!.isEmpty } 
    
    // Se ejecuta solo la primera vez
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
        createDismissKeyboardtapGresture()
        
    }
    
    // Se ejecuta cada vez que se llama
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    // MARK: Logo (Configuración & Posición) -
    func configureLogoImageView() {
        // Con este comando se agrega a la view
        view.addSubview(logoImageView)
        
        logoImageView.image = UIImage(named: "gh-logo")!
        
        // Localización del item en la pantalla
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        // Con este comando autorizas el autocontraints
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: Textfield (Configuración & Posición) -
    func configureTextField() {
        // Con este comando se agrega a la view
        view.addSubview(usernameTextField)
        
        //Esta escuchando a la extension
        usernameTextField.delegate = self
        
        // Localización del item en la pantalla
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: Button (Configuración & Posición) -
    func configureCallToActionButton() {
        // Con este comando se agrega a la view
        view.addSubview(callToActionButton)
        
        // Este comando activa el boton
        callToActionButton.addTarget(self, action: #selector(pushFollowerListViewController), for: .touchUpInside)
        
        // Localización del item en la pantalla
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    // MARK: Dismiss Keyboard (Acción) -
    func createDismissKeyboardtapGresture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    // MARK: Push New Screen (Acción) -
    @objc func pushFollowerListViewController() {
        
        guard isUsernameEntered else {
            presentGitHubFollowersAlertOnMainThread(title: "Empty Username", message: "Please enter a username. We need to know who to look for. 🤠", buttonTitle: "Ok")
            return
        }
        
        let followerListVC = FollowerListViewController()
        
        followerListVC.username = usernameTextField.text
        followerListVC.title    = usernameTextField.text
        
        // Este comando pone hasta arriba esta vista
        navigationController?.pushViewController(followerListVC, animated: true)
    }
    
}

// MARK: Return Keyboard Button (Extensión) -
extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListViewController()
        return true
    }
}




// MARK: Crating Preview -
struct SearchView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> SearchViewController { return SearchViewController() }
    func updateUIViewController(_ uiViewController: SearchViewController, context: Context) {}
    typealias UIViewControllerType = SearchViewController
}
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView().edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            .preferredColorScheme(.light)
    }
}
