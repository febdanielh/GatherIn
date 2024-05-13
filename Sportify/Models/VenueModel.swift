//
//  VenueModel.swift
//  Sportify
//
//  Created by Febrian Daniel on 06/04/24.
//

import Foundation
import CoreLocation

struct Venue: Codable {
    var venueID: Int
    var namaVenue: String
    var lokasiVenue: String
    var deskripsiVenue: String
    var hargaVenue: Int
    var noTelpVenue: String
}

struct BaseDataVenue: Hashable {
    var venueID: Int
    var namaVenue: String
    var alamatVenue: String
    var olahragaVenue: String
    var longitudeVenue: CLLocationDegrees
    var latitudeVenue: CLLocationDegrees
    var deskripsiVenue: String
    var hargaVenue: Int
    var noTelpVenue: String
    var rating: Double
    var jumlahReview: Int
    var imageVenue: [String]
}

struct DataVenue {
    static let venueData = [
        BaseDataVenue (
            venueID: 1,
            namaVenue: "GOR Merah Putih",
            alamatVenue: "Jl. Raya Binong No.44, Binong, Kec. Curug, Kabupaten Tangerang, Banten 15810",
            olahragaVenue: "Badminton",
            longitudeVenue: -6.238725552293794,
            latitudeVenue: 106.58257187046324,
            deskripsiVenue: "Selamat datang di GOR Merah Putih!\nGOR Merah Putih memiliki 4 lapangan/court dengan harga Rp50.000 per jam. Kami juga menyediakan makanan dan minuman yang bisa dibeli, serta fasilitas pendukung seperti toilet, tempat berganti pakainan, dan ruang berdoa.\nGOR Merah Putih buka setiap hari di jam 07.00 - 23.00 WIB untuk hari Senin - Sabtu dan di jam 07.00 - 20.00 WIB di hari Minggu.",
            hargaVenue: 50000,
            noTelpVenue: "081298378863",
            rating: 4.4,
            jumlahReview: 315,
            imageVenue: ["gmp1"]
        ),
        
        BaseDataVenue (
            venueID: 2,
            namaVenue: "GOR Jawara Badminton Hall",
            alamatVenue: "Jl. Raya Legok - Karawaci No.68B, Bojong Nangka, Kec. Klp. Dua, Kabupaten Tangerang, Banten 15810",
            olahragaVenue: "Badminton",
            longitudeVenue: -6.265758158518437,
            latitudeVenue: 106.60262215253957,
            deskripsiVenue: "Selamat datang di GOR Jawara Badminton Hall!\nGOR Jawara memiliki 5 lapangan/court dengan harga Rp65.000 per jam. Kami juga menyediakan makanan dan minuman yang bisa dibeli, serta fasilitas pendukung seperti toilet, tempat berganti pakainan, dan lahan parkir luas di depan GOR.\nGOR Merah Putih buka setiap hari di jam 06.00 - 23.00 WIB.",
            hargaVenue: 65000,
            noTelpVenue: "081949960405",
            rating: 4.4,
            jumlahReview: 166,
            imageVenue: ["jawara1"]
        ),
        
        BaseDataVenue (
            venueID: 3,
            namaVenue: "Decathlon Alam Sutera",
            alamatVenue: "Alam Sutera Kota, Jalur Sutera Blvd No.49, RT.002/RW.002, Kunciran, Kec. Pinang, Kota Tangerang, Banten 15144",
            olahragaVenue: "Bola Voli",
            longitudeVenue: -6.220381123518177,
            latitudeVenue: 106.66593836536485,
            deskripsiVenue: "Selamat datang di Decathlon Alam Sutera!\nDectahlon Alam Sutera adalah tempat berbelanja barang-barang kebutuhan berolahraga. Namun, Decathlon Alam Sutera juga menyediakan sebuah lapangan serba guna yang bisa disewa dan digunakan untuk berbagai olahraga seperti, bola basket, bola voli, juga futsal. \nDecathlon buka setiap hari di jam 10.00 - 22.00 WIB.",
            hargaVenue: 100000,
            noTelpVenue: "08170021708",
            rating: 4.6,
            jumlahReview: 5290,
            imageVenue: ["dek1"]
        )
    ]
}
