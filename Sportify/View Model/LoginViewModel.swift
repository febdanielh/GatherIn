//
//  LoginViewModel.swift
//  Sportify
//
//  Created by Febrian Daniel on 18/03/24.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var currentDisplayScreen: DisplayScreen = .login
    @Published var email = ""
    @Published var password = ""
    @Published var isDisabled = false
    @Published var loginError: ErrorType? = nil
    @Published var showAlert = false
    
    @AppStorage("loggedIn") var loggedIn = false
    @AppStorage("savedEmail") var savedEmail: String = ""
    @AppStorage("savedPassword") var savedPassword: String = ""
    
    func isSignInFormValid(email: String, password: String) -> Bool {
        guard email.isValidEmail(), password.count > 7 else {
            return false
        }
        return true
    }
    
    func signIn(email: String, password: String, completion: @escaping (String?, Error?) -> Void) {
        if isSignInFormValid(email: email, password: password) {
            SupabaseManager.instance.login(email: email, password: password, completion: completion)
        } else {
            loginError = .incomplete
            showAlert = true
            print("form is invalid")
        }
    }
    
    func clearLogsinSaves() {
        savedEmail = ""
        savedPassword = ""
        loggedIn = false
        
        print(savedEmail)
        print(savedPassword)
        print(loggedIn)
    }
}
