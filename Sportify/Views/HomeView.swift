//
//  HomeView.swift
//  Sportify
//
//  Created by Febrian Daniel on 12/03/24.
//

import SwiftUI
import Supabase
import MapKit

struct HomeView: View {
    @EnvironmentObject var hvm: HomeViewModel
    @EnvironmentObject var avm: ActivityViewModel
    @EnvironmentObject var lm: LocationManager
    @State private var searchText = ""
    
    @State private var homeVenue: [MKMapItem] = []
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 30) {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 145).padding(.horizontal).padding(.top)
                        .foregroundStyle(.gray)
                    
                    HStack(spacing: 35) {
                        NavigationLink(destination: FunGamesView(), label: {
                            KategoriAktivitas(kategori: "Fun Games")
                        }).tint(.black)
                        
                        NavigationLink(destination: SparringView(), label: {
                            KategoriAktivitas(kategori: "Sparring")
                        }).tint(.black)
                        
                        NavigationLink(destination: CoachingView(), label: {
                            KategoriAktivitas(kategori: "Coaching")
                        }).tint(.black)
                        
                        NavigationLink {
                            Text("Coming Soon!")
                        } label: {
                            KategoriAktivitas(kategori: "Kompetisi")
                        }.tint(.black)
                    }
                    
                    VStack {
                        HStack {
                            Text("Fun Games Terdekat").font(.title3).bold()
                            Spacer()
                            NavigationLink {
                                FunGamesView()
                            } label: {
                                Image(systemName: "chevron.right").font(.title3).bold()
                                    .foregroundStyle(.darkerGreen)
                            }
                        }.padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16){
                                ForEach(avm.allActivities, id: \.self) { aktivitas in
                                    NavigationLink {
                                        DetailAktivitasView(aktivitas: aktivitas)
                                    } label: {
                                        HomeAktivitasFunGames(aktivitas: aktivitas)
                                    }.tint(.black)
                                }
                            }.padding(.horizontal).padding(.vertical, 10)
                        }
                    }
                    
                    VStack {
                        HStack {
                            Text("Venue Pilihan").font(.title3).bold()
                            Spacer()
                            
                            NavigationLink {
                                VenueView()
                            } label: {
                                Image(systemName: "chevron.right").font(.title3).bold()
                                    .foregroundStyle(.darkerGreen)
                            }
                        }.padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 16) {
//                                ForEach(DataVenue.venueData, id: \.self) { venue in
//                                    HomeVenueList(venue: venue)
//                                }
                                ForEach(homeVenue, id: \.self) { venue in
                                    NavigationLink(destination: DetailVenue(venue: venue)) {
                                        SimpleHomeVenueList(venue: venue)
                                    }.tint(.black)
                                }
                            }.padding(.horizontal).padding(.vertical, 10)
                        }
                    }
                    
                    Spacer()
                }
                .navigationTitle("Halo, \(hvm.getUserFirstName())!")
                .toolbar(content: {
                    Image(systemName: "bubble.left.and.text.bubble.right").font(.title3).foregroundColor(.white)
                })
            }
        }
        .tint(.white)
        .searchable(text: $searchText, prompt: "Cari aktivitas!")
        .onAppear {
            UINavigationBarAppearance()
                .setColor(title: .white, background: .darkerGreen)
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .white
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .black
            
            avm.getAllActivities()
            
            for olahragaUser in hvm.olahraganyaUser {
                lm.requestVenuesforHome(input: olahragaUser.namaOlahraga) { result, error in
                    if let result {
                        homeVenue.append(contentsOf: result)
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView().environmentObject(HomeViewModel()).environmentObject(ActivityViewModel()).environmentObject(LocationManager())
}
