//
//  HomeViewModel.swift
//  Sportify
//
//  Created by Febrian Daniel on 16/03/24.
//

import Foundation
import Supabase
import MapKit

class HomeViewModel: ObservableObject {
    @Published var namaUser = ""
    @Published var appUser: AppUser?
    @Published var olahragaUser: [OlahragaMaster] = []
    @Published var skillLevels: [String : String] = [:]
    @Published var olahraganyaUser: [OlahragaPayload] = []
    @Published var path = [Int]()
    
    func getAppUser() {
        Task {
            do {
                let userID = try await SupabaseManager.instance.client.auth.session.user.id
                let user : UserPayLoad? = try await SupabaseManager.instance.client.database.from("User").select().eq("userID", value: userID).single().execute().value
                
                DispatchQueue.main.async {
                    self.namaUser = user?.namaLengkap ?? ""
                }
                print(user ?? UserPayLoad(userID: UUID(), email: "", namaLengkap: "", noTelp: "", tanggalLahir: Date(), jenisKelamin: ""))
                
            } catch {
                print(error)
            }
        }
    }
    
    func getUserFirstName() -> String {
        var username = ""
        
        var components = namaUser.components(separatedBy: " ")
        if components.count > 0 {
            let firstName = components.removeFirst()
            username = firstName
        }
        return username
    }
    
    func getNamaOlahraga() -> [String] {
        var namaOlahraga: [String] = []
        for olahraga in olahraganyaUser {
            namaOlahraga.append(olahraga.namaOlahraga)
        }
        return namaOlahraga
    }
    
    func updateOlahragaUser(completion: @escaping (String? , Error?) -> Void) {
        Task {
            do {
                let olahraga = getNamaOlahraga()
                let userID = try await SupabaseManager.instance.client.auth.session.user.id
                try await SupabaseManager.instance.client.database.from("User").update(["olahragaUser" : olahraga]).eq("userID", value: userID).execute()
                completion("Success", nil)
            } catch {
                print(error)
                completion(nil, error)
            }
        }
    }
    
    func createOlahragaUser(olahraga: [OlahragaPayload], completion: @escaping (String?, Error?) -> Void) async throws {
        let userID = try await SupabaseManager.instance.client.auth.session.user.id
        var activity: [OlahragaPayload] = []
        for newOlahraga in olahraga {
            activity.append(OlahragaPayload(id: newOlahraga.id, namaOlahraga: newOlahraga.namaOlahraga, gambar: newOlahraga.gambar, skillLevel: newOlahraga.skillLevel, userID: userID))
        }
        
        try await SupabaseManager.instance.newOlahraga(item: activity, completion: completion)
    }
    
    func getOlahragaUser() {
        Task {
            do {
                let userID = try await SupabaseManager.instance.client.auth.session.user.id
                let user : [OlahragaPayload]? = try await SupabaseManager.instance.client.database.from("Olahraga").select().eq("userID", value: userID).execute().value
                
                DispatchQueue.main.async {
                    self.olahraganyaUser = user ?? []
                }
                print(user ?? OlahragaPayload(id: 0, namaOlahraga: "", gambar: "", skillLevel: "", userID: userID))
                print(olahraganyaUser)
            } catch {
                print(error)
            }
        }
    }
}
