//
//  VenueView.swift
//  Sportify
//
//  Created by Febrian Daniel on 13/03/24.
//

import SwiftUI
import MapKit

struct VenueView: View {
    @State private var searchText = ""
    @State private var searchItems: [MKMapItem] = []
    
    @EnvironmentObject var lm: LocationManager
    @EnvironmentObject var hvm: HomeViewModel
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 30) {
                        ForEach(searchItems, id: \.self) { venue in
                            NavigationLink(destination: DetailVenue(venue: venue)) {
                                SimpleVenueCard(venues: venue)
                            }.tint(.black)
                        }
                    }
                    .padding(.vertical)
                    .onAppear {
                        UINavigationBarAppearance().setColor(title: .white, background: .darkerGreen)
                        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .white
                        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .black
                    }
                    .navigationTitle("Venue")
                }
            }
        }
        .tint(.white)
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Cari venue!")
        .onSubmit(of: .search) {
            lm.searchPOI(input: searchText) { result, error in
                if let result {
                    self.searchItems = result
                }
            }
        }
    }
}

//
//ForEach(DataVenue.venueData.sorted { venue1, venue2 in
//    let distance1 = lm.getUserDistance(latitude: venue1.latitudeVenue, longitude: venue1.longitudeVenue)
//    let distance2 = lm.getUserDistance(latitude: venue2.latitudeVenue, longitude: venue2.longitudeVenue)
//    return distance1 < distance2
//}, id: \.self) { venue in
//    NavigationLink(destination: VenueDetailView(venue: venue)){
//        VenueCard(venues: venue)
//    }.tint(.black)
//}

#Preview {
    VenueView().environmentObject(LocationManager()).environmentObject(HomeViewModel())
}
