//
//  JenisOlahragaPickView.swift
//  Sportify
//
//  Created by Febrian Daniel on 10/04/24.
//

import SwiftUI

struct JenisOlahragaPickView: View {
    @EnvironmentObject var avm: ActivityViewModel
    @EnvironmentObject var kvm: CommunityViewModel
    
    @State private var selectedOlahraga = ""
    @State private var sheetHeight: CGFloat = .zero
    
    let pickFor: String
    let olahraga = DataOlahraga.dataOlahraga
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Pilih Olahraga Aktivitas").font(.title2).bold().padding()
            
            ForEach(olahraga.indices, id:\.self) { i in
                Button {
                    selectedOlahraga = olahraga[i].namaOlahraga
                    if pickFor == "Aktivitas" {
                        avm.jenisOlahraga = selectedOlahraga
                        print(avm.jenisOlahraga)
                    } else if pickFor == "Komunitas" {
                        kvm.olahragaKomunitas = selectedOlahraga
                        print(kvm.olahragaKomunitas)
                    }
                    
                } label: {
                    HStack(spacing: 20) {
                        Image(systemName: olahraga[i].gambar)
                            .frame(width: 25, height: 25)
                            .foregroundStyle(.darkerGreen)
                        Text(olahraga[i].namaOlahraga).foregroundStyle(.black)
                        Spacer()
                        Image(systemName: (selectedOlahraga == olahraga[i].namaOlahraga) ? "button.programmable" : "circle").foregroundStyle(.darkerGreen)
                    }
                    .fontWeight(.medium)
                    .padding()
                }
                
                if i != olahraga.indices.last {
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

#Preview {
    JenisOlahragaPickView(pickFor: "Aktivitas").environmentObject(ActivityViewModel())
}

struct InnerHeightPreferenceKey: PreferenceKey {
    static let defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
