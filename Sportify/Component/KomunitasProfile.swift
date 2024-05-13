//
//  KomunitasProfile.swift
//  Sportify
//
//  Created by Febrian Daniel on 19/03/24.
//

import SwiftUI

struct KomunitasProfile: View {
    let komunitas: KomunitasPayLoad
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(.white)
                .frame(height: 120)
                .shadow(radius: 4)
            VStack {
                HStack(spacing: 20) {
                    Rectangle().frame(width: 75, height: 75)
                        .foregroundColor(.gray)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text(komunitas.namaKomunitas).font(.body).fontWeight(.bold)
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .frame(width: 75, height: 20)
                                .foregroundStyle(getLabelColor(for: komunitas.olahragaKomunitas))
                            Text(komunitas.olahragaKomunitas).font(.caption)
                        }
                        Text("10 Anggota · Tangerang Selatan").font(.footnote).fontWeight(.medium)
                    }
                    
                    Spacer()
                }.padding(.horizontal)
            }
        }
        .frame(height: 120).padding(.horizontal)
    }
}

#Preview {
//    KomunitasProfile(olahragaKomunitas: "Badminton")
//    NoKomunitasProfile()
    NoAktivitasProfile(showSheet: .constant(false))
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
