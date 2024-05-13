//
//  SuccessView.swift
//  Sportify
//
//  Created by Febrian Daniel on 12/05/24.
//

import SwiftUI

struct SuccessView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundColor(.red)
            .overlay {
                
                VStack {
                    Button("Home") {
                        
                    }
                    .buttonStyle(.borderedProminent)
                }
                
            }
    }
}

#Preview {
    SuccessView()
}
