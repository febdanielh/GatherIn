//
//  PrefKemampuanPickView.swift
//  Sportify
//
//  Created by Febrian Daniel on 10/04/24.
//

import SwiftUI

struct PrefKemampuanPickView: View {
    
    @EnvironmentObject var avm: ActivityViewModel
    @State private var selectedSkill = ""
    @State private var sheetHeight: CGFloat = .zero
    
    let levels = ["Beginner", "Intermediate", "Advanced"]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Pilih Preferensi Kemampuan").font(.title2).bold().padding()
            
            ForEach(0..<levels.count, id: \.self) { level in
                Button {
                    selectedSkill = levels[level]
                    avm.skillLevel = selectedSkill
                    print(avm.skillLevel)
                } label: {
                    HStack(spacing: 20) {
                        Image(systemName: "figure.badminton")
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

#Preview {
    PrefKemampuanPickView().environmentObject(ActivityViewModel())
}
