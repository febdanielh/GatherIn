//
//  TabBarView.swift
//  Sportify
//
//  Created by Febrian Daniel on 12/03/24.
//

import SwiftUI

struct TabBarView: View {
    @EnvironmentObject var hvm: HomeViewModel
    var body: some View {
        TabView{
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            VenueView()
                .tabItem {
                    Label("Venue", systemImage: "sportscourt.fill")
                }
            KomunitasView()
                .tabItem {
                    Label("Komunitas", systemImage: "person.3.fill")
                }
            ProfileView()
                .tabItem {
                    Label("Profil", systemImage: "person.fill")
                }
        }
        .tint(.darkerGreen)
    }
}

#Preview {
    TabBarView().environmentObject(HomeViewModel())
}
