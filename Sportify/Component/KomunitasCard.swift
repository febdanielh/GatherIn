//
//  KomunitasCard.swift
//  Sportify
//
//  Created by Febrian Daniel on 13/03/24.
//

import SwiftUI
import MapKit

struct KomunitasCard: View {
    @EnvironmentObject var cvm: CommunityViewModel
    @EnvironmentObject var lm: LocationManager
    @State var lokasiKomunitas = ""
    let komunitas: KomunitasPayLoad
    let asd = MKMapItem()
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    HStack(spacing: 20) {
                        if komunitas.fotoKomunitas == "" {
                            Image("dummyVenue3")
                                .resizable().scaledToFill()
                                .frame(width: 70, height: 70)
                                .clipped()
                        } else {
                            Image(komunitas.fotoKomunitas ?? "dummyVenue3")
                                .resizable().scaledToFill()
                                .frame(width: 70, height: 70)
                                .clipped()
                        }
                        
                        VStack(alignment: .leading, spacing: 6) {
                            Text(komunitas.namaKomunitas).font(.body).fontWeight(.bold)
                            ZStack {
                                RoundedRectangle(cornerRadius: 16)
                                    .frame(width: 75, height: 20)
                                    .foregroundStyle(getLabelColor(for: komunitas.olahragaKomunitas))
                                Text(komunitas.olahragaKomunitas).font(.caption)
                            }
                            Text("\(cvm.userInCommunity.count) Anggota · \(cvm.lokasiCommunity)").font(.footnote).fontWeight(.medium)
                        }
                        
                        Spacer()
                    }.padding(.horizontal)
                }
            }
            .frame(height: 100).padding(.horizontal)
            Divider()
        }
        .onAppear(perform: {
            cvm.getUserInKomunias(id: komunitas.komunitasID)
            lm.searchLocationCoordinate(input: komunitas.lokasiKomunitas) { result, error in
                if let result {
                    DispatchQueue.main.async {
                        cvm.lokasiCommunity = result.placemark.locality ?? "disini"
                    }
                } else {
                    print(error ?? "error bang")
                }
            }
        })
    }
}

#Preview {
    KomunitasCard(komunitas: KomunitasPayLoad(created_at: .now, namaKomunitas: "", deskripsiKomunitas: "", olahragaKomunitas: "", lokasiKomunitas: "", ownerID: UUID())).environmentObject(CommunityViewModel()).environmentObject(LocationManager())
}

func getLabelColor(for text: String) -> Color {
    switch text {
    case "Badminton":
        Color.labelBadminton
    case "Futsal":
        Color.labelSepakBola
    case "Bola Voli":
        Color.labelBolaVoli
    case "Basket":
        Color.orange
    case "Running":
        Color.yellow
    case "Gym":
        Color.brown
    case "Fun Games":
        Color.teal
    case "Sparring":
        Color.lighterGreen
    case "Coaching":
        Color.mint
    case "Beginner":
        Color.cyan
    case "Intermediate":
        Color.green
    case "Advanced":
        Color.pink
    default:
        Color.white
    }
}
