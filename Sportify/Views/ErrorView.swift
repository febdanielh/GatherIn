//
//  ErrorView.swift
//  Sportify
//
//  Created by Febrian Daniel on 12/05/24.
//

import SwiftUI

struct ErrorView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundColor(.red)
            .overlay {

                VStack {
                    Button("Close") {
                        
                    }
                    .buttonStyle(.borderedProminent)
                }

            }
    }
}

#Preview {
    ErrorView()
}
