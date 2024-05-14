//
//  DetailAktivitasView.swift
//  Sportify
//
//  Created by Febrian Daniel on 21/03/24.
//

import SwiftUI
import MapKit

struct DetailAktivitasView: View {
    @EnvironmentObject var avm: ActivityViewModel
    @EnvironmentObject var lvm: LoginViewModel
    @EnvironmentObject var hvm: HomeViewModel
    @EnvironmentObject var lm: LocationManager
    let aktivitas: ActivityReadPayLoad
    @State private var isLoading = false
    @State private var kordinatLokasi = CLLocationCoordinate2D()
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(.vertical) {
                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .foregroundStyle(.white)
                                .shadow(radius: 6)
                            
                            VStack(alignment: .leading, spacing: 16) {
                                MapView(coordinate: kordinatLokasi, titleLokasi: aktivitas.lokasiAktivitas).frame(height: 170)
                                HStack {
                                    Image("locations").resizable().frame(width: 18, height: 18)
                                    Text(aktivitas.lokasiAktivitas)
                                    Spacer()
                                }.font(.subheadline)
                                
                                HStack {
                                    Image(systemName: "clock.fill").foregroundStyle(.darkerGreen)
                                    Text("\(aktivitas.waktuAktivitas.onlyDate?.getDateFormatted(timeStyle: .none, dateStyle: .medium) ?? "") · \(aktivitas.waktuAktivitas.onlyTime?.getDateFormatted(timeStyle: .short, dateStyle: .none) ?? "") WIB")
                                    Spacer()
                                }.font(.subheadline)
                                
                                HStack {
                                    Image(systemName: "dollarsign.circle.fill").foregroundStyle(.darkerGreen)
                                    Text("Rp\(aktivitas.biayaAktivitas) / orang")
                                    Spacer()
                                }.font(.subheadline)
                                
                                Divider()
                                
                                HStack(spacing: 15) {
                                    Circle().stroke(style: StrokeStyle(dash: [5])).frame(width: 35).foregroundColor(.darkerGreen)
                                    Text("Komunitas Bulu Tangkis Tangerang").font(.subheadline).fontWeight(.medium)
                                    Spacer()
                                }
                                
                                Divider()
                                
                                Text("Description").font(.headline)
                                Text(aktivitas.deskripsiAktivitas).multilineTextAlignment(.leading).font(.subheadline)
                                
                                Divider()
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 4) {
                                        ForEach(0..<avm.userInActivity.count, id: \.self) { _ in
                                            Image(systemName: "person.circle.fill").resizable().frame(width: 35, height: 35).foregroundColor(.gray)
                                        }
                                        ForEach(0..<aktivitas.jumlahPesertaAktivitas-avm.userInActivity.count, id: \.self) { _ in
                                            Circle().stroke(style: StrokeStyle(dash: [5])).frame(width: 35).foregroundColor(.darkerGreen)
                                        }
                                    }
                                }
                                
                                Text("\(avm.userInActivity.count) dari \(aktivitas.jumlahPesertaAktivitas) peserta sudah bergabung").font(.subheadline)
                            }
                            .padding()
                            .navigationTitle(aktivitas.namaAktivitas)
                        }
                        .padding()
                        
                        Button("Bergabung"){
                            avm.joinActivity(id: aktivitas.aktivitasID) { (result, error) in
                                isLoading = true
                                if let result {
                                    DispatchQueue.main.async {
                                        hvm.path.removeAll()
                                    }
                                    print(result)
                                }
                            }
                        }.buttonStyle(GreenRealButton()).padding(.bottom)
                    }
                }
            }
            .safeAreaInset(edge: .top) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        LabelJenisAktivitas(jenis: aktivitas.jenisAktivitas)
                        LabelOlahragaDetail(olahraga: aktivitas.olahragaAktivitas)
                        LabelSkillLevelDetail(skill: aktivitas.prefKemampuanAktivitas)
                    }
                }
                .padding()
                .background(.darkerGreen)
            }
        }
        .onAppear {
            UINavigationBarAppearance()
                .setColor(title: .white, background: .darkerGreen)
            
            avm.getUserinActivity(id: aktivitas.aktivitasID)
            lm.searchLocationCoordinate(input: aktivitas.lokasiAktivitas) { (result, error) in
                if let result {
                    self.kordinatLokasi = result.placemark.coordinate
                } else {
                    print(error ?? "error bang")
                }
            }
        }
    }
}

#Preview {
    DetailHostedAktivitasView(aktivitas: ActivityReadPayLoad(aktivitasID: UUID(), created_at: .now, namaAktivitas: "Tes Aktivitas", deskripsiAktivitas: "iya terima kasih kawan kawan atas partisipastinya selama ini, semoga kegiatan ini bisa membantu teman teman semua untuk beraktivitas dan berolahraga bersama, dan menambah teman juga gitu.", lokasiAktivitas: "", waktuAktivitas: .now, olahragaAktivitas: "", jenisAktivitas: "", prefKemampuanAktivitas: "", jumlahPesertaAktivitas: 9, biayaAktivitas: 0, hostID: UUID())).environmentObject(ActivityViewModel()).environmentObject(LoginViewModel()).environmentObject(HomeViewModel()).environmentObject(LocationManager())
}

struct DetailHostedAktivitasView: View {
    @EnvironmentObject var avm: ActivityViewModel
    @EnvironmentObject var lvm: LoginViewModel
    @EnvironmentObject var hvm: HomeViewModel
    @EnvironmentObject var lm: LocationManager
    let aktivitas: ActivityReadPayLoad
    @State private var isLoading = false
    @State private var kordinatLokasi = CLLocationCoordinate2D()
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(.vertical) {
                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .foregroundStyle(.white)
                                .shadow(radius: 6)
                            
                            VStack(alignment: .leading, spacing: 16) {
                                MapView(coordinate: kordinatLokasi, titleLokasi: aktivitas.lokasiAktivitas).frame(height: 170)
                                HStack {
                                    Image("locations").resizable().frame(width: 18, height: 18)
                                    Text(aktivitas.lokasiAktivitas)
                                    Spacer()
                                }.font(.subheadline)
                                
                                HStack {
                                    Image(systemName: "clock.fill").foregroundStyle(.darkerGreen)
                                    Text("\(aktivitas.waktuAktivitas.onlyDate?.getDateFormatted(timeStyle: .none, dateStyle: .medium) ?? "") · \(aktivitas.waktuAktivitas.onlyTime?.getDateFormatted(timeStyle: .short, dateStyle: .none) ?? "") WIB")
                                    Spacer()
                                }.font(.subheadline)
                                
                                HStack {
                                    Image(systemName: "dollarsign.circle.fill").foregroundStyle(.darkerGreen)
                                    Text("Rp\(aktivitas.biayaAktivitas) / orang")
                                    Spacer()
                                }.font(.subheadline)
                                
                                Divider()
                                
                                HStack(spacing: 15) {
                                    Circle().stroke(style: StrokeStyle(dash: [5])).frame(width: 35).foregroundColor(.darkerGreen)
                                    Text("Komunitas Bulu Tangkis Tangerang").font(.subheadline).fontWeight(.medium)
                                    Spacer()
                                }
                                
                                Divider()
                                
                                Text("Description").font(.headline)
                                Text(aktivitas.deskripsiAktivitas).multilineTextAlignment(.leading).font(.subheadline)
                                
                                Divider()
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 4) {
                                        ForEach(0..<avm.userInActivity.count, id: \.self) { _ in
                                            Image(systemName: "person.circle.fill").resizable().frame(width: 35, height: 35).foregroundColor(.gray)
                                        }
                                        ForEach(0..<aktivitas.jumlahPesertaAktivitas-avm.userInActivity.count, id: \.self) { _ in
                                            Circle().stroke(style: StrokeStyle(dash: [5])).frame(width: 35).foregroundColor(.darkerGreen)
                                        }
                                    }
                                }
                                
                                Text("\(avm.userInActivity.count) dari \(aktivitas.jumlahPesertaAktivitas) peserta sudah bergabung").font(.subheadline)
                            }
                            .padding()
                            .navigationTitle(aktivitas.namaAktivitas)
                        }
                        .padding()
                        
                        Button("Selesaikan Aktivitas"){
                            avm.updateActivity(id: aktivitas.aktivitasID, status: "Selesai") { result, error in
                                if let result {
                                    print(result)
                                } else {
                                    
                                }
                            }
                        }.buttonStyle(GreenRealButton()).shadow(radius: 4)
                        
                        Button("Batalkan Aktivitas"){
                            avm.updateActivity(id: aktivitas.aktivitasID, status: "Batal") { result, error in
                                if let result {
                                    print(result)
                                } else {
                                    
                                }
                            }
                        }.buttonStyle(ReverseRedButton())
                    }
                }
            }
            .safeAreaInset(edge: .top) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        LabelJenisAktivitas(jenis: aktivitas.jenisAktivitas)
                        LabelOlahragaDetail(olahraga: aktivitas.olahragaAktivitas)
                        LabelSkillLevelDetail(skill: aktivitas.prefKemampuanAktivitas)
                    }
                }
                .padding()
                .background(.darkerGreen)
            }
            .toolbar(content: {
                NavigationLink(destination: Text("Coming Soon")) {
                    Image(systemName: "square.and.pencil").foregroundStyle(.white).fontWeight(.medium)
                }
            })
        }
        .tint(.white)
        .onAppear {
            UINavigationBarAppearance()
                .setColor(title: .white, background: .darkerGreen)
            
            avm.getUserinActivity(id: aktivitas.aktivitasID)
            lm.searchLocationCoordinate(input: aktivitas.lokasiAktivitas) { (result, error) in
                if let result {
                    self.kordinatLokasi = result.placemark.coordinate
                } else {
                    print(error ?? "error bang")
                }
            }
        }
    }
}
