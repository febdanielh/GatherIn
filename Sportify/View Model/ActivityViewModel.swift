//
//  ActivityViewModel.swift
//  Sportify
//
//  Created by Febrian Daniel on 09/04/24.
//

import Foundation
import Supabase
import SwiftUI

class ActivityViewModel: ObservableObject {
    @Published var nama = ""
    @Published var deskripsi = ""
    @Published var jenisOlahraga = ""
    @Published var jenisAktivitas = ""
    @Published var waktu = Date()
    @Published var lokasi = ""
    @Published var skillLevel = ""
    @Published var jumlahPeserta = 0
    @Published var komunitas = ""
    @Published var biaya = 0
    
    @Published var allActivities: [ActivityReadPayLoad] = []
    @Published var activities: [ActivityReadPayLoad] = []
    @Published var hostedActivities: [ActivityReadPayLoad] = []
    @Published var joinedActivities: [ActivityReadPayLoad] = []
    @Published var userInActivity: [DetailActivityPayLoad] = []
    
    func createNewActivity(nama: String, deskripsi: String, jenisOlahraga: String, jenisAktivitas: String, waktu: Date, lokasi: String, kemampuan: String, jumlahPeserta: Int, biaya: Int, completion: @escaping (String?, Error?) -> Void) async throws {
        let userID = try await SupabaseManager.instance.client.auth.session.user.id
        let activity = ActivityPayLoad(created_at: Date(), namaAktivitas: nama, deskripsiAktivitas: deskripsi, lokasiAktivitas: lokasi, waktuAktivitas: waktu, olahragaAktivitas: jenisOlahraga, jenisAktivitas: jenisAktivitas, prefKemampuanAktivitas: kemampuan, jumlahPesertaAktivitas: jumlahPeserta, biayaAktivitas: biaya, hostID: userID)
        
        try await SupabaseManager.instance.newActivity(item: activity, completion: completion)
    }
    
    func getActivities(jenis: String) {
        Task {
            do {
                let activities: [ActivityReadPayLoad] = try await SupabaseManager.instance.client.database.from("Activity").select().eq("jenisAktivitas", value: jenis).execute().value
                
                DispatchQueue.main.async {
                    self.activities = activities
                }
            } catch {
                print(error)
            }
        }
    }
    
    func getAllActivities() {
        Task {
            do {
                let activities: [ActivityReadPayLoad] = try await SupabaseManager.instance.client.database.from("Activity").select().eq("jenisAktivitas", value: "Fun Games").execute().value
                
                DispatchQueue.main.async {
                    self.allActivities = activities
                }
            } catch {
                print(error)
            }
        }
    }
    
    func getHostedActivities() {
        Task {
            do {
                let userID = try await SupabaseManager.instance.client.auth.session.user.id
                let activities: [ActivityReadPayLoad] = try await SupabaseManager.instance.client.database.from("Activity").select().eq("hostID", value: userID).execute().value
                
                DispatchQueue.main.async {
                    self.hostedActivities = activities
                }
            } catch {
                print(error)
            }
        }
    }
    
    func getJoinedActivities() {
        Task {
            do {
                let userID = try await SupabaseManager.instance.client.auth.session.user.id
                var activityIDs: [UUID] = []
                
                let activities: [DetailActivityPayLoad] = try await SupabaseManager.instance.client.database.from("DetailAktivitas").select().eq("userID", value: userID).execute().value
                
                for activity in activities {
                    activityIDs.append(activity.aktivitasID)
                }
                
                for aktivitas in activities {
                    let joinedAct: ActivityReadPayLoad = try await SupabaseManager.instance.client.database.from("Activity").select().eq("aktivitasID", value: aktivitas.aktivitasID).single().execute().value
                    
                    DispatchQueue.main.async {
                        if !self.joinedActivities.contains(joinedAct) {
                            self.joinedActivities.append(joinedAct)
                        }
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    
    func getJoinedActivititesFR() {
        Task {
            do {
                let userID = try await SupabaseManager.instance.client.auth.session.user.id
                
                let joinedAct: [ActivityReadPayLoad] = try await SupabaseManager.instance.client.database
                    .from("Aktivitas")
                    .select()
                    .eq("DetailAktivitas.userID", value: userID)
                    .execute()
                    .value
                
                DispatchQueue.main.async {
                    self.joinedActivities = joinedAct
                }
            } catch {
                print(error)
            }
        }
    }
    
    func joinActivity(id: UUID, completion: @escaping (String?, Error?) -> Void) {
        Task {
            let userID = try await SupabaseManager.instance.client.auth.session.user.id
            let join = DetailActivityPayLoad(aktivitasID: id, userID: userID)
            
            try await SupabaseManager.instance.joinActivity(item: join, completion: completion)
        }
    }
    
    func getUserinActivity(id: UUID) {
        Task {
            do {
                let activities: [DetailActivityPayLoad] = try await SupabaseManager.instance.client.database.from("DetailAktivitas").select().eq("aktivitasID", value: id).execute().value
                
                DispatchQueue.main.async {
                    self.userInActivity = activities
                }
            } catch {
                print(error)
            }
        }
    }
}
