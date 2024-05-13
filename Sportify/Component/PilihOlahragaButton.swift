//
//  PilihOlahragaButton.swift
//  Sportify
//
//  Created by Febrian Daniel on 13/03/24.
//

import SwiftUI

struct PilihOlahragaButton: View {
//    @Binding var showSheet: Bool
    let jumlahOlahraga: Int
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.white)
                .frame(width: 127, height: 36)
                .shadow(radius: 4)
            
            HStack(spacing: 20) {
                Text("Olahraga").font(.footnote).fontWeight(.semibold)
                ZStack {
                    Circle().frame(height: 22)
                    Text(String(jumlahOlahraga)).font(.footnote).fontWeight(.semibold).foregroundStyle(.white)
                }
            }.foregroundStyle(.darkerGreen)
        }
    }
}

#Preview {
    PilihOlahragaButton(jumlahOlahraga: 3)
}
