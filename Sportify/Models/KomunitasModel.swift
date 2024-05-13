//
//  KomunitasModel.swift
//  Sportify
//
//  Created by Febrian Daniel on 01/04/24.
//

import Foundation

struct KomunitasPayLoad: Codable {
    var komunitasID = UUID()
    var created_at: Date
    var namaKomunitas: String
    var deskripsiKomunitas: String
    var olahragaKomunitas: String
    var lokasiKomunitas: String
    var fotoKomunitas: String?
    var ownerID: UUID
    //    let anggota: [UserPayLoad] -> array of users, append ke sini setiap add user (?)
}

struct DetailKomunitasPayload: Codable {
    var komunitasID: UUID
    var userID: UUID
}
