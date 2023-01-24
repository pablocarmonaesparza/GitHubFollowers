//
//  NetworkManager.swift
//  GitHubFollowers
//
//  Created by Pablo Carmona Esparza on 1/2/23.
//

import UIKit


// MARK: Singleton -
class NetworkManager {
    
//Inicializando el Singleton
    static let shared   = NetworkManager()
    private let baseURL: String = "https://api.github.com/users/"
    let cache           = NSCache<NSString, UIImage>()
    
    private init() {}
    
    // MARK: Función para descarga (Followers) -
    func getFollowers(for username: String, page: Int, completed: @escaping (Result<[FollowerModel], GitHubFollowersError>) -> Void) {
        let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        
        //No existe lo que estamos buscando
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        
        //Se revisan las variables y se notifica del status/problema ó se procede
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            //No funcionó internet -> PROCEDEMOS
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            //No funciono el URL -> PROCEDEMOS
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            //No está vacío -> PROCEDEMOS
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            // MARK: Funcionamiento -> EJECUTAMOS
            do {
                let decoder = JSONDecoder()
                //Convertiremos Snake Case a Camel Case
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                //Decodificaremos la variable para obtener una lista de Follower Model, que obtendremos de la Data del URL Session
                let followers = try decoder.decode([FollowerModel].self, from: data)
                completed(.success(followers))
            } catch {
                //Si fracasa procedemos con este mensaje
                completed(.failure(.invalidData))
                
            }
        }
        //Esto empieza el network call
        task.resume()
    }
    
    // MARK: Función para descarga (Follower Info) -
    func getUserInfo(for username: String, completed: @escaping (Result<UserModel, GitHubFollowersError>) -> Void) {
        let endpoint = baseURL + "\(username)"
        
        //No existe lo que estamos buscando
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        
        //Se revisan las variables y se notifica del status/problema ó se procede
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            //No funcionó internet -> PROCEDEMOS
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            //No funciono el URL -> PROCEDEMOS
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            //No está vacío -> PROCEDEMOS
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            // MARK: Funcionamiento -> EJECUTAMOS
            do {
                let decoder = JSONDecoder()
                //Convertiremos Snake Case a Camel Case
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                //Decodificaremos la variable para obtener una lista de Follower Model, que obtendremos de la Data del URL Session
                let user = try decoder.decode(UserModel.self, from: data)
                completed(.success(user))
            } catch {
                //Si fracasa procedemos con este mensaje
                completed(.failure(.invalidData))
                
            }
        }
        //Esto empieza el network call
        task.resume()
    }
}
