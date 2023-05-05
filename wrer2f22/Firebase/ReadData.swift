//
//  ReadData.swift
//  wrer2f22
//
//  Created by Semih Karahan on 5.05.2023.
//

import FirebaseFirestore


var readAllDataArray = [[String:Any]]()


// 1 document in verilerini çeker
func readData() {
    let db = Firestore.firestore()
    let docRef = db.collection("Buyers").document("x4R5cIvR0vpO0CgRuaOT")

    docRef.getDocument { (document, error) in
        if let document = document, document.exists {
            let data = document.data()! as [String : Any]
            print(type(of: data))
            print(data["date"]!)
        } else {
            print("Document does not exist in Firestore")
        }
    }
}


// Tüm document lerin verileri [[String:Any]] şeklinde çeker.
func readAllData() {
    
    
    let db = Firestore.firestore()
    let collectionRef = db.collection("Buyers")

    collectionRef.getDocuments { (querySnapshot, error) in
        if let error = error {
            print("Error getting documents: \(error)")
        } else {
            for document in querySnapshot!.documents {
                let data = document.data()
                readAllDataArray.append(data)
            }
        }
        print(readAllDataArray[0])
    }
}
