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
    @State private var searchHomeVenue: [MKMapItem] = []
    
    let images = ["banner 2", "banner 3"]
    
    var body: some View {
        NavigationStack() {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 30) {
                    CarouselView(imagesNames: images).frame(height: 160).shadow(radius: 4, x: 0, y: 4).padding([.horizontal, .top])
                    
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
                                ForEach(searchHomeVenue, id: \.self) { venue in
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
                .onAppear {
                    UINavigationBarAppearance()
                        .setColor(title: .white, background: .darkerGreen)
                    UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .white
                    UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .black
                    
                    avm.getAllActivities()
                    
                    if hvm.olahraganyaUser.isEmpty {
                        hvm.getOlahragaUser()
                    }
                    
                    lm.requestVenuesforHome(input: hvm.olahraganyaUser) { result, error in
                        if let result {
                            self.searchHomeVenue = result
                        }
                    }
                }
            }
        }
        .tint(.white)
        .searchable(text: $searchText, prompt: "Cari aktivitas!")
    }
}

#Preview {
    HomeView().environmentObject(HomeViewModel()).environmentObject(ActivityViewModel()).environmentObject(LocationManager())
}
