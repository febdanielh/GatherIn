//
//  DetailKomunitasView.swift
//  Sportify
//
//  Created by Febrian Daniel on 23/03/24.
//

import SwiftUI

struct DetailKomunitasView: View {
    @EnvironmentObject var cvm: CommunityViewModel
    @State private var selectedTitleIndex: Int = 0
    let komunitas: KomunitasPayLoad
    let titles = ["Detail", "Anggota", "Aktivitas"]
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                switch selectedTitleIndex {
                case 0:
                    DetailKomunitas(komunitas: komunitas)
                case 1:
                    AnggotaKomunitas(komunitas: komunitas)
                case 2:
                    AktivitasKomunitas(komunitas: komunitas)
                default:
                    DetailKomunitas(komunitas: komunitas)
                }
            }
            .toolbar(content: {
                Image(systemName: "square.and.arrow.up")
                    .foregroundStyle(.white).fontWeight(.semibold)
            })
            .safeAreaInset(edge: .top) {
                ZStack{
                    Rectangle()
                        .frame(height: 210)
                        .foregroundStyle(.white)
                        .shadow(radius: 4)
                    VStack(spacing: 16) {
                        if komunitas.fotoKomunitas == "" {
                            Image("dummyVenue3")
                                .resizable().scaledToFill()
                                .clipShape(Circle())
                                .frame(width: 60, height: 60).padding(.top)
                        } else {
                            Image(komunitas.fotoKomunitas ?? "")
                                .resizable().scaledToFill()
                                .clipShape(Circle())
                                .frame(width: 60, height: 60).padding(.top)
                        }
                        Text(komunitas.namaKomunitas).font(.headline)
                        Text("\(komunitas.olahragaKomunitas) · \(cvm.userInCommunity.count) Anggota · \(cvm.lokasiCommunity)").font(.footnote).foregroundStyle(.gray)
                        
                        SegmentControlView(items: titles, selection: $selectedTitleIndex, defaultXSpace: 35)
                            .padding([.top, .horizontal])
                            .background(.white)
                    }
                }
            }
            .safeAreaInset(edge: .bottom) {
                Button("Bergabung") {
                    
                }.buttonStyle(GreenRealButton()).shadow(radius: 4).padding(.bottom)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            UINavigationBarAppearance()
                .setColor(background: .darkerGreen)
            
//            cvm.getAktivitasKomunitas(id: komunitas.komunitasID)
        }
    }
}

#Preview {
    DetailKomunitasView(komunitas: KomunitasPayLoad(created_at: .now, namaKomunitas: "", deskripsiKomunitas: "", olahragaKomunitas: "", lokasiKomunitas: "", ownerID: UUID())).environmentObject(CommunityViewModel())
}

struct DetailKomunitas: View {
    let komunitas: KomunitasPayLoad
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(.white).shadow(radius: 4)
                VStack(alignment: .leading) {
                    Text(komunitas.deskripsiKomunitas).multilineTextAlignment(.leading)
                }.padding()
            }.padding()
        }
    }
}

struct AnggotaKomunitas: View {
    @EnvironmentObject var cvm: CommunityViewModel
    let komunitas: KomunitasPayLoad
    var body: some View {
        VStack(spacing: 16) {
            ForEach(cvm.usersDetailCommunity, id: \.self) { user in
                ZStack {
                    RoundedRectangle(cornerRadius: 12).foregroundStyle(.white).shadow(radius: 4)
                    HStack(spacing: 25) {
                        Circle().frame(width: 55, height: 55).foregroundStyle(.gray)
                        VStack(alignment: .leading, spacing: 10) {
                            Text(user.namaLengkap).fontWeight(.medium)
                            Text((komunitas.ownerID == user.userID) ? "Admin" : "Anggota").font(.callout)
                        }
                        Spacer()
                    }.padding()
                }	
            }
        }.padding()
    }
}

struct AktivitasKomunitas: View {
    @EnvironmentObject var cvm: CommunityViewModel
    let komunitas: KomunitasPayLoad
    var body: some View {
        VStack(spacing: 16) {
            ForEach(cvm.aktivitasKomunitas, id: \.self) { aktivitas in
                ZStack {
                    RoundedRectangle(cornerRadius: 16).foregroundStyle(.white).shadow(radius: 4)
                    HStack {
                        VStack(alignment: .leading, spacing: 12) {
                            Text(aktivitas.namaAktivitas)
                            Text("\(aktivitas.waktuAktivitas.onlyDate?.getDateFormatted(timeStyle: .none, dateStyle: .medium) ?? "") · \(aktivitas.waktuAktivitas.onlyTime?.getDateFormatted(timeStyle: .short, dateStyle: .none) ?? "") WIB")
                            LabelJenisAktivitas(jenis: aktivitas.jenisAktivitas)
                        }
                        Spacer()
                    }.padding()
                }
            }
        }.padding()
    }
}
