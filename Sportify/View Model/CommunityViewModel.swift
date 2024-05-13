//
//  CommunityViewModel.swift
//  Sportify
//
//  Created by Febrian Daniel on 09/04/24.
//

import Foundation
import Supabase

class CommunityViewModel: ObservableObject {
    @Published var nama = ""
    @Published var deskripsi = ""
    @Published var lokasi = ""
    @Published var olahragaKomunitas = ""
    @Published var fotoKomunitas = ""
    
    @Published var komunitasUser: KomunitasPayLoad?
    @Published var idKomunitasUser = UUID()
    @Published var joinedKomunitas: [KomunitasPayLoad] = []
    @Published var allKomunitas: [KomunitasPayLoad] = []
    @Published var userInCommunity: [DetailKomunitasPayload] = []
    @Published var usersDetailCommunity: [UserPayLoad] = []
    @Published var aktivitasKomunitas: [ActivityReadPayLoad] = []
    @Published var lokasiCommunity: String = ""
    
    func createNewKomunitas(nama: String, deskripsi: String, lokasi: String, olahraga: String, foto: String, completion: @escaping (String?, Error?) -> Void) async throws {
        let userID = try await SupabaseManager.instance.client.auth.session.user.id
        let komunitas = KomunitasPayLoad(created_at: Date.now, namaKomunitas: nama, deskripsiKomunitas: deskripsi, olahragaKomunitas: olahraga, lokasiKomunitas: lokasi, fotoKomunitas: foto, ownerID: userID)
        
        try await SupabaseManager.instance.newCommunity(item: komunitas, completion: completion)
        try await joinKomunitas(id: komunitas.komunitasID, completion: completion)
    }
    
    func joinKomunitas(id: UUID, completion: @escaping (String?, Error?) -> Void) async throws {
        let userID = try await SupabaseManager.instance.client.auth.session.user.id
        let komunitas = DetailKomunitasPayload(komunitasID: id, userID: userID)
        
        try await SupabaseManager.instance.newDetailCommunity(item: komunitas, completion: completion)
    }
    
    func getUserCommunity() {
        Task {
            do {
                let userID = try await SupabaseManager.instance.client.auth.session.user.id
                
                let detailKomunitas: DetailKomunitasPayload = try await SupabaseManager.instance.client.database.from("DetailKomunitas").select().eq("userID", value: userID).single().execute().value
                
                let komunitas: KomunitasPayLoad = try await SupabaseManager.instance.client.database.from("Komunitas").select().eq("komunitasID", value: detailKomunitas.komunitasID).single().execute().value
                
                DispatchQueue.main.async {
                    self.komunitasUser = komunitas
                }
            } catch {
                print(error)
            }
        }
    }
    
    func getAllCommunity() {
        Task {
            do {
                let komunitas: [KomunitasPayLoad] = try await SupabaseManager.instance.client.database.from("Komunitas").select().execute().value
                
                DispatchQueue.main.async {
                    self.allKomunitas = komunitas
                }
            } catch {
                print(error)
            }
        }
    }
    
    func getUserCommunityID() {
        Task {
            do {
                let userID = try await SupabaseManager.instance.client.auth.session.user.id
                let komunitas: DetailKomunitasPayload = try await SupabaseManager.instance.client.database.from("DetailKomunitas").select().eq("userID", value: userID).single().execute().value
                
                DispatchQueue.main.async {
                    self.idKomunitasUser = komunitas.komunitasID
                }
            } catch {
                print(error)
            }
        }
    }
    
    func getUserInKomunias(id: UUID) {
        Task {
            do {
                let userKomunitas: [DetailKomunitasPayload] = try await SupabaseManager.instance.client.database.from("DetailKomunitas").select().eq("komunitasID", value: id).execute().value
                
                DispatchQueue.main.async {
                    self.userInCommunity = userKomunitas
                }
                
                for user in userKomunitas {
                    let anggotaKomunitas: UserPayLoad = try await SupabaseManager.instance.client.database.from("User").select().eq("userID", value: user.userID).single().execute().value
                    
                    DispatchQueue.main.async {
                        if !self.usersDetailCommunity.contains(anggotaKomunitas) {
                            self.usersDetailCommunity.append(anggotaKomunitas)
                        }
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    
    func getAktivitasKomunitas(id: UUID) {
        Task{
            do {
                let aktivitasKomunitas: [ActivityReadPayLoad] = try await SupabaseManager.instance.client.database.from("Aktivitas").select().eq("komunitasID", value: id).execute().value
                
                DispatchQueue.main.async {
                    self.aktivitasKomunitas = aktivitasKomunitas
                }
            } catch {
                print(error)
            }
        }
    }
}
