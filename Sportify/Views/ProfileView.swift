//
//  ProfileView.swift
//  Sportify
//
//  Created by Febrian Daniel on 13/03/24.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var hvm: HomeViewModel
    @EnvironmentObject var avm: ActivityViewModel
    @EnvironmentObject var kvm: CommunityViewModel
    @State private var showSheet = false
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack{
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 120, height: 120)
                        .padding()
                        .foregroundStyle(.gray)
                    
                    Text(hvm.namaUser).font(.title2).fontWeight(.medium)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Olahraga Saya")
                            Spacer()
                            Image(systemName: "chevron.right").foregroundStyle(.darkerGreen)
                        }.padding().font(.title3).bold().onTapGesture {
                            showSheet.toggle()
                        }
                        
                        NavigationLink(destination: DetailAktivitasProfileView()) {
                            HStack {
                                Text("Aktivitas Saya")
                                Spacer()
                                Image(systemName: "chevron.right").foregroundStyle(.darkerGreen)
                            }.padding(.horizontal).font(.title3).bold()
                        }.tint(.black)
                        
                        if avm.joinedActivities.isEmpty {
                            NoAktivitasProfile(showSheet: $showSheet)
                        } else {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack (spacing: 10){
                                    ForEach(avm.joinedActivities, id: \.self) { aktivitas in
                                        NavigationLink(destination: DetailAktivitasView(aktivitas: aktivitas)) {
                                            HomeAktivitasFunGames(aktivitas: aktivitas)
                                        }.tint(.black)
                                    }
                                }.padding(.horizontal).padding(.vertical, 8)
                            }
                        }
                        
                        Text("Komunitas Saya").font(.title3).bold().padding(.leading)
                        if kvm.komunitasUser == nil {
                            NoKomunitasProfile(showSheet: $showSheet)
                        } else {
                            KomunitasProfile(komunitas: kvm.komunitasUser ?? KomunitasPayLoad(created_at: .now, namaKomunitas: "", deskripsiKomunitas: "", olahragaKomunitas: "", lokasiKomunitas: "", ownerID: UUID()))
                        }
                    }
                }
            }
            .navigationTitle("Profile")
            .toolbar(content: {
                Image(systemName: "square.and.pencil").foregroundColor(.white).fontWeight(.medium)
            })
            .onAppear {
                UINavigationBarAppearance()
                    .setColor(title: .white, background: .darkerGreen)
                
                avm.getJoinedActivities()
                kvm.getUserCommunity()
            }
        }
        .tint(.white)
        .sheet(isPresented: $showSheet) {
            OlahragaSayaView(olahraga: hvm.olahraganyaUser)
        }
    }
}

#Preview {
    ProfileView().environmentObject(HomeViewModel()).environmentObject(ActivityViewModel()).environmentObject(CommunityViewModel())
}
