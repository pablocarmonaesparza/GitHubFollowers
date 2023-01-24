//
//  GitHubFollowersError.swift
//  GitHubFollowers
//
//  Created by Pablo Carmona Esparza on 1/23/23.
//

import Foundation

import Foundation

// Raw Value       : todos los tipos del ENUM son iguales
// Associated Value: todos los tipos del ENUM son independientes

enum GitHubFollowersError: String, Error {
    
    case invalidUsername    = "This username created an invalid request. Please try agagin."
    case unableToComplete   = "Unable to complete your request. Please check your internet connection."
    case invalidResponse    = "Invalid response from the server. Please try again."
    case invalidData        = "The data received from the server was invalid. Please try again."
    
}
