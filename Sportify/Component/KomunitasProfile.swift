//
//  KomunitasProfile.swift
//  Sportify
//
//  Created by Febrian Daniel on 19/03/24.
//

import SwiftUI

struct KomunitasProfile: View {
    @EnvironmentObject var cvm: CommunityViewModel
    @EnvironmentObject var lm: LocationManager
    let komunitas: KomunitasPayLoad
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(.white)
                .shadow(radius: 4)
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
                    
                    VStack(alignment: .leading, spacing: 10) {
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
                }.padding()
            }
        }
        .frame(height: 100).padding(.horizontal)
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
    KomunitasProfile(komunitas: KomunitasPayLoad(created_at: .now, namaKomunitas: "", deskripsiKomunitas: "", olahragaKomunitas: "", lokasiKomunitas: "", ownerID: UUID())).environmentObject(CommunityViewModel()).environmentObject(LocationManager())
    //    NoKomunitasProfile()
//    NoAktivitasProfile(showSheet: .constant(false))
}

struct NoKomunitasProfile: View {
    @Binding var showSheet: Bool
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(.white)
                .frame(height: 120)
                .shadow(radius: 4)
            VStack {
                HStack() {
                    VStack(alignment: .leading, spacing: 10){
                        Text("Anda belum tergabung dalam komunitas!").font(.subheadline)
                        Text("Ayo mulai bergabung!").font(.subheadline).fontWeight(.semibold)
                    }
                    Spacer()
                    Button("+ Cari Komunitas"){
                        showSheet.toggle()
                    }.buttonStyle(CariKomunitasButton())
                }.padding(.horizontal)
            }
        }
        .frame(height: 120).padding(.horizontal)
    }
}

struct NoAktivitasProfile: View {
    @Binding var showSheet: Bool
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(.white)
                .frame(height: 120)
                .shadow(radius: 4)
            VStack {
                HStack() {
                    VStack(alignment: .leading, spacing: 10){
                        Text("Anda belum mengikuti aktivitas!").font(.subheadline)
                        Text("Ayo mulai bergabung!").font(.subheadline).fontWeight(.semibold)
                    }
                    Spacer()
                    Button("+ Cari Aktivitas"){
                        showSheet.toggle()
                    }.buttonStyle(CariKomunitasButton())
                }.padding(.horizontal)
            }
        }
        .frame(height: 120).padding(.horizontal)
    }
}
