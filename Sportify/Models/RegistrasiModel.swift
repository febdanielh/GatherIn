//
//  RegistrasiModel.swift
//  Sportify
//
//  Created by Febrian Daniel on 19/03/24.
//

import Foundation

struct UserPayLoad: Codable, Hashable {
    var userID: UUID
    var email: String?
    var namaLengkap: String
    var noTelp: String
    var tanggalLahir: Date
    var jenisKelamin: String
}

struct AppUser: Codable {
    var userID: String
    var email: String?
    var namaLengkap: String
    var noTelp: String
    var tanggalLahir: Date
    var jenisKelamin: String
}


struct UserOlahraga: Codable {
    var userID: UUID
    var olahraga: [String]
    var skillLevel: [String]
}
