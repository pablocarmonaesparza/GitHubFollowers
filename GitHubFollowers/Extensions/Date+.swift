//
//  Date+.swift
//  GitHubFollowers
//
//  Created by Pablo Carmona Esparza on 2/1/23.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
    
}
