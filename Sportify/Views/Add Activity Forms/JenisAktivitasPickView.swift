//
//  JenisAktivitasPickView.swift
//  Sportify
//
//  Created by Febrian Daniel on 10/04/24.
//

import SwiftUI

struct JenisAktivitasPickView: View {
    @EnvironmentObject var avm: ActivityViewModel
    
    let jenisAkt = ["Fun Games", "Sparring", "Coaching"]
    
    @State private var isFunGamesSelected = false
    @State private var isSparringSelected = false
    @State private var isCoachingSelected = false
    
    @State private var selectedAktivitas = ""
    @State private var sheetHeight: CGFloat = .zero
    var body: some View {
        VStack(alignment: .leading) {
            Text("Pilih Jenis Aktivitas").font(.title2).bold().padding()
            
            Button {
                selectedAktivitas = jenisAkt[0]
                avm.jenisAktivitas = selectedAktivitas
            } label: {
                HStack(spacing: 20) {
                    Image(systemName: "figure.badminton")
                        .frame(width: 25, height: 25)
                        .foregroundStyle(.darkerGreen)
                    Text(jenisAkt[0]).foregroundStyle(.black)
                    Spacer()
                    Image(systemName: (selectedAktivitas == jenisAkt[0]) ? "button.programmable" : "circle").foregroundStyle(.darkerGreen)
                }
                .fontWeight(.medium)
                .padding()
            }
            
            Button {
                selectedAktivitas = jenisAkt[1]
                avm.jenisAktivitas = selectedAktivitas
            } label: {
                HStack(spacing: 20) {
                    Image(systemName: "figure.badminton")
                        .frame(width: 25, height: 25)
                        .foregroundStyle(.darkerGreen)
                    Text(jenisAkt[1]).foregroundStyle(.black)
                    Spacer()
                    Image(systemName: (selectedAktivitas == jenisAkt[1]) ? "button.programmable" : "circle").foregroundStyle(.darkerGreen)
                }
                .fontWeight(.medium)
                .padding()
            }
            
            Button {
                selectedAktivitas = jenisAkt[2]
                avm.jenisAktivitas = selectedAktivitas
            } label: {
                HStack(spacing: 20) {
                    Image(systemName: "figure.badminton")
                        .frame(width: 25, height: 25)
                        .foregroundStyle(.darkerGreen)
                    Text(jenisAkt[2]).foregroundStyle(.black)
                    Spacer()
                    Image(systemName: (selectedAktivitas == jenisAkt[2]) ? "button.programmable" : "circle").foregroundStyle(.darkerGreen)
                }
                .fontWeight(.medium)
                .padding()
            }
        }
        .padding(.top)
        .overlay {
            GeometryReader { geometry in
                Color.clear.preference(key: InnerHeightPreferenceKey.self, value: geometry.size.height)
            }
        }
        .onPreferenceChange(InnerHeightPreferenceKey.self) { newHeight in
            sheetHeight = newHeight
        }
        .presentationDetents([.height(sheetHeight)])
    }
}

#Preview {
    JenisAktivitasPickView().environmentObject(ActivityViewModel())
}
