//
//  ReadStorage.swift
//  wrer2f22
//
//  Created by Semih Karahan on 7.05.2023.
//

import FirebaseStorage
import Foundation

func callImages(for folder: String, completion: @escaping ([URL]?, Error?) -> Void) {
    let storage = Storage.storage()
    let storageRef = storage.reference()
    let folderRef = storageRef.child(folder)
    
    folderRef.listAll { (result, error) in
        if let error = error {
            completion(nil, error)
            return
        }
        
        guard let result = result else {
            completion(nil, NSError(domain: "com.yourapp", code: 1, userInfo: [NSLocalizedDescriptionKey: "StorageListResult is nil"]))
            return
        }
        
        var urls = [URL]()
        for item in result.items {
            item.downloadURL { (url, error) in
                if let error = error {
                    completion(nil, error)
                    return
                }
                
                if let url = url {
                    urls.append(url)
                }
                
                if urls.count == result.items.count {
                    completion(urls, nil)
                }
            }
        }
    }
}






/*
 
import URLImage
 
 
@State private var buttonTapped = false
@State var urlArray = [String]()
@State private var folder = "T6ru3emJI6v86dJZ6Cca"
 
Button("getUrl") {
 
    buttonTapped = true
 
    callImages(for: folder) { urls, error in
        if let error = error {
            print(error.localizedDescription)
        } else if let urls = urls {
            for i in urls {
                let stringUrl: String = i.absoluteString
                urlArray.append(stringUrl)
            }
        }
    }
 
}


if buttonTapped {
 ScrollView(.horizontal) {
     HStack {
         ForEach(urlArray, id: \.self) { imageUrl in
             AsyncImage(url: URL(string: imageUrl)) { image in
                 image
                     .resizable()
                     .aspectRatio(contentMode: .fit)
             } placeholder: {
                 ProgressView()
             }
             .frame(width: 100, height: 100)
         }
     }
 }.padding()
}

*/
 
 
