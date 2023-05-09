//
//  ContentView.swift
//  wrer2f22
//
//  Created by Semih Karahan on 1.05.2023.
//

import SwiftUI
import URLImage
import FirebaseAuth




struct ContentView: View {
    @State var obj = ""
    @ObservedObject var viewModel = AuthViewModel()
    @State private var emailText = ""
    @State private var passText = ""
    
    var body: some View {
        VStack {
            
            TextField("eposta", text: $emailText)
            TextField("eposta", text: $passText)
            Button("Login") {
                AuthSection().singIn(emailText: emailText, passText: passText)
            }
            
            if viewModel.user != nil {
                Text("Welcome, \(viewModel.user?.email ?? "Unknown User")!")
                Button("Sign Out") {
                  try? Auth.auth().signOut()
                }
            } else {
                Text("Merhaba")
            }
            /*
            if (AuthSection().user != nil) == true {
                Text("Dolu")
            } else {
                Text("Boş")
            }
             */
        }//.onAppear {
         //   AuthSection().checkCurrentUser()
        //}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
