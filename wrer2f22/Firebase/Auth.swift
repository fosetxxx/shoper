//
//  Auth.swift
//  BestSeller
//
//  Created by Semih Karahan on 29.04.2023.
//

import Foundation
import FirebaseAuth
import SwiftUI

class AuthSection {
    
    @State var emailText: String
    @State var passText: String
    
    init(emailText: String, passText: String) {
        self.emailText = emailText
        self.passText = passText
    }
    
    // Kullanıcı oluşturma
    func signUp() {
        if emailText == "" && passText == "" {
            Alert().showAlert(title: "Error", message: "Need email or password!")
        } else {
            Auth.auth().createUser(withEmail: emailText, password: passText) { authData, error in
                if error != nil {
                    Alert().showAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                    
                } else {
                    Alert().showAlert(title: "Success", message: "Please login")
                }
            }
        }
    }
    
    // Mevcut kullanıcı ile giriş yapma
    func singIn() {
        if emailText == "" && passText == "" {
            Alert().showAlert(title: "Error", message: "Need email or password!")
        } else {
            Auth.auth().signIn(withEmail: emailText, password: passText) { authData, error in
                if error != nil {
                    Alert().showAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                } else {
                    Alert().showAlert(title: "Success", message: "Successfully logged in")
                }
            }
        }
    }
    
    // Mevcut kullanıcı hesabı açık mı yoksa çıkış yapılmış mı kontrolü
    func checkCurrentUser() {
        let currentUser = Auth.auth().currentUser
        if currentUser != nil {
            Alert().showAlert(title: "Success", message: "\(String(describing: currentUser)) kullanıcısı ile devam ediliyor.")
        } else {
            Alert().showAlert(title: "!!!", message: "Must login")
        }
    }
    
    // Mevcut kullanıcının çıkış yapılması
    func logOut(){
        do {
            try Auth.auth().signOut()
        } catch {
            Alert().showAlert(title: "Error", message: "Error")
        }
    }
    
}
