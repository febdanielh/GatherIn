//
//  RegistrasiFormView.swift
//  Sportify
//
//  Created by Febrian Daniel on 18/03/24.
//

import SwiftUI
import Supabase

struct RegistrasiFormView: View {
    @EnvironmentObject var rvm: RegistrasiViewModel
    @EnvironmentObject var lvm: LoginViewModel
    @EnvironmentObject var hvm: HomeViewModel
    
    let jenisKelamin = ["Laki-laki", "Perempuan"]
    @State private var selectedGender = ""
    
    @State private var isMarked = false
    @State private var maleSelected = false
    @State private var femaleSelected = false
    @State private var isLoading = false
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack (alignment: .leading, spacing: 16) {
                        Text("Email").fontWeight(.medium)
                        TextField("Email", text: $rvm.emailBaru)
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.darkerGreen, lineWidth: 1.5)
                            }
                            .tint(.black)
                        
                        Text("Password").fontWeight(.medium)
                        SecureField("Password", text: $rvm.passwordBaru)
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.darkerGreen, lineWidth: 1.5)
                            }
                            .tint(.black)
                        
                        Divider().padding(.top)
                        
                        Text("Nama Lengkap").fontWeight(.medium)
                        TextField("Nama Lengkap", text: $rvm.namaLengkap)
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.darkerGreen, lineWidth: 1.5)
                            }
                            .tint(.black)
                        
                        Text("Nomor Telepon").fontWeight(.medium)
                        TextField("Nomor Telepon", text: $rvm.noTelp)
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.darkerGreen, lineWidth: 1.5)
                            }
                            .tint(.black)
                        
                        Text("Tanggal Lahir").fontWeight(.medium)
                        
                        DatePicker("DD/MM/YYYY", selection: $rvm.tanggalLahir, in: ...Date.now, displayedComponents: .date)
                            .padding()
                            .foregroundStyle(.gray)
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.darkerGreen, lineWidth: 1.5)
                            }
                            .tint(.black)
                        
                        Text("Jenis Kelamin").fontWeight(.medium)
                        HStack {
                            Button(action: {
                                rvm.jenisKelamin = jenisKelamin[0]
                            }, label: {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.darkerGreen, lineWidth: 3)
                                    .fill((rvm.jenisKelamin == jenisKelamin[0]) ? .darkerGreen : .white)
                                    .frame(height: 50)
                                    .overlay {
                                        Text(jenisKelamin[0]).font(.headline).foregroundStyle((rvm.jenisKelamin == jenisKelamin[0]) ? .white : .black)
                                    }
                            })
                            
                            Button(action: {
                                rvm.jenisKelamin = jenisKelamin[1]
                            }, label: {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.darkerGreen, lineWidth: 3)
                                    .fill((rvm.jenisKelamin == jenisKelamin[1]) ? .darkerGreen : .white)
                                    .frame(height: 50)
                                    .overlay {
                                        Text(jenisKelamin[1]).font(.headline).foregroundStyle((rvm.jenisKelamin == jenisKelamin[1]) ? .white : .black)
                                    }
                            })
                        }
                        
                        HStack {
                            Button(action: {
                                isMarked.toggle()
                                if isMarked {
                                    lvm.isDisabled = true
                                } else {
                                    lvm.isDisabled = false
                                }
                            }, label: {
                                Image(systemName: isMarked ? "checkmark.square.fill" : "square")
                            }).tint(.darkerGreen)
                            
                            Text("Saya setuju dengan syarat & ketentuan yang berlaku").font(.subheadline)
                        }.padding(.vertical)
                        
                        Button("Buat Akun"){
                            Task {
                                try await rvm.regWithEmail(email: rvm.emailBaru, password: rvm.passwordBaru, namaLengkap: rvm.namaLengkap, noTelp: rvm.noTelp, tanggalLahir: rvm.tanggalLahir, jenisKelamin: rvm.jenisKelamin, completion: { (result, error) in
                                    isLoading = true
                                    if let result {
                                        hvm.getAppUser()
                                        DispatchQueue.main.async {
                                            lvm.currentDisplayScreen = .profiling
                                        }
                                        print(result)
                                    } else {
                                        //TODO: jeuuuuu alert error
                                    }
                                })
                            }
                            
                        }.buttonStyle(GreenButton()).shadow(radius: 4).disabled(!lvm.isDisabled)
                    }
                    .padding()
                    .navigationTitle("Buat Akun")
                    .onAppear(perform: {
                        UINavigationBarAppearance()
                            .setColor(title: .white, background: .darkerGreen)
                    })
                }
                if isLoading {
                    LoadingView()
                }
            }
        }.navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    RegistrasiFormView().environmentObject(RegistrasiViewModel()).environmentObject(LoginViewModel()).environmentObject(HomeViewModel())
}
