//
//  ErrorView.swift
//  Sportify
//
//  Created by Febrian Daniel on 12/05/24.
//

import SwiftUI

struct ErrorView: View {
//    @ObservedObject var usersViewModel: UsersViewModel

    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundColor(.red)
            .overlay {

                VStack {
                    Button("Reload Users") {
                        Task {
                            
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }

            }
    }
}

#Preview {
    ErrorView()
}
