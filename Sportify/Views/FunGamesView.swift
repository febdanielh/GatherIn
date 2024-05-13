//
//  FunGamesView.swift
//  Sportify
//
//  Created by Febrian Daniel on 16/03/24.
//

import SwiftUI

struct FunGamesView: View {
    @EnvironmentObject var avm: ActivityViewModel
    @EnvironmentObject var hvm: HomeViewModel
    @State private var searchText = ""
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView (.vertical, showsIndicators: false) {
                    VStack(spacing: 16) {
                        ForEach(avm.activities, id: \.self) { aktivitas in
                            NavigationLink(destination: DetailAktivitasView(aktivitas: aktivitas)) {
                                AktivitasCard(aktivitas: aktivitas).tint(.black)
                            }
                        }
                    }
                    .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Cari Fun Games!")
                }
                .navigationTitle("Fun Games")
            }
            .safeAreaInset(edge: .top) {
                HStack {
                    FilterButton()
                    PilihOlahragaButton(jumlahOlahraga: hvm.olahraganyaUser.count)
                    Spacer()
                }
                .padding(.horizontal).padding(.top, 5).padding(.bottom)
                .background(.darkerGreen)
            }
            .toolbar(content: {
                NavigationLink(destination: AddNewActivityView(jenisAktivitas: "Fun Games")) {
                    Image(systemName: "plus")
                        .foregroundStyle(.white)
                        .bold()
                }
            })
        }
        .tint(.white)
        .onAppear{
            avm.getActivities(jenis: "Fun Games")
            UINavigationBarAppearance()
                .setColor(title: .white, background: .darkerGreen)
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .white
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .black
        }
    }
}

#Preview {
    FunGamesView().environmentObject(ActivityViewModel()).environmentObject(HomeViewModel())
}
