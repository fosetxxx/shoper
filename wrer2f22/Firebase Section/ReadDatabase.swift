//
//  ReadDatabase.swift
//  wrer2f22
//
//  Created by Semih Karahan on 11.05.2023.
//

import FirebaseFirestore
import FirebaseAuth

struct readGlobalVariables {
    static var customerDetailArray = [[String: Any]]()
    static var customerArray = [String]()
    static var customerDateArray = [String]()
    static var customerShoppingDetailArray = [[String: Any]]()
}





func getCustomerArray(){
    readGlobalVariables.customerArray.removeAll()
    let db = Firestore.firestore()
    let collectionRef3 = db.collection("\((Auth.auth().currentUser?.email)!)")
    collectionRef3.getDocuments { (querySnapshot, error) in
        if let error = error {
            print("Error getting documents: \(error)")
        } else {
            for document in querySnapshot!.documents {
                //let data = document.data()
                let docIds = document.documentID
                readGlobalVariables.customerArray.append(docIds)
            }
            //print(customerArray)
        }
    }
}
func readFirstCollections(customerName: String) {
    
    readGlobalVariables.customerDetailArray.removeAll()
    readGlobalVariables.customerDateArray.removeAll()
    readGlobalVariables.customerShoppingDetailArray.removeAll()

    let db = Firestore.firestore()
  
    //seçili müşteri ismine göre genel bilgileri çeker.
    let collectionRef = db.collection("\((Auth.auth().currentUser?.email)!)").document(customerName)
    collectionRef.getDocument { (document, error) in
        if let error = error {
            print("Error getting documents: \(error)")
        } else {
            let data = document!.data()
            readGlobalVariables.customerDetailArray.append(data!)
            //print(deneme.customerDetailArray[0]["name"] as! String)
        }
    }
    
    // seçili müşteri ismine göre alışveriş tarihini ve alışveriş detaylarını çeker
    let childCollectionRef = collectionRef.collection("Shopping Info")
    childCollectionRef.getDocuments { (querySnapshot, error) in
        if let error = error {
            print("Error getting documents: \(error)")
        } else {
            for document2 in querySnapshot!.documents {
                let data2 = document2.data()
                let docIds2 = document2.documentID
                readGlobalVariables.customerDateArray.append(docIds2)
                readGlobalVariables.customerShoppingDetailArray.append(data2)
            }
            print(readGlobalVariables.customerDateArray)
            print(readGlobalVariables.customerShoppingDetailArray[0]["adress"] as! String)
        }
    }
}

