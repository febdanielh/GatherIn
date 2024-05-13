//
//  SelectOlahragaAktivitas.swift
//  Sportify
//
//  Created by Febrian Daniel on 11/04/24.
//

import SwiftUI

struct SelectOlahragaAktivitas: View {
    @State private var isSelected = false
    let olahraga: String
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: "figure.\(olahraga.lowercased())").foregroundStyle(.darkerGreen)
            Text(olahraga)
            Spacer()
            Image(systemName: isSelected ? "button.programmable" : "circle").foregroundStyle(.darkerGreen)
        }.font(.headline).padding()
        .onTapGesture {
            isSelected.toggle()
        }
    }
}

#Preview {
    SelectOlahragaAktivitas(olahraga: "Badminton")
}
