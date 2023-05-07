//
//  SearchButton.swift
//  wrer2f22
//
//  Created by Semih Karahan on 7.05.2023.
//

import FirebaseFirestore

var searchDataArray = [[String:Any]]()

func searchData(labelName: String, labelPhone: String)  {
    searchDataArray.removeAll()
    let db = Firestore.firestore()
    let myLabel = db.collection("Buyers")
    
    myLabel.whereField("buyerName", isEqualTo: labelName)
        .getDocuments { (snapshot, error) in
            if let error = error {
                print("noooo")
            } else {
                print(snapshot!.documents)
                if snapshot!.documents.isEmpty {
                    print("No name")
                } else {
                    for document in snapshot!.documents {
                        //print(document.data())
                        searchDataArray.append(document.data())
                        
                    }
                }
                
            }
        }
    
    myLabel.whereField("buyerPhone", isEqualTo: labelPhone)
        .getDocuments { (snapshot, error) in
            if let error = error {
                print("noooo")
            } else {
                print(snapshot!.documents)
                if snapshot!.documents.isEmpty {
                    print("no phone")
                } else {
                    for document in snapshot!.documents {
                        searchDataArray.append(document.data())
                        
                    }
                }
                
            }
        }
    
    
}
