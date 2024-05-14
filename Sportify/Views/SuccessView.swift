//
//  SuccessView.swift
//  Sportify
//
//  Created by Febrian Daniel on 12/05/24.
//

import SwiftUI

struct SuccessView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundColor(.red)
            .overlay {
                VStack {
                    Button("Home") {
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
    }
}

#Preview {
    SuccessView().environmentObject(HomeViewModel())
}
