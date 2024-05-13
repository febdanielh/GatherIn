//
//  FilterButton.swift
//  Sportify
//
//  Created by Febrian Daniel on 13/03/24.
//

import SwiftUI

struct FilterButton: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.white)
                .frame(width: 117, height: 36)
                .shadow(radius: 4)
            
            HStack(spacing: 20) {
                Text("Urutkan").font(.footnote)
                Image(systemName: "arrow.up.arrow.down")
            }.foregroundStyle(.darkerGreen).fontWeight(.semibold)
        }
    }
}

#Preview {
    FilterButton()
}
