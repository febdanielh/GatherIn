//
//  LabelSkillLevel.swift
//  Sportify
//
//  Created by Febrian Daniel on 20/03/24.
//

import SwiftUI

struct LabelSkillLevel: View {
    let skill: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 100, height: 20)
                .foregroundStyle(getLabelColor(for: skill))
            Text(skill).font(.caption)
        }
    }
}

#Preview {
//    LabelSkillLevel()
    LabelSkillLevelDetail(skill: "Intermediate")
}

struct LabelSkillLevelDetail: View {
    let skill: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 130, height: 25)
                .foregroundStyle(getLabelColor(for: skill))
            VStack {
                Text(skill).font(.callout).fontWeight(.medium)
            }
        }
    }
}

struct LabelJenisAktivitas: View {
    let jenis: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 130, height: 25)
                .foregroundStyle(getLabelColor(for: jenis))
            VStack {
                Text(jenis).font(.callout).fontWeight(.medium)
            }
        }
    }
}
