//
//  AktivitasCard.swift
//  Sportify
//
//  Created by Febrian Daniel on 20/03/24.
//

import SwiftUI

struct AktivitasCard: View {
    @EnvironmentObject var avm: ActivityViewModel
    let aktivitas: ActivityReadPayLoad
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .frame(height: 200)
                .foregroundStyle(.white)
                .shadow(radius: 4)
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    LabelOlahraga(olahraga: aktivitas.olahragaAktivitas)
                    LabelSkillLevel(skill: aktivitas.prefKemampuanAktivitas)
                }.padding(.horizontal)
                Text(aktivitas.namaAktivitas).bold().font(.body).padding(.horizontal)
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "clock.fill").foregroundStyle(.darkerGreen)
                        Text("\(aktivitas.waktuAktivitas.onlyDate?.getDateFormatted(timeStyle: .none, dateStyle: .long) ?? "") · \(aktivitas.waktuAktivitas.onlyTime?.getDateFormatted(timeStyle: .short, dateStyle: .none) ?? "") WIB")
                    }.font(.footnote)
                    
                    HStack {
                        Image(systemName: "mappin.circle.fill").foregroundStyle(.darkerGreen)
                        Text(aktivitas.lokasiAktivitas)
                    }.font(.footnote)
                }.padding(.horizontal)
                
                Divider()
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 4) {
                        ForEach(0..<avm.userInActivity.count, id: \.self) { _ in
                            Image(systemName: "person.circle.fill").resizable().frame(width: 25, height: 25).foregroundColor(.gray)
                        }
                        ForEach(0..<aktivitas.jumlahPesertaAktivitas, id: \.self) { _ in
                            Circle().stroke(style: StrokeStyle(dash: [5])).frame(width: 25).foregroundColor(.darkerGreen)
                        }
                    }.padding(.horizontal)
                }
                
                Text("\(avm.userInActivity.count)/\(aktivitas.jumlahPesertaAktivitas) sudah bergabung! · Rp\(aktivitas.biayaAktivitas)/orang").font(.footnote).padding(.horizontal)
            }
        }
        .padding(.horizontal)
        .onAppear {
            avm.getUserinActivity(id: aktivitas.aktivitasID)
        }
    }
}

#Preview {
    AktivitasCard(aktivitas: ActivityReadPayLoad(aktivitasID: UUID(), created_at: Date(), namaAktivitas: "", deskripsiAktivitas: "", lokasiAktivitas: "", waktuAktivitas: Date(), olahragaAktivitas: "", jenisAktivitas: "", prefKemampuanAktivitas: "", jumlahPesertaAktivitas: 1, biayaAktivitas: 0, hostID: UUID())).environmentObject(ActivityViewModel())
}
