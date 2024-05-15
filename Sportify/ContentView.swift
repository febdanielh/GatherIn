//
//  ContentView.swift
//  Sportify
//
//  Created by Febrian Daniel on 12/03/24.
//

import SwiftUI

enum DisplayScreen {
    case login
    case profiling
    case home
}

struct ContentView: View {
    @EnvironmentObject var vm: LoginViewModel
    var body: some View {
        VStack {
            switch vm.currentDisplayScreen {
            case .login:
                LoginView()
            case .profiling:
                ProfilingView()
            case .home:
                TabBarView()
            }
        }.onAppear(perform: {
            if UserDefaults.standard.bool(forKey: "loggedIn") {
                DispatchQueue.main.async {
                    vm.currentDisplayScreen = .home
                }
            } else {
                DispatchQueue.main.async {
                    vm.currentDisplayScreen = .login
                }
            }
        })
    }
}

#Preview {
    ContentView().environmentObject(LoginViewModel())
}
