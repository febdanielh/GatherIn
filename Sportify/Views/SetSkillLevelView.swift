//
//  SetSkillLevelView.swift
//  Sportify
//
//  Created by Febrian Daniel on 17/04/24.
//

import SwiftUI

struct SetSkillLevelView: View {
    @State private var showSheet = false
    @State private var whichOlahraga: String = ""
    
    @Binding var olahragaPilihan: [OlahragaPayload]
    @State var olahragaaa: OlahragaPayload?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            Text("Tentukan Skill").font(.title3).bold()
            Text("Silahkan tentukan seberapa mahir kamu di cabang olahraga ini!").font(.callout).fontWeight(.medium)
            
            ZStack(alignment: .top){
                RoundedRectangle(cornerRadius: 16)
                    .fill(.white)
                    .shadow(radius: 4)
                    .frame(maxHeight: 332)
                VStack(spacing: 16) {
                    ForEach(olahragaPilihan.indices, id: \.self) { index in
                        Button(action: {
                            whichOlahraga = olahragaPilihan[index].namaOlahraga
                            olahragaaa = olahragaPilihan[index]
                            showSheet.toggle()
                        }, label: {
                            HStack(spacing: 15) {
                                Image(systemName: olahragaPilihan[index].gambar).frame(width: 25).foregroundStyle(.darkerGreen)
                                Text(olahragaPilihan[index].namaOlahraga).foregroundStyle(.black)
                                Spacer()
                                Image(systemName: "chevron.right").foregroundStyle(.darkerGreen)
                            }
                            .fontWeight(.medium)
                        })
                        
                        if index != olahragaPilihan.indices.last {
                            Divider()
                        }
                    }
                }
                .padding()
            }
            
            Spacer()
        }
        .padding()
        .sheet(isPresented: $showSheet, content: {
            SkillLevelPickView(olahragaaa: $olahragaaa, olahragaPilihan: $olahragaPilihan)
        })
    }
}

#Preview {
    SetSkillLevelView(olahragaPilihan: .constant(DataOlahraga.dataOlahraga))
}

struct SkillLevelPickView: View {
    @State private var sheetHeight: CGFloat = .zero
    @State private var selectedSkill = ""
    let levels = ["Beginner", "Intermediate", "Advanced"]
    @Binding var olahragaaa: OlahragaPayload?
    @Binding var olahragaPilihan: [OlahragaPayload]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Pilih Preferensi Kemampuan").font(.title2).bold().padding()
            
            ForEach(0..<levels.count, id: \.self) { level in
                Button {
                    selectedSkill = levels[level]
                    olahragaaa?.skillLevel = selectedSkill
                    olahragaPilihan = olahragaPilihan.map { olahraga in
                        var newOlahraga = olahraga
                        if newOlahraga.id == olahragaaa?.id {
                            newOlahraga.skillLevel = selectedSkill
                        }
                        return newOlahraga
                    }
                    print(olahragaPilihan)
                } label: {
                    HStack(spacing: 20) {
                        Image(systemName: olahragaaa?.gambar ?? "figure")
                            .frame(width: 25, height: 25)
                            .foregroundStyle(.darkerGreen)
                        Text(levels[level]).foregroundStyle(.black)
                        Spacer()
                        Image(systemName: (selectedSkill == levels[level]) ? "button.programmable" : "circle").foregroundStyle(.darkerGreen)
                    }
                    .fontWeight(.medium)
                    .padding()
                }
                
                if level != levels.indices.last {
                    Divider()
                }
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
