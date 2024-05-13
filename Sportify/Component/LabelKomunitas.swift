//
//  LabelKomunitas.swift
//  Sportify
//
//  Created by Febrian Daniel on 13/03/24.
//

import SwiftUI

struct LabelKomunitas: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 80, height: 20)
                .foregroundStyle(.labelBadminton)
            Text("Badminton").font(.caption).fontWeight(.medium)
        }
    }
}

#Preview {
//    LabelKomunitas()
    LabelOlahragaDetail(olahraga: "Badminton")
}

struct LabelOlahraga: View {
    let olahraga: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 75, height: 20)
                .foregroundStyle(getLabelColor(for: olahraga))
            Text(olahraga).font(.caption)
        }
    }
}

struct LabelOlahragaDetail: View {
    let olahraga: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 120, height: 25)
                .foregroundStyle(getLabelColor(for: olahraga))
            Text(olahraga).font(.callout).fontWeight(.medium)
        }
    }
}
