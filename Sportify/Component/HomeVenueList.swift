//
//  HomeVenueList.swift
//  Sportify
//
//  Created by Febrian Daniel on 12/03/24.
//

import SwiftUI
import MapKit

struct HomeVenueList: View {
    let venue: BaseDataVenue
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.white)
                .shadow(radius: 4)
            VStack(alignment: .leading, spacing: 10) {
                Image(venue.imageVenue[0])
                    .resizable()
                    .scaledToFill()
                    .frame(width: 140, height: 110)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(venue.namaVenue).font(.footnote).fontWeight(.semibold).padding(.horizontal, 7)
                    
                    HStack {
                        Image(systemName: "star.fill").foregroundStyle(.yellowStar)
                        Text("\(String(venue.rating)) (\(String(venue.jumlahReview)))").fontWeight(.medium)
                    }.font(.caption).padding(.leading, 7)
                    Spacer()
                    HStack {
                        Image("locations").resizable().frame(width: 14, height: 14)
                        Text("BSD").font(.caption).fontWeight(.medium)
                    }.padding(.leading, 7).padding(.bottom, 10)
                }
            }
        }.frame(width: 140, height: 200)
    }
}

#Preview {
    //    HomeVenueList(venue: DataVenue.venueData[0])
    SimpleHomeVenueList(venue: MKMapItem()).environmentObject(LocationManager())
}

struct SimpleHomeVenueList: View {
    @EnvironmentObject var lm: LocationManager
    let venue: MKMapItem
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.white)
                .shadow(radius: 4)
            HStack(spacing: 16) {
                Image(systemName: "sportscourt.circle.fill")
                    .resizable().frame(width: 50, height: 50)
                    .foregroundStyle(.darkerGreen)
                VStack(alignment: .leading, spacing: 12) {
                    Text(venue.name ?? "Nama Venue").font(.callout).fontWeight(.semibold)
                    
                    HStack {
                        Image("locations").resizable().frame(width: 20, height: 20)
                        Text(venue.placemark.locality ?? "Kota Venue").font(.footnote).fontWeight(.medium)
                        Spacer()
                    }
                    
                    Text("\(String(format: "%.1f km", lm.getUserDistance(latitude: venue.placemark.coordinate.latitude, longitude: venue.placemark.coordinate.longitude))) dari lokasi Anda").font(.caption)
                }
            }.padding()
        }.frame(width: 270, height: 100)
    }
}
