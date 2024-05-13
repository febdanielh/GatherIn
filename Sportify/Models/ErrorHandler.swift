//
//  ErrorHandler.swift
//  Sportify
//
//  Created by Febrian Daniel on 12/05/24.
//

import Foundation

enum ErrorType: Error {
    case incomplete
    case disconnect
    case server
    
    var description: String {
        switch self {
        case .incomplete:
            return "Sorry, we couldn't retrieve users. \n Try again later."
        case .disconnect:
            return "Sorry, we couldn't retrieve users. \n Try again later."
        case .server:
            return "Sorry, we couldn't retrieve users. \n Try again later."
        }
    }
}
