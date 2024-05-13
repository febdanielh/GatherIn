//
//  DetailAktivitasProfileView.swift
//  Sportify
//
//  Created by Febrian Daniel on 30/03/24.
//

import SwiftUI

struct DetailAktivitasProfileView: View {
    @EnvironmentObject var avm: ActivityViewModel
    @State private var selectSegment = 0
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    switch selectSegment {
                    case 0:
                        ForEach(avm.joinedActivities, id: \.self) { aktivitas in
                            NavigationLink(destination: DetailAktivitasView(aktivitas: aktivitas)) {
                                AktivitasCard(aktivitas: aktivitas)
                            }.tint(.black)
                        }
                    case 1:
                        ForEach(avm.hostedActivities, id: \.self) { aktivitas in
                            NavigationLink(destination: DetailAktivitasView(aktivitas: aktivitas)) {
                                AktivitasCard(aktivitas: aktivitas)
                            }.tint(.black)
                        }
                    default:
                        Text("yo")
                    }
                }
            }
            .navigationTitle("Aktivitas Saya")
            .safeAreaInset(edge: .top) {
                ZStack {
                    Rectangle()
                        .frame(height: 50)
                        .foregroundStyle(.darkerGreen)
                        .shadow(radius: 6)
                    Picker("Member or Host", selection: $selectSegment) {
                        Text("Peserta").tag(0)
                        Text("Host").tag(1)
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)
                }
            }
        }
        .tint(.white)
        .onAppear(perform: {
            UINavigationBarAppearance()
                .setColor(title: .white, background: .darkerGreen)
            
            avm.getHostedActivities()
        })
    }
}

#Preview {
    DetailAktivitasProfileView().environmentObject(ActivityViewModel())
}
