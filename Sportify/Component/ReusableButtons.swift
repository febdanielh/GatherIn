//
//  ReusableButtons.swift
//  Sportify
//
//  Created by Febrian Daniel on 18/03/24.
//

import Foundation
import SwiftUI

struct WhiteButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 361, height: 50)
            .font(.title3).fontWeight(.medium)
            .foregroundColor(.black)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

struct GreenButton: ButtonStyle {
    @EnvironmentObject var lvm: LoginViewModel
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 361, height: 50)
            .font(.title3).fontWeight(.medium)
            .foregroundColor(.white)
            .background(lvm.isDisabled ? .darkerGreen : .gray)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

struct GreenRealButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 361, height: 50)
            .font(.title3).fontWeight(.medium)
            .foregroundColor(.white)
            .background(.darkerGreen)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

struct RedButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 361, height: 50)
            .font(.title3).fontWeight(.medium)
            .foregroundColor(.white)
            .background(.darkerRed)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
struct DisabledButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 361, height: 50)
            .font(.title3).fontWeight(.medium)
            .foregroundColor(.white)
            .background(.gray)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

struct CustomTextField: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
    }
}

struct CariKomunitasButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
//            .frame(height: 50)
            .font(.subheadline).fontWeight(.semibold)
            .foregroundColor(.white)
            .background(.darkerGreen)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
