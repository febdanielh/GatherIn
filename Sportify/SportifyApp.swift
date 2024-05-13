//
//  SportifyApp.swift
//  Sportify
//
//  Created by Febrian Daniel on 12/03/24.
//

import SwiftUI

@main
struct SportifyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear(perform: {
                    UINavigationBarAppearance()
                        .setColor(title: .white, background: .darkerGreen)
                })
                .preferredColorScheme(.light)
                .environmentObject(LoginViewModel())
                .environmentObject(RegistrasiViewModel())
                .environmentObject(HomeViewModel())
                .environmentObject(LocationManager())
                .environmentObject(ActivityViewModel())
                .environmentObject(CommunityViewModel())
        }
    }
}
