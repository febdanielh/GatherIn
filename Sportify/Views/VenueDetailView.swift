//
//  VenueDetailView.swift
//  Sportify
//
//  Created by Febrian Daniel on 22/03/24.
//

import SwiftUI
import MapKit

struct VenueDetailView: View {
    let venue: BaseDataVenue
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 16) {
                    CarouselView(imagesNames: venue.imageVenue)
                        .frame(height: 200)
                    
                    HStack {
                        Image("locations").resizable().frame(width: 18, height: 18)
                        Text(venue.alamatVenue)
                        Spacer()
                    }.font(.subheadline)
                    
//                                                    Text("Time").font(.title3).bold()
                    HStack {
                        Image(systemName: "phone.circle.fill").foregroundStyle(.darkerGreen)
                        Text(venue.noTelpVenue)
                        Spacer()
                    }.font(.subheadline)
                    
                    HStack {
                        Image(systemName: "dollarsign.circle.fill").foregroundStyle(.darkerGreen)
                        Text("Rp\(venue.hargaVenue) / jam")
                        Spacer()
                    }.font(.subheadline)
                    
                    Divider()
                    
                    Text("Description").font(.headline)
                    Text(venue.deskripsiVenue)
                        .font(.subheadline)
                }
                .padding()
                .navigationTitle(venue.namaVenue)
            }
            .safeAreaInset(edge: .top) {
                HStack {
                    LabelOlahragaDetail(olahraga: venue.olahragaVenue)
                    Spacer()
                }
                .padding().background(.darkerGreen)
            }
        }
        .onAppear {
            UINavigationBarAppearance()
                .setColor(title: .white, background: .darkerGreen)
        }
        
    }
}

#Preview {
//    VenueDetailView(venue: DataVenue.venueData[0])
    DetailVenue(venue: MKMapItem())
}

struct DetailVenue: View {
    let venue: MKMapItem
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 16) {
                    MapView(coordinate: CLLocationCoordinate2D(latitude: venue.placemark.coordinate.latitude, longitude: venue.placemark.coordinate.longitude), titleLokasi: venue.name ?? "Nama Venue")
                        .frame(height: 300)
                    
                    Divider()
                    
                    VStack(alignment: .leading) {
                        Text("Alamat").font(.title3).fontWeight(.semibold)
                        Text(venue.placemark.title ?? "Alamat venue")
                    }
                    
                    Divider()
                    
                    VStack(alignment: .leading) {
                        Text("Nomor Telepon").font(.title3).fontWeight(.semibold)
                        Text(venue.phoneNumber ?? "")
                    }
                    
                    Divider()
                    
                    VStack(alignment: .leading) {
                        Text("Website").font(.title3).fontWeight(.semibold)
                        Text(venue.url?.absoluteString ?? "")
                    }
                    
                    
                    Button("Buka di Maps") {
                        venue.openInMaps(launchOptions: nil)
                    }
                    .buttonStyle(GreenRealButton())
                    .padding(.vertical)
                }
                .padding()
                .navigationTitle(venue.name ?? "Nama Venue")
            }
            .onAppear {
                UINavigationBarAppearance()
                    .setColor(title: .white, background: .darkerGreen)
            }
            
        }
    }
}
