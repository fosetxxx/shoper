//
//  ContentView.swift
//  wrer2f22
//
//  Created by Semih Karahan on 1.05.2023.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack{
            addData()
            Button("bas") {
                readAllData()
                
            }
        }

        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
