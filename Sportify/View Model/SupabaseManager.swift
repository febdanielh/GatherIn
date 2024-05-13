//
//  SupabaseManager.swift
//  Sportify
//
//  Created by Febrian Daniel on 12/03/24.
//

import Supabase
import Foundation
import SwiftUI

class SupabaseManager {
    static let instance = SupabaseManager()
    
    private init(){}
    
    let client = SupabaseClient(supabaseURL: SupaExt.url, supabaseKey: SupaExt.key)
    
    // CREATE
    func regWithEmail(email: String, password: String, completion: @escaping (String? , Error?) -> Void) async throws {
        do {
            try await client.auth.signUp(email: email, password: password)
            completion("Success", nil)
        } catch {
            print("error session")
            completion(nil, error)
        }
    }
    
    func registerUser(item: UserPayLoad) async throws {
        Task {
            try await client.database.from("User").insert(item).execute()
        }
    }
    
    func newActivity(item: ActivityPayLoad, completion: @escaping (String?, Error?) -> Void) async throws {
        do {
            try await client.database.from("Activity").insert(item).execute()
            completion("Success", nil)
        } catch {
            print("Failed to register. \(error.localizedDescription)")
            completion(nil, error)
        }
    }
    
    func newCommunity(item: KomunitasPayLoad, completion: @escaping (String?, Error?) -> Void) async throws {
        do {
            try await client.database.from("Komunitas").insert(item).execute()
            completion("Success", nil)
        } catch {
            print("Failed to register. \(error.localizedDescription)")
            completion(nil, error)
        }
    }
    
    func newDetailCommunity(item: DetailKomunitasPayload, completion: @escaping (String?, Error?) -> Void) async throws{
        do {
            try await client.database.from("DetailKomunitas").insert(item).execute()
            completion("Success", nil)
        } catch {
            print("Failed to register. \(error.localizedDescription)")
            completion(nil, error)
        }
    }
    
    func newOlahraga(item: [OlahragaPayload], completion: @escaping (String?, Error?) -> Void) async throws {
        do {
            try await client.database.from("Olahraga").insert(item).execute()
            completion("Success", nil)
        } catch {
            print("Failed to register. \(error.localizedDescription)")
            completion(nil, error)
        }
    }
    
    func joinActivity(item: DetailActivityPayLoad, completion: @escaping (String?, Error?) -> Void) async throws {
        do {
            try await client.database.from("DetailAktivitas").insert(item).execute()
            completion("Success", nil)
        } catch {
            print("fail \(error.localizedDescription)")
            completion(nil, error)
        }
           
    }
    
    // READ
    func login(email: String, password: String, completion: @escaping (String?, Error?) -> Void) {
        Task {
            do {
                try await client.auth.signIn(email: email, password: password)
                completion("Success", nil)
            } catch {
                print("error session")
                completion(nil, error)
            }
        }
    }
    
    func fetchAppUser(for userID: UUID) -> AppUser? {
        Task {
            return try await client.database.from("User").select().eq("userID", value: userID).single().execute().value
        }
        return nil
    }
    
    func fetchActivities(jenisAktivitas: String) -> [ActivityReadPayLoad] {
        //            var workoutsFetched: [ActivityPayLoad]
        Task {
            return try await client.database.from("Activity").select().eq("jenisAktivitas", value: jenisAktivitas).execute().value
        }
        
        return []
    }
    
    // UPDATE
    func updateSkillOlahraga(for id: UUID) {
        
    }
    
    // DELETE
    func logout() {
        
    }
}
