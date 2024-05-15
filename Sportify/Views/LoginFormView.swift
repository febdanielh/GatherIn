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
    @EnvironmentObject var lm: LocationManager
    @State var isLoading = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.darkerGreen.ignoresSafeArea()
                VStack {
                    Image("logo").resizable().frame(width: 180, height: 180).foregroundStyle(.white)
                    Text("GatherIn").foregroundStyle(.white).fontDesign(.serif).font(.largeTitle).bold()
                    
                    Spacer().frame(height: 50)
                    
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
                                isLoading = false
                                
                                DispatchQueue.main.async {
                                    vm.savedEmail = vm.email
                                    vm.savedPassword = vm.password
                                    vm.loggedIn = true
                                    vm.currentDisplayScreen = .home
                                }
                                
                                print(result)
                            } else {
                                isLoading = false
                                DispatchQueue.main.async {
                                    vm.loginError = .server
                                    vm.showAlert = true
                                }
                            }
                        })
                    }.buttonStyle(WhiteButton()).shadow(radius: 5)
                }
                
                if isLoading {
                    LoadingView()
                }
            }
        }
        .alert("Terjadi Kesalahan", isPresented: $vm.showAlert) {
            ErrorView()
        } message: {
            Text(vm.loginError?.description ?? "error")
        }
    }
}

#Preview {
    LoginFormView()
        .environmentObject(LoginViewModel())
        .environmentObject(HomeViewModel())
        .environmentObject(LocationManager())
}
