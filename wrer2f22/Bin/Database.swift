//
//  Database.swift
//  BestSeller
//
//  Created by Semih Karahan on 30.04.2023.
//


/*
import Foundation
import FirebaseFirestore


var tolgayan = ""

class DatabaseSelection {
    
    
    var processNo : String
    var buyerName: String
    var buyerPhone: String
    var buyerAdress: String
    
    
    
    
    init(processNo: String, buyerName: String, buyerPhone: String, buyerAdress: String) {
        self.processNo = processNo
        self.buyerName = buyerName
        self.buyerPhone = buyerPhone
        self.buyerAdress = buyerAdress
    }

    
    // database upload komutları
    func databaseUpload(){
        
        let firestorePost =
        [
            "date" : currentDate,
            "processNo" : processNo,
            "buyerName" : buyerName,
            "buyerPhone" : buyerPhone,
            "buyerAdress" : buyerAdress
        ] as [String : Any]
        
        firestoreRef = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { error in
            if error != nil {
                Alert().showAlert(title: "Error", message: error?.localizedDescription ?? "Error")
            } else {
                if let curDocId = self.firestoreRef?.documentID {
                    tolgayan = curDocId
                } else {
                    Alert().showAlert(title: "Hata", message: "Doc id alamadı")
                }
            }
        })
        
        
    }
    
    func databaseRead() {
        
    }
    
}
*/
