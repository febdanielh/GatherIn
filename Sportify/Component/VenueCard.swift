//
//  VenueCard.swift
//  Sportify
//
//  Created by Febrian Daniel on 13/03/24.
//

import SwiftUI
import MapKit

struct VenueCard: View {
    @EnvironmentObject var locationManager: LocationManager
    let venues: BaseDataVenue
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.white)
                .shadow(radius: 4)
            VStack(alignment: .leading, spacing: 12){
                Image(venues.imageVenue[0])
                    .resizable()
                    .scaledToFill()
                    .frame(height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(venues.namaVenue).fontWeight(.semibold).font(.headline)
                    HStack {
                        Image(systemName: "star.fill").foregroundStyle(.yellowStar)
                        Text("\(String(venues.rating)) (\(String(venues.jumlahReview)))").fontWeight(.medium)
                    }.font(.subheadline)
                    
                    HStack {
                        Image("locations").resizable().frame(width: 18, height: 18)
                        Text("\(String(format: "%.1f km", locationManager.getUserDistance(latitude: venues.latitudeVenue, longitude: venues.longitudeVenue))) away").font(.subheadline).fontWeight(.medium)
                    }
                }.padding(.leading).padding(.bottom, 12)
            }
        }
        .frame(height: 250)
        .padding(.horizontal)
    }
}

#Preview {
    //    VenueCard(venues: DataVenue.venueData[0]).environmentObject(LocationManager())
    SimpleVenueCard(venues: MKMapItem()).environmentObject(LocationManager())
}


struct SimpleVenueCard: View {
    @EnvironmentObject var locationManager: LocationManager
    let venues: MKMapItem
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.white)
                .shadow(radius: 4)
            HStack(spacing: 20) {
                Image(systemName: "mappin.and.ellipse.circle.fill")
                    .resizable().frame(width: 40, height: 40)
                    .foregroundStyle(.darkerGreen)
                
                VStack(alignment: .leading, spacing: 12){
                    Text(venues.placemark.name ?? "Nama Venue").font(.headline)
                    Text(venues.placemark.title ?? "Alamat Venue").font(.subheadline).fontWeight(.medium)
                    Text("\(String(format: "%.1f km", locationManager.getUserDistance(latitude: venues.placemark.coordinate.latitude, longitude: venues.placemark.coordinate.longitude))) dari lokasi Anda").font(.subheadline).fontWeight(.medium)
                }
                
                Spacer()
            }.padding()
        }
        .frame(height: 100)
        .padding(.horizontal)
    }
}
