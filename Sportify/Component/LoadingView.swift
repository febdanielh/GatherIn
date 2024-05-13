//
//  LoadingView.swift
//  Sportify
//
//  Created by Febrian Daniel on 22/04/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
                .opacity(0.4)
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .tint(.darkerGreen)
                .scaleEffect(2)
        }
    }
}

#Preview {
    LoadingView()
}
