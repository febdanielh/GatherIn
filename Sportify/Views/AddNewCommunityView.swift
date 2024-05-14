//
//  AddNewCommunityView.swift
//  Sportify
//
//  Created by Febrian Daniel on 04/04/24.
//

import SwiftUI

struct AddNewCommunityView: View {
    @EnvironmentObject var cvm: CommunityViewModel
    @EnvironmentObject var lvm: LoginViewModel
    @State private var showSheet = false
    @State private var whichSheet = 0
    @State private var showSuccessAlert = false
    @State private var showFailAlert = false
    @State private var showAlert = false
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    ZStack(alignment: .top) {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.white)
                            .shadow(radius: 4)
                        VStack(spacing: 16) {
                            TextField("Nama Komunitas", text: $cvm.nama)
                                .padding()
                                .overlay(content: {
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.darkerGreen, lineWidth: 1.5)
                                })
                                .tint(.black)
                            
                            TextField("Deskripsi", text: $cvm.deskripsi, axis: .vertical)
                                .padding()
                                .lineLimit(5, reservesSpace: true)
                                .multilineTextAlignment(.leading)
                                .overlay(content: {
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.darkerGreen, lineWidth: 1.5)
                                })
                                .tint(.black)
                        }
                        .padding()
                    }
                    
                    ZStack(alignment: .top) {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.white)
                            .shadow(radius: 4)
                        VStack(spacing: 16) {
                            Button {
                                showSheet.toggle()
                                whichSheet = 0
                            } label: {
                                HStack {
                                    Text("Olahraga Komunitas").foregroundStyle(.black)
                                    Spacer()
                                    Image(systemName: "chevron.right").foregroundStyle(.darkerGreen)
                                }.fontWeight(.medium)
                            }
                            
                            Divider()
                            
                            Button(action: {
                                showSheet.toggle()
                                whichSheet = 1
                            }, label: {
                                HStack {
                                    Text("Lokasi Komunitas").foregroundStyle(.black)
                                    Spacer()
                                    Image(systemName: "chevron.right").foregroundStyle(.darkerGreen)
                                }.fontWeight(.medium)
                                
                            })
                        }
                        .padding()
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.clear)
                            .stroke(Color.gray, style: StrokeStyle(dash: [5]))
                            .frame(height: 180)
                            .shadow(radius: 4)
                        
                        Button(action: {
                            showAlert = true
                        }, label: {
                            VStack(spacing: 20) {
                                Image(systemName: "plus")
                                Text("Tap to add image").italic().font(.subheadline)
                            }.foregroundStyle(.black)
                        })
                    }
                    
                    Spacer()
                    
                    Button("Buat Komunitas") {
                        Task {
                            try await cvm.createNewKomunitas(
                                nama: cvm.nama,
                                deskripsi: cvm.deskripsi,
                                lokasi: cvm.lokasi,
                                olahraga: cvm.olahragaKomunitas,
                                foto: "") { result, error in
                                    if let result {
                                        cvm.getUserCommunity()
                                        showSuccessAlert = true
                                        print(result)
                                    } else {
                                        showFailAlert = true
                                        print(error ?? "error bang")
                                    }
                                }
                        }
                    }.buttonStyle(GreenRealButton()).shadow(radius: 4)
                }
                .padding()
            }
            .navigationTitle("Buat Komunitas")
        }
        .onAppear(perform: {
            UINavigationBarAppearance()
                .setColor(title: .white, background: .darkerGreen)
        })
        .sheet(isPresented: $showSheet, content: {
            SheetNumbersComm(whichSheet: $whichSheet)
        })
        .alert("Berhasil", isPresented: $showSuccessAlert) {
            SuccessView()
        } message: {
            Text("Komunitas berhasil dibuat!")
        }
        .alert("Terjadi Kesalahan", isPresented: $showFailAlert) {
            ErrorView()
        } message: {
            Text("Terjadi kesalahan dalam membuat komunitas!. \n Coba lagi")
        }
        .alert("Coming Soon", isPresented: $showAlert) {
            ErrorView()
        }
    }
}

#Preview {
    AddNewCommunityView().environmentObject(CommunityViewModel()).environmentObject(LoginViewModel())
}

struct SheetNumbersComm: View {
    @Binding var whichSheet: Int
    var body: some View {
        switch whichSheet {
        case 0:
            JenisOlahragaPickView(pickFor: "Komunitas")
        case 1:
            LokasiPickView(whatToSearch: "City")
        default:
            Text("Silahkan pilih form!")
        }
    }
}
