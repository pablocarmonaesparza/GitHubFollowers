//
//  UserModel.swift
//  GitHubFollowers
//
//  Created by Pablo Carmona Esparza on 12/28/22.
//

import Foundation

struct UserModel: Codable {
    
    var login       : String
    var avatarUrl   : String
    var name        : String?
    var location    : String?
    var bio         : String?
    var publicRepos : Int
    var publicGists : Int
    var htmlUrl     : String
    var following   : Int
    var followers   : Int
    var createdAt   : String
    
}
