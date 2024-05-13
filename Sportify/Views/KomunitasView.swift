//
//  KomunitasView.swift
//  Sportify
//
//  Created by Febrian Daniel on 13/03/24.
//

import SwiftUI

struct KomunitasView: View {
    @EnvironmentObject var hvm: HomeViewModel
    @EnvironmentObject var cvm: CommunityViewModel
    @State private var searchText = ""
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        let komunitas = cvm.allKomunitas
                        ForEach(komunitas.indices, id: \.self) { i in
                            NavigationLink(destination: DetailKomunitasView(komunitas: komunitas[i])) {
                                KomunitasCard(komunitas: komunitas[i])
                            }.tint(.black)
                        }
                    }
                    .navigationTitle("Komunitas")
                }
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
                NavigationLink(destination: AddNewCommunityView()) {
                    Image(systemName: "plus")
                        .foregroundStyle(.white)
                        .bold()
                }
            })
        }
        .tint(.white)
        .onAppear {
            UINavigationBarAppearance().setColor(title: .white, background: .darkerGreen)
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .white
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .white
            
            cvm.getAllCommunity()
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always),prompt: "Cari komunitas!")

    }
}

#Preview {
    KomunitasView().environmentObject(HomeViewModel()).environmentObject(CommunityViewModel()).environmentObject(LocationManager())
}
