//
//  MapItemLokasi.swift
//  Sportify
//
//  Created by Febrian Daniel on 15/04/24.
//

import SwiftUI
import MapKit

struct MapItemLokasi: View {
    let venue: MKMapItem
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(venue.placemark.name ?? "asd").font(.title3).bold().multilineTextAlignment(.leading)
            
            HStack(spacing: 12) {
                Image(systemName: "mappin.circle.fill").foregroundStyle(.darkerGreen)
                Text(venue.placemark.title ?? "").multilineTextAlignment(.leading)
                Spacer()
            }.fontWeight(.medium)
            
            HStack(spacing: 12) {
                Image(systemName: "phone.circle.fill").foregroundStyle(.darkerGreen)
                Text(venue.phoneNumber ?? "--")
                Spacer()
            }.fontWeight(.medium)
            
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .fill(.clear)
                .shadow(radius: 6)
        }
        .padding(.horizontal)
    }
}

#Preview {
    MapItemLokasi(venue: MKMapItem())
}
