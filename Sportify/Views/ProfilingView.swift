//
//  ProfilingView.swift
//  Sportify
//
//  Created by Febrian Daniel on 17/04/24.
//

import SwiftUI

struct ProfilingView: View {
    @EnvironmentObject var lvm: LoginViewModel
    @EnvironmentObject var hvm: HomeViewModel
    @State var olahragaPilihan: [OlahragaPayload] = []
    @State var page = 1
    @State private var isLoading = false
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    ForEach(1...3, id: \.self) { i in
                        RoundedRectangle(cornerRadius: 10).frame(width: 100, height: 10).foregroundStyle(page == i ? .darkerGreen : .gray)
                    }
                }.padding(.vertical)
                
                TabView(selection: $page) {
                    ProfilingOlahragaSelection(olahragaPilihan: $olahragaPilihan).tag(1)
                    
                    SetSkillLevelView(olahragaPilihan: $olahragaPilihan).tag(2)
                    
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Welcome, \(hvm.savedName)!").font(.title).bold()
                        Text("Let's Get Started!").fontWeight(.medium).font(.title3)
                    }.tag(3)
                }
                .onChange(of: olahragaPilihan) {
                    if olahragaPilihan.isEmpty {
                        lvm.isDisabled = false
                    } else {
                        lvm.isDisabled = true
                    }
                }
                
                Button("Berikutnya") {
                    if page < 3 {
                        page += 1
                    } else if page == 3 {
                        Task {
                            try await hvm.createOlahragaUser(olahraga: olahragaPilihan) { (result, error) in
                                isLoading = true
                                if let result {
                                    hvm.getOlahragaUser()
                                    DispatchQueue.main.async {
                                        lvm.currentDisplayScreen = .home
                                    }
                                    print(result)
                                } else {
                                    //TODO: handle error brodi
                                }
                            }
                        }
                    }
                }
                .buttonStyle(GreenButton()).shadow(radius: 4)
                .disabled(!lvm.isDisabled)
            }
            if isLoading {
                LoadingView()
            }
        }
    }
}

#Preview {
    ProfilingView().environmentObject(LoginViewModel()).environmentObject(HomeViewModel())
}
