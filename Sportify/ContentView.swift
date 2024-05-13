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
        switch vm.currentDisplayScreen {
        case .login:
            LoginView()
        case .profiling:
            ProfilingView()
        case .home:
            TabBarView()
        }
    }
}

#Preview {
    ContentView().environmentObject(LoginViewModel())
}
