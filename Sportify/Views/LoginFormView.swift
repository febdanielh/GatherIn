//
//  LoginFormView.swift
//  Sportify
//
//  Created by Febrian Daniel on 18/03/24.
//

import SwiftUI

struct LoginFormView: View {
    @EnvironmentObject var vm: LoginViewModel
    @EnvironmentObject var hvm: HomeViewModel
    @State var isLoading = false
    var body: some View {
        NavigationStack {
            ZStack {
                Color.darkerGreen.ignoresSafeArea()
                VStack {
                    Rectangle().frame(width: 100, height: 100).foregroundStyle(.white)
                    Text("Sportify").foregroundStyle(.white).font(.largeTitle).bold()
                    
                    Spacer().frame(height: 90)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Email").foregroundStyle(.white).fontWeight(.semibold)
                        TextField("Email", text: $vm.email)
                            .padding()
                            .background(.white)
                            .cornerRadius(12)
                            .tint(.black)
                        Text("Password").foregroundStyle(.white).fontWeight(.semibold)
                        SecureField("Password", text: $vm.password)
                            .padding()
                            .background(.white)
                            .cornerRadius(12)
                            .tint(.black)
                    }.padding()
                    
                    Spacer().frame(height: 100)
                    
                    Button("Login"){
                        vm.signIn(email: vm.email, password: vm.password, completion: { result, error in
                        isLoading = true
                            if let result {
                                hvm.getAppUser()
                                hvm.getOlahragaUser()
                                DispatchQueue.main.async {
                                    vm.currentDisplayScreen = .home
                                }
                                print(result)
                            } else {
                                //TODO: jeuuuuu alert error
                            }
                        })
                    }.buttonStyle(WhiteButton()).shadow(radius: 5)
                }
                
                if isLoading {
                    LoadingView()
                }
            }
        }
    }
}

#Preview {
    LoginFormView()
        .environmentObject(LoginViewModel())
        .environmentObject(HomeViewModel())
}
