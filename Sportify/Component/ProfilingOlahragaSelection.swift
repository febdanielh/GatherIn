//
//  ProfilingOlahragaSelection.swift
//  Sportify
//
//  Created by Febrian Daniel on 26/03/24.
//

import SwiftUI

struct ProfilingOlahragaSelection: View {
    @EnvironmentObject var hvm: HomeViewModel
    @Binding var olahragaPilihan: [OlahragaPayload]
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        VStack(spacing: 20) {
            Text("Olahraga apa yang kamu gemari?").font(.title3).bold()
                .padding(.vertical)
            
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(DataOlahraga.dataOlahraga, id: \.self) { olahraga in
                    ProfilingItem(olahragaPilihan: $olahragaPilihan, olahraga: olahraga)
                }
            }
            Spacer()
        }.padding()
    }
}

#Preview {
    ProfilingOlahragaSelection(olahragaPilihan: .constant(DataOlahraga.dataOlahraga))
}

struct ProfilingItem: View {
    @State private var isSelected = false
    @Binding var olahragaPilihan: [OlahragaPayload]
    let olahraga: OlahragaPayload
    var body: some View {
        Button {
            isSelected.toggle()
            if isSelected {
                olahragaPilihan.append(olahraga)
                print(olahragaPilihan)
            } else {
                olahragaPilihan.removeAll { isi in
                    isi == olahraga
                }
                print(olahragaPilihan)
            }
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white)
                    .shadow(color: isSelected ? .darkerGreen : .gray, radius: 5)

                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: olahraga.gambar).foregroundStyle(.darkerGreen).font(.headline)
                            Spacer()
                            Image(systemName: "checkmark.square.fill")
                                .foregroundStyle(isSelected ? .darkerGreen : .white)
                                .font(.headline)
                        }
                        
                        Text(olahraga.namaOlahraga).font(.headline).foregroundStyle(.black)
                    }.padding()
            }
            .frame(width: 150, height: 90)
        }
    }
}
