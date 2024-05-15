//
//  SettingView.swift
//  Sportify
//
//  Created by Febrian Daniel on 15/05/24.
//

import SwiftUI

struct SettingView: View {
    @State private var showAlert = false
    var body: some View {
        VStack {
            Spacer()
            Button("Logout") {
                showAlert = true
            }.buttonStyle(RedButton()).shadow(radius: 4)
        }
        .navigationTitle("Pengaturan")
        .alert("Logout", isPresented: $showAlert) {
            LogoutAlert()
        } message: {
            Text("Apakah anda ingin logout?")
        }
    }
}

#Preview {
    SettingView()
}

struct LogoutAlert: View {
    @EnvironmentObject var lvm: LoginViewModel
    @EnvironmentObject var hvm: HomeViewModel
    @EnvironmentObject var lm: LocationManager
    var body: some View {
        HStack {
            Button("Kembali") {
                
            }
            
            Button("Logout") {
                lvm.clearLogsinSaves()
                hvm.clearHomeSaves()
                lm.clearLocationSaves()
                
                DispatchQueue.main.async {
                    SupabaseManager.instance.logout()
                    lvm.currentDisplayScreen = .login
                    print("logout Success")
                }
            }
        }
    }
}
