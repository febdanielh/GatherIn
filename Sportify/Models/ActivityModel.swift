//
//  ActivityModel.swift
//  Sportify
//
//  Created by Febrian Daniel on 20/03/24.
//

import Foundation

struct ActivityPayLoad: Codable {
    var aktivitasID = UUID()
    var created_at: Date
    var namaAktivitas: String
    var deskripsiAktivitas: String
    var lokasiAktivitas: String
    var waktuAktivitas: Date
    var olahragaAktivitas: String
    var jenisAktivitas: String
    var prefKemampuanAktivitas: String
    var jumlahPesertaAktivitas: Int
    var biayaAktivitas: Int
    var hostID: UUID
    var komunitasID: UUID?
}

struct ActivityReadPayLoad: Codable, Hashable {
    var aktivitasID: UUID
    var created_at: Date
    var namaAktivitas: String
    var deskripsiAktivitas: String
    var lokasiAktivitas: String
    var waktuAktivitas: Date
    var olahragaAktivitas: String
    var jenisAktivitas: String
    var prefKemampuanAktivitas: String
    var jumlahPesertaAktivitas: Int
    var biayaAktivitas: Int
    var hostID: UUID
    var komunitasID: UUID?
}

struct DetailActivityPayLoad: Codable {
    var aktivitasID: UUID
    var userID: UUID
}

struct OlahragaMaster: Hashable {
    var olahragaID: Int
    var namaOlahraga: String
    var gambar: String
    var skillLevel: String?
}

struct OlahragaPayload: Codable, Hashable {
    var id: Int
    var namaOlahraga: String
    var gambar: String
    var skillLevel: String?
    var userID: UUID?
}

struct DataOlahraga {
    static let dataOlahraga = [
        OlahragaPayload(
            id: 1,
            namaOlahraga: "Badminton",
            gambar: "figure.badminton"
        ),
        
        OlahragaPayload(
            id: 2,
            namaOlahraga: "Bola Voli",
            gambar: "figure.volleyball"
        ),
        
        OlahragaPayload(
            id: 3,
            namaOlahraga: "Futsal",
            gambar: "figure.soccer"
        ),
        
        OlahragaPayload(
            id: 4,
            namaOlahraga: "Basket",
            gambar: "figure.basketball"
        ),
        
        OlahragaPayload(
            id: 5,
            namaOlahraga: "Running",
            gambar: "figure.run"
        ),
        
        OlahragaPayload(
            id: 6,
            namaOlahraga: "Gym",
            gambar: "figure.strengthtraining.traditional"
        ),
    ]
}
