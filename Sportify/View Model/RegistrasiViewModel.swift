//
//  RegistrasiViewModel.swift
//  Sportify
//
//  Created by Febrian Daniel on 19/03/24.
//

import Foundation
import Supabase

class RegistrasiViewModel: ObservableObject {
    @Published var emailBaru = ""
    @Published var passwordBaru = ""
    @Published var namaLengkap = ""
    @Published var noTelp = ""
    @Published var tanggalLahir = Date()
    @Published var jenisKelamin = ""
    
    func isRegEmailFormValid(email: String, password: String) -> Bool {
        guard email.isValidEmail(), password.count > 7 else {
            return false
        }
        return true
    }
    
    func isSignUpFormValid(namaLengkap: String, noTelp: String, tanggalLahir: Date, jenisKelamin: String) -> Bool {
        guard !namaLengkap.isEmpty, !noTelp.isEmpty, !tanggalLahir.description.isEmpty, !jenisKelamin.isEmpty else {
            return false
        }
        return true
    }
    
    func regWithEmail(email: String, password: String, namaLengkap: String, noTelp: String, tanggalLahir: Date, jenisKelamin: String, completion: @escaping (String?, Error?) -> Void) async throws {
        if isRegEmailFormValid(email: email, password: password) {
            try await SupabaseManager.instance.regWithEmail(email: email, password: password, completion: completion)
            try await createUser(namaLengkap: namaLengkap, noTelp: noTelp, tanggalLahir: tanggalLahir, jenisKelamin: jenisKelamin)
        } else {
            print("form is invalid")
            throw NSError()
        }
    }
    
    func createUser(namaLengkap: String, noTelp: String, tanggalLahir: Date, jenisKelamin: String) async throws {
        if isSignUpFormValid(namaLengkap: namaLengkap, noTelp: noTelp, tanggalLahir: tanggalLahir, jenisKelamin: jenisKelamin) {
            let userID = try await SupabaseManager.instance.client.auth.session.user.id
            let userEmail = try await SupabaseManager.instance.client.auth.session.user.email
            let user = UserPayLoad(userID: userID, email: userEmail, namaLengkap: namaLengkap, noTelp: noTelp, tanggalLahir: tanggalLahir, jenisKelamin: jenisKelamin)
            
            try await SupabaseManager.instance.registerUser(item: user)
        } else {
            print("form is invalid")
            throw NSError()
        }
    }
}

extension String {
    func isValidEmail() -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
}
