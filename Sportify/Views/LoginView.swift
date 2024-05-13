//
//  LoginView.swift
//  Sportify
//
//  Created by Febrian Daniel on 18/03/24.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @EnvironmentObject var lm: LocationManager
    var body: some View {
        NavigationStack {
            ZStack {
                Color.darkerGreen.ignoresSafeArea()
                VStack{
                    Image("logo").resizable().frame(width: 180, height: 180).foregroundStyle(.white)
                    Text("GatherIn").foregroundStyle(.white).fontDesign(.serif).font(.largeTitle).bold()
                    
                    Spacer().frame(height: 120)
                    
                    NavigationLink(destination: LoginFormView()) {
                        Text("Login")
                    }.buttonStyle(WhiteButton()).padding(.bottom)
                    
                    NavigationLink(destination: RegistrasiFormView()) {
                        Text("Buat Akun")
                    }.buttonStyle(WhiteButton())
                }
                .padding(.vertical)
            }
        }
        .tint(.white)
        .onAppear(perform: {
            lm.requestLocation()
        })
    }
}

#Preview {
    LoginView().environmentObject(LocationManager())
}
