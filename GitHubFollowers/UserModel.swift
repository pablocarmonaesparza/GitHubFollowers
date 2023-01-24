//
//  UserModel.swift
//  GitHubFollowers
//
//  Created by Pablo Carmona Esparza on 12/28/22.
//

import Foundation

struct UserModel: Codable {
    
    let login       : String
    let avatarUrl   : String
    var name        : String?
    var location    : String?
    var bio         : String?
    let publicRepos : Int
    let publicGists : Int
    let htmlUrl     : String
    let following   : Int
    let followers   : Int
    let createdAt   : String
    
}
