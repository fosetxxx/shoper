//
//  ContentView.swift
//  wrer2f22
//
//  Created by Semih Karahan on 1.05.2023.
//

import SwiftUI
import URLImage




struct ContentView: View {
    @State var obj = ""
    var body: some View {
        VStack {
            if (AuthSection().user != nil) == true {
                Text("Dolu")
            } else {
                Text("Boş")
            }
        }.onAppear {
            AuthSection().checkCurrentUser()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
