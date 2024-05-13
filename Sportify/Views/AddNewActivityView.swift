//
//  AddNewActivityView.swift
//  Sportify
//
//  Created by Febrian Daniel on 03/04/24.
//

import SwiftUI

struct AddNewActivityView: View {
    @EnvironmentObject var avm: ActivityViewModel
    @EnvironmentObject var lvm: LoginViewModel
    @EnvironmentObject var hvm: HomeViewModel
    @State private var showSheet = false
    @State private var whichSheet = 0
    
    @State private var isLoading = false
    @State private var showSuccessAlert = false
    @State private var showFailAlert = false
    let jenisAktivitas: String
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        ZStack(alignment: .top) {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.white)
                                .shadow(radius: 4)
                            VStack(spacing: 16) {
                                TextField("Nama Aktivitas", text: $avm.nama)
                                    .tint(.black)
                                    .padding()
                                    .overlay(content: {
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(Color.darkerGreen, lineWidth: 1.5)
                                    })
                                
                                TextField("Deskripsi", text: $avm.deskripsi, axis: .vertical)
                                    .lineLimit(5, reservesSpace: true)
                                    .tint(.black)
                                    .padding()
                                    .multilineTextAlignment(.leading)
                                    .overlay(content: {
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(Color.darkerGreen, lineWidth: 1.5)
                                    })
                            }
                            .padding()
                        }
                        
                        Text("Detail Aktivitas").font(.headline)
                        
                        ZStack(alignment: .top) {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.white)
                                .shadow(radius: 4)
                            VStack(spacing: 16) {
                                
                                Button(action: {
                                    showSheet.toggle()
                                    whichSheet = 0
                                }, label: {
                                    HStack {
                                        Text("Jenis Olahraga").foregroundStyle(.black)
                                        Spacer()
                                        Text(avm.jenisOlahraga).font(.callout).foregroundStyle(.gray)
                                        Image(systemName: "chevron.right").foregroundStyle(.darkerGreen)
                                    }.fontWeight(.medium)
                                })
                                
                                Divider()
                                
                                Button {
                                    showSheet.toggle()
                                    whichSheet = 1
                                } label: {
                                    HStack {
                                        Text("Jenis Aktivitas").foregroundStyle(.black)
                                        Spacer()
                                        Text(avm.jenisAktivitas).font(.callout).foregroundStyle(.gray)
                                        Image(systemName: "chevron.right").foregroundStyle(.darkerGreen)
                                    }.fontWeight(.medium)
                                }
                                
                                Divider()
                                
                                DatePicker("Waktu", selection: $avm.waktu)
                                    .tint(.darkerGreen)
                                    .fontWeight(.medium)
                                
                                Divider()
                                
                                VStack(alignment: .leading, spacing: 14) {
                                    Button(action: {
                                        showSheet.toggle()
                                        whichSheet = 3
                                    }, label: {
                                        HStack {
                                            Text("Lokasi").foregroundStyle(.black)
                                            Spacer()
                                            Text(avm.lokasi).font(.callout).foregroundStyle(.gray)
                                            Image(systemName: "chevron.right").foregroundStyle(.darkerGreen)
                                        }.fontWeight(.medium)
                                    })
                                    
                                    HStack(spacing: 12) {
                                        Image(systemName: "info.circle.fill").foregroundStyle(.darkerGreen)
                                        Text("Silahkan menghubungi venue olahraga terlebih dahulu sebelum membuat aktivitas!")
                                            .foregroundStyle(.gray)
                                    }.font(.footnote)
                                }
                                
                                Divider()
                                
                                Button(action: {
                                    showSheet.toggle()
                                    whichSheet = 4
                                }, label: {
                                    HStack {
                                        Text("Preferensi Kemampuan").foregroundStyle(.black)
                                        Spacer()
                                        Text(avm.skillLevel).font(.callout).foregroundStyle(.gray)
                                        Image(systemName: "chevron.right").foregroundStyle(.darkerGreen)
                                    }.fontWeight(.medium)
                                })
                                
                                Divider()
                                
                                HStack(spacing: 14) {
                                    Text("Jumlah Peserta")
                                    Spacer()
                                    Image(systemName: "minus.circle.fill").foregroundStyle(.darkerGreen)
                                        .onTapGesture {
                                            if avm.jumlahPeserta > 0 {
                                                avm.jumlahPeserta -= 1
                                            }
                                        }
                                    Text(String(avm.jumlahPeserta))
                                    Image(systemName: "plus.circle.fill").foregroundStyle(.darkerGreen)
                                        .onTapGesture {
                                            avm.jumlahPeserta += 1
                                        }
                                }.fontWeight(.medium)
                            }
                            .padding()
                        }
                        
                        ZStack(alignment: .top) {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.white)
                                .shadow(radius: 4)
                            VStack(spacing: 16) {
                                HStack {
                                    Text("Komunitas")
                                    Spacer()
                                    Image(systemName: "chevron.right").foregroundStyle(.darkerGreen)
                                }.fontWeight(.medium)
                                
                                Divider()
                                
                                Button(action: {
                                    showSheet = true
                                    whichSheet = 5
                                }, label: {
                                    HStack {
                                        Text("Biaya").foregroundStyle(.black)
                                        Spacer()
                                        Text("Rp\(avm.biaya)").font(.callout).foregroundStyle(.gray)
                                        Image(systemName: "chevron.right").foregroundStyle(.darkerGreen)
                                    }.fontWeight(.medium)
                                })
                            }
                            .padding()
                        }
                        
                        Spacer()
                        
                        Button("Buat Aktivitas"){
                            Task {
                                try await avm.createNewActivity(
                                    nama: avm.nama,
                                    deskripsi: avm.deskripsi,
                                    jenisOlahraga: avm.jenisOlahraga,
                                    jenisAktivitas: avm.jenisAktivitas,
                                    waktu: avm.waktu,
                                    lokasi: avm.lokasi,
                                    kemampuan: avm.skillLevel,
                                    jumlahPeserta: avm.jumlahPeserta,
                                    biaya: avm.biaya) { (result, error) in
                                        isLoading = true
                                        if let result {
                                            showSuccessAlert = true
                                            print(result)
                                        } else {
                                            showFailAlert = true
                                            print(error ?? "eror bang")
                                        }
                                    }
                            }
                        }
                        .buttonStyle(GreenRealButton())
                        .shadow(radius: 4)
                    }
                    .padding()
                }
                .navigationTitle("Buat Aktivitas")
                .navigationBarTitleDisplayMode(.inline)
                
                if isLoading {
                    LoadingView()
                }
            }
        }
        .alert("Berhasil", isPresented: $showSuccessAlert) {
            SuccessView()
        }
        .alert("Terjadi Kesalahan", isPresented: $showFailAlert) {
            ErrorView()
        }
        .sheet(isPresented: $showSheet, content: {
            SheetNumbers(whichSheet: $whichSheet)
        })
        .onAppear(perform: {
            UINavigationBarAppearance()
                .setColor(title: .white, background: .darkerGreen)
            
            avm.jenisAktivitas = jenisAktivitas
        })
    }
}

#Preview {
    AddNewActivityView(jenisAktivitas: "Fun Games").environmentObject(ActivityViewModel()).environmentObject(LoginViewModel()).environmentObject(HomeViewModel())
}

struct SheetNumbers: View {
    @Binding var whichSheet: Int
    var body: some View {
        switch whichSheet {
        case 0:
            JenisOlahragaPickView(pickFor: "Aktivitas")
        case 1:
            JenisAktivitasPickView()
        case 2:
            WaktuPickView()
        case 3:
            LokasiPickView(whatToSearch: "POI")
        case 4:
            PrefKemampuanPickView()
        case 5:
            BiayaView()
        default:
            Text("Silahkan isi detail aktivitas!")
        }
    }
}
