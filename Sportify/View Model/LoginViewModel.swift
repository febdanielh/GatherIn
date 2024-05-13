//
//  LoginViewModel.swift
//  Sportify
//
//  Created by Febrian Daniel on 18/03/24.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var currentDisplayScreen: DisplayScreen = .login
    @Published var email = ""
    @Published var password = ""
    @Published var isDisabled = false
    
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
            print("form is invalid")
        }
    }
}
