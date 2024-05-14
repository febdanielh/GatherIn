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
            return "Email dan password perlu diisi. \n Coba lagi."
        case .disconnect:
            return "Maaf, koneksi terputus. Silahkan periksa koneksi Anda dan coba lagi."
        case .server:
            return "Email atau password salah. \n Coba lagi."
        }
    }
}
