//
//  ReadDatabase.swift
//  wrer2f22
//
//  Created by Semih Karahan on 11.05.2023.
//

import FirebaseFirestore
import FirebaseAuth

var customerDetailArray = [[String: Any]]()
var customerArray = [String]()



func readFirstCollections(customerName: String) {
    
    
    customerDetailArray.removeAll()
    customerArray.removeAll()
    
    let db = Firestore.firestore()
    let collectionRef = db.collection("\((Auth.auth().currentUser?.email)!)")
    
    collectionRef.getDocuments { (querySnapshot, error) in
        if let error = error {
            print("Error getting documents: \(error)")
        } else {
            for document in querySnapshot!.documents {
                let data = document.data()
                let docIds = document.documentID
                customerDetailArray.append(data)
                customerArray.append(docIds)
                
            }
            print(customerDetailArray)
            print(customerArray)
            getIndexofArrays(customerName: customerName)
        }
        
    }
    
    //let childCollectionRef = collectionRef.document(customerName)
    
}

func getIndexofArrays(customerName: String) {
    if let myIndex = customerArray.firstIndex(of: customerName){
        print(myIndex)
        print(customerDetailArray[myIndex])
    } else {
        print("Index not found!")
    }
}
