//
//  OlahragaSayaView.swift
//  Sportify
//
//  Created by Febrian Daniel on 23/04/24.
//

import SwiftUI

struct OlahragaSayaView: View {
    @EnvironmentObject var hvm: HomeViewModel
    
    @State private var selectedOlahraga = ""
    @State private var sheetHeight: CGFloat = .zero
    
    let olahraga: [OlahragaPayload]
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Olahraga Saya").font(.title2).bold().padding()
                
                ForEach(olahraga.indices, id: \.self) { i in
                    NavigationLink(destination: OlahragaSayaSetSkillView(olahragaa: $hvm.olahraganyaUser[i], olahragaPilihan: $hvm.olahraganyaUser)) {
                        HStack(spacing: 20) {
                            Image(systemName: olahraga[i].gambar)
                                .frame(width: 25, height: 25)
                                .foregroundStyle(.darkerGreen)
                            HStack {
                                Text(olahraga[i].namaOlahraga).foregroundStyle(.black)
                                Text("·").foregroundStyle(.black)
                                Text(olahraga[i].skillLevel ?? "Not Determined").font(.callout).fontWeight(.regular).foregroundStyle(.black)
                            }
                            Spacer()
                            Image(systemName: "chevron.right").foregroundStyle(.darkerGreen)
                        }
                        .fontWeight(.medium)
                        .padding()
                    }
                    
                    if i != olahraga.indices.last {
                        Divider()
                    }
                }
                
                NavigationLink {
                    TambahOlahragaProfile()
                } label: {
                    HStack {
                        Image(systemName: "plus")
                        Text("Tambah Olahraga")
                        Spacer()
                    }.padding().foregroundStyle(.darkerGreen).font(.headline)
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
        }
        .presentationDetents([.height(sheetHeight)])
        .onAppear(perform: {
            UINavigationBarAppearance()
                .setColor(title: .black, background: .white)
        })
    }
}

#Preview {
    //    OlahragaSayaView(olahraga: [
    //        OlahragaPayload(id: 1, namaOlahraga: "Badminton", gambar: "figure.badminton", skillLevel: "Intermediate", userID: UUID()),
    //        OlahragaPayload(id: 2, namaOlahraga: "Bola Voli", gambar: "figure.volleyball", skillLevel: "Intermediate", userID: UUID())
    //    ]).environmentObject(HomeViewModel())
    //
    TambahOlahragaProfile()
}

struct OlahragaSayaSetSkillView: View {
    @State private var sheetHeight: CGFloat = .zero
    @State private var selectedSkill = ""
    
    let levels = ["Beginner", "Intermediate", "Advanced"]
    @Binding var olahragaa: OlahragaPayload
    @Binding var olahragaPilihan: [OlahragaPayload]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Pilih Preferensi Kemampuan").font(.title2).bold().padding([.horizontal, .bottom])
            
            ForEach(0..<levels.count, id: \.self) { level in
                Button {
                    selectedSkill = levels[level]
                    olahragaa.skillLevel = selectedSkill
                    olahragaPilihan = olahragaPilihan.map { olahraga in
                        var newOlahraga = olahraga
                        if newOlahraga.id == olahragaa.id {
                            newOlahraga.skillLevel = selectedSkill
                        }
                        return newOlahraga
                    }
                    print(olahragaPilihan)
                } label: {
                    HStack(spacing: 20) {
                        Image(systemName: olahragaa.gambar)
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

struct TambahOlahragaProfile: View {
    @EnvironmentObject var hvm: HomeViewModel
    @State private var sheetHeight: CGFloat = .zero
    @Environment(\.dismiss) var dismiss
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State var addedSport: [OlahragaPayload] = []
    
    let listOlahraga = DataOlahraga.dataOlahraga
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 20) {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(listOlahraga.indices, id: \.self) { i in
                        if !hvm.olahraganyaUser.contains(where: { existing in
                            existing.id == listOlahraga[i].id
                        }) {
                            OlahragaItem(olahragaPilihan: $addedSport, olahraga: listOlahraga[i])
                        }
                    }
                }
                
                Button("Tambah Olahraga") {
                    Task {
                        try await hvm.createOlahragaUser(olahraga: addedSport) { result, error in
                            if let result {
                                hvm.getOlahragaUser()
                                print(result)
                                dismiss()
                            } else {
                                //handle error brodiws
                            }
                        }
                    }
                }.buttonStyle(GreenRealButton()).padding(.top)
            }
            .padding()
            .overlay {
                GeometryReader { geometry in
                    Color.clear.preference(key: InnerHeightPreferenceKey.self, value: geometry.size.height)
                }
            }
            .onPreferenceChange(InnerHeightPreferenceKey.self) { newHeight in
                sheetHeight = newHeight
            }
        }
        .presentationDetents([.medium])
    }
}

struct OlahragaItem: View {
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
