//
//  KategoriAktivitas.swift
//  Sportify
//
//  Created by Febrian Daniel on 12/03/24.
//

import SwiftUI

struct KategoriAktivitas: View {
    let kategori: String
    var body: some View {
        VStack() {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 50, height: 50)
                .foregroundStyle(.gray)
            Text(kategori)
                .font(.caption)
        }
    }
}

#Preview {
    KategoriAktivitas(kategori: "Fun Games")
}
