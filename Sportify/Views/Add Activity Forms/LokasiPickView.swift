//
//  LokasiPickView.swift
//  Sportify
//
//  Created by Febrian Daniel on 10/04/24.
//

import SwiftUI
import MapKit

struct LokasiPickView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var lm: LocationManager
    @EnvironmentObject var avm: ActivityViewModel
    @EnvironmentObject var kvm: CommunityViewModel
    @State private var searchInput = ""
    @State private var locations: [MKMapItem] = []
    let whatToSearch: String
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                if whatToSearch == "POI" {
                    Text("Cari Venue Olahraga").font(.title2).bold().padding()
                } else if whatToSearch == "City" {
                    Text("Cari Kota Komunitas").font(.title2).bold().padding()
                }
                
                
                HStack(spacing: 10) {
                    Image(systemName: "magnifyingglass").foregroundStyle(.darkerGreen).bold()
                    TextField("Cari lokasi", text: $searchInput)
                        .tint(.black)
                }
                .onSubmit(of: .text) {
                    if whatToSearch == "POI" {
                        lm.searchPOI(input: searchInput) { (result, error) in
                            if let result {
                                self.locations = result
                                print(result)
                            } else {
                                print(error?.localizedDescription ?? "error bang")
                            }
                        }
                    } else if whatToSearch == "City" {
                        lm.searchCity(input: searchInput) { (result, error) in
                            if let result {
                                self.locations = result
                                print(result)
                            } else {
                                print(error?.localizedDescription ?? "error bang")
                            }
                        }
                    }
                }
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.darkerGreen)
                }
                .padding([.horizontal, .bottom])
                
                ScrollView (.vertical, showsIndicators: false) {
                    LazyVStack(spacing: 20) {
                        ForEach(locations.indices, id: \.self) { venues in
                            Button(action: {
                                if whatToSearch == "POI" {
                                    avm.lokasi = locations[venues].placemark.name ?? ""
                                } else if whatToSearch == "City" {
                                    kvm.lokasi = locations[venues].placemark.name ?? ""
                                }
                                dismiss()
                            }, label: {
                                MapItemLokasi(venue: locations[venues])
                            }).tint(.black)
                        }
                    }
                }
            }
        }
        .presentationDetents([.medium])
    }
}

#Preview {
    LokasiPickView(whatToSearch: "POI").environmentObject(LocationManager()).environmentObject(ActivityViewModel()).environmentObject(CommunityViewModel())
}
