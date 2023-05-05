//
//  Storage.swift
//  BestSeller
//
//  Created by Semih Karahan on 29.04.2023.
//
/*
import SwiftUI
import FirebaseStorage
import FirebaseFirestore

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImages: [UIImage]
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = ["public.image"]
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImages.append(image)
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

var tolgayan = ""

struct StorageSection: View {
    @State private var selectedImages: [UIImage] = []
    @State var imageURLs: [String] = []
    @State private var showImagePicker = false
    @State private var isUploading = false
    var currentDate = "\(Date())"
    
   

    var body: some View {

        VStack {
            ScrollView(.horizontal) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.blue)
                        .onTapGesture {
                            showImagePicker = true
                        }
                        .padding()
                    ForEach(selectedImages, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .scaledToFill()
                            .clipped()
                    }
                }
            }
            .frame(height: 150)
            .padding()

            Button("Upload Photos") {
                databaseUpload(processNo: "tol1", buyerName: "tol2", buyerPhone: "tol3", buyerAdress: "tol5")
                isUploading = true
                print("\(tolgayan) olmuyo aq")
                uploadImagesToFirebaseStorage(images: selectedImages) { urls in
                    isUploading = false
                    if let urls = urls {
                        self.imageURLs = urls
                    }
                }
            }

            
            if isUploading {
                ActivityIndicator()
            }
            
            Spacer()

        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImages: $selectedImages)
        }
    }
    
    
    // database upload
    func databaseUpload
    (
                    processNo: String,
                    buyerName: String,
                    buyerPhone: String,
                    buyerAdress: String
    ){
        
        let firestorePost =
        [
            "date" : currentDate,
            "processNo" : processNo,
            "buyerName" : buyerName,
            "buyerPhone" : buyerPhone,
            "buyerAdress" : buyerAdress
        ] as [String : Any]
        
                        
        let firestoreDatabase = Firestore.firestore()
        var firestoreRef : DocumentReference? = nil
        
        firestoreRef = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { error in
            if error != nil {
                Alert().showAlert(title: "Error", message: error?.localizedDescription ?? "Error")
            } else {
                if let curDocId = firestoreRef?.documentID {
                    tolgayan = curDocId
                } else {
                    Alert().showAlert(title: "Hata", message: "Doc id alamadı")
                }
            }
            
        })
        
        
    }

    // Storage upload
    func uploadImagesToFirebaseStorage(images: [UIImage], completion: @escaping ([String]?) -> Void) {
        var imageURLs: [String] = []
        let group = DispatchGroup()
        
        
        for image in images {
            group.enter()
            guard let imageData = image.jpegData(compressionQuality: 0.5) else {
                group.leave()
                completion(nil)
                return
            }
            
            let storageRef = Storage.storage().reference()
            let imageRef = storageRef.child("\(tolgayan)/\(UUID().uuidString).jpg")
            
            imageRef.putData(imageData, metadata: nil) { (metadata, error) in
                if let error = error {
                    print("Error uploading image: \(error.localizedDescription)")
                    group.leave()
                    completion(nil)
                    return
                }
                
                imageRef.downloadURL { (url, error) in
                    if let error = error {
                        print("Error retrieving download URL: \(error.localizedDescription)")
                        group.leave()
                        completion(nil)
                        return
                    }
                    
                    if let url = url {
                        imageURLs.append(url.absoluteString)
                        group.leave()
                    }
                }
            }
        }
        
        group.notify(queue: .main) {
            completion(imageURLs)
        }
    }
}


// loading animasyonu
struct ActivityIndicator: UIViewRepresentable {
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let indicatorView = UIActivityIndicatorView(style: .large)
        indicatorView.color = .gray
        indicatorView.startAnimating()
        return indicatorView
    }
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {}
}
*/
