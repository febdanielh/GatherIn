//
//  HomeAktivitasFunGames.swift
//  Sportify
//
//  Created by Febrian Daniel on 12/03/24.
//

import SwiftUI

struct HomeAktivitasFunGames: View {
    @EnvironmentObject var avm: ActivityViewModel
    let aktivitas: ActivityReadPayLoad
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.white)
                .shadow(radius: 4)
            
            VStack(alignment: .leading, spacing: 10) {
                VStack (alignment: .leading, spacing: 6) {
                    Text(aktivitas.namaAktivitas).font(.subheadline).bold().padding(.bottom, 4).lineLimit(1)
                    
                    HStack {
                        Image(systemName: "clock.fill").foregroundStyle(.darkerGreen)
                        Text("\(aktivitas.waktuAktivitas.onlyDate?.getDateFormatted(timeStyle: .none, dateStyle: .long) ?? "") · \(aktivitas.waktuAktivitas.onlyTime?.getDateFormatted(timeStyle: .short, dateStyle: .none) ?? "") WIB")
                    }.font(.caption)
                    
                    HStack {
                        Image(systemName: "mappin.circle.fill").foregroundStyle(.darkerGreen)
                        Text(aktivitas.lokasiAktivitas).lineLimit(1)
                    }.font(.caption)
                }
                .padding(.horizontal)
                
                Divider().padding(.vertical, 3)
                
                VStack(alignment: .leading, spacing: 10) {
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack {
                            ForEach(0..<avm.userInActivity.count, id: \.self) { _ in
                                Image(systemName: "person.circle.fill").resizable().frame(width: 20, height: 20).foregroundColor(.gray)
                            }
                            
                            ForEach(0..<aktivitas.jumlahPesertaAktivitas, id: \.self) { _ in
                                //tambahin gambar orng
                                Circle().stroke(style: StrokeStyle(dash: [5])).frame(width: 20).foregroundColor(.darkerGreen)
                            }
                        }
                    }.padding(.horizontal)
                    
                    Text("\(avm.userInActivity.count)/\(aktivitas.jumlahPesertaAktivitas) sudah bergabung! · Rp\(aktivitas.biayaAktivitas)/orang").font(.custom("SF Pro", size: 10)).padding(.horizontal).lineLimit(1)
                }
            }
        }.frame(width: 230, height: 160)
        .onAppear {
            avm.getUserinActivity(id: aktivitas.aktivitasID)
        }
    }
}

#Preview {
    HomeAktivitasFunGames(aktivitas: ActivityReadPayLoad(aktivitasID: UUID(), created_at: .now, namaAktivitas: "Main Bareng Gan", deskripsiAktivitas: "Mai", lokasiAktivitas: "asd", waktuAktivitas: .now, olahragaAktivitas: "Basket", jenisAktivitas: "Fun Games", prefKemampuanAktivitas: "Intermediate", jumlahPesertaAktivitas: 10, biayaAktivitas: 50000, hostID: UUID())).environmentObject(ActivityViewModel())
}
