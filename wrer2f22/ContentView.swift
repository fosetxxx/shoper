//
//  ContentView.swift
//  wrer2f22
//
//  Created by Semih Karahan on 1.05.2023.
//

import SwiftUI

struct ContentView: View {
    
   
    @State private var getLabelName = ""
    @State private var getLabelPhone = ""
    
    
    var body: some View {
        VStack {
            TextField("search name", text: $getLabelName)
            TextField("search phone", text: $getLabelPhone)
            Button("bas") {
                searchData(labelName: getLabelName, labelPhone: getLabelPhone)
                
                getLabelName = ""
                getLabelPhone = ""
            }
            Button("Print") {
                for i in searchDataArray{
                    print(i)
                }
            }
        }

        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
