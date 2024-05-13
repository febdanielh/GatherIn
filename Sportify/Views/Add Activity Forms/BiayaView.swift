//
//  BiayaView.swift
//  Sportify
//
//  Created by Febrian Daniel on 12/04/24.
//

import SwiftUI

struct BiayaView: View {
    @EnvironmentObject var avm: ActivityViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var sheetHeight: CGFloat = .zero
    var body: some View {
        VStack (spacing: 20){
            TextField("Biaya per Orang", value: $avm.biaya, formatter: NumberFormatter())
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.darkerGreen, lineWidth: 1.5)
                }
                .tint(.black)
                .padding()
            
            Button("Confirm") {
                dismiss()
            }
            .buttonStyle(GreenRealButton())
            .disabled(avm.biaya == 0)
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

#Preview {
    BiayaView().environmentObject(ActivityViewModel())
}
