//
//  AddData.swift
//  wrer2f22
//
//  Created by Semih Karahan on 4.05.2023.
//
import SwiftUI
import FirebaseStorage
import FirebaseFirestore


struct addData: View {
    
    // değişkenler
    var currentDate = "\(Date())"
    @State var result: String? = nil
    @State private var isUploading = false
    @State private var selectedImages: [UIImage] = []
    @State private var showImagePicker = false
    
    // müşteri değişkenleri (Yeni eklemek için @State, Textfield group ve buyerDatas listesine ekle. Fonksiyon içinde yeni eklediklerini sıfırla ("").)
    @State var processNo: String = ""
    @State var buyerName: String = ""
    @State var buyerSurname: String = ""
    @State var buyerPhone: String = ""
    @State var buyerAdress: String = ""
    @State var shopping: String = ""
    @State var note: String = ""
    

    //View
    var body: some View {
        VStack{
            Group{
                TextField("  No", text: $processNo)
                TextField("  Name", text: $buyerName)
                TextField("  Surname", text: $buyerSurname)
                TextField("  Phone", text: $buyerPhone)
                TextField("  Adress", text: $buyerAdress)
                TextField("  Shopping", text: $shopping)
                TextField("  Note", text: $note)
            }
            .frame(width: 300, height: 30)
            .background(Color(red: 0.2, green: 0.35, blue: 0.95, opacity: 0.2))
            .foregroundColor(Color.black)
            .accentColor(Color.white)
            .border(Color.blue, width: 1)
            .padding()
                
            
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
            
            
            Button("Upload") {
                if processNo == "" || buyerName == "" || buyerSurname == "" || buyerPhone == "" || buyerAdress == "" || shopping == "" {
                    Alert().showAlert(title: "Error", message: "Please fill in all fields")
                } else {
                    isUploading = true
                    uploadStrings()
                }
            }
            
            
            if isUploading{
                ActivityIndicator()
            }
            
            
            Spacer()
            
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImages: $selectedImages)
        }
    }
    

    // data upload
    func uploadStrings() {
        let buyerDatas =
        [
            "date" : currentDate,
            "processNo" : processNo,
            "buyerName" : buyerName,
            "buyerSurname" : buyerSurname,
            "buyerPhone" : buyerPhone,
            "buyerAdress" : buyerAdress,
            "shopping" : shopping,
            "note" : note
        ] as [String : Any]
        
        let firestoreDatabase = Firestore.firestore()
        var firestoreRef : DocumentReference? = nil
        
        firestoreRef = firestoreDatabase.collection("Buyers").addDocument(data: buyerDatas, completion: { error in
            if error != nil {
                Alert().showAlert(title: "Error", message: error?.localizedDescription ?? "Error")
            } else {
                if let curDocId = firestoreRef?.documentID {
                    let storage = Storage.storage()
                    let storageRef = storage.reference()
                    if selectedImages.isEmpty {
                        print("No image to upload.")
                        isUploading = false
                        processNo = ""
                        buyerName = ""
                        buyerSurname = ""
                        buyerPhone = ""
                        buyerAdress = ""
                        shopping = ""
                        note = ""
                    } else {
                        for image in selectedImages {
                            guard let imageData = image.jpegData(compressionQuality: 0.8) else { continue }
                            let uuid = UUID().uuidString
                            let imageRef = storageRef.child("\(curDocId)/\(uuid).jpg")
                            let metadata = StorageMetadata()
                            metadata.contentType = "image/jpeg"
                            
                            imageRef.putData(imageData, metadata: metadata) { (metadata, error) in
                                if let error = error {
                                    Alert().showAlert(title: "Upload Error!", message: error.localizedDescription)
                                    return
                                } else {
                                    print("Upload OK!")
                                    isUploading = false
                                    selectedImages.removeAll()
                                    processNo = ""
                                    buyerName = ""
                                    buyerSurname = ""
                                    buyerPhone = ""
                                    buyerAdress = ""
                                    shopping = ""
                                    note = ""
                                }
                            }
                        }
                    }

                }
            }
        })
    }
}
    
    


// image picker kodu
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


// loading animasyonu
struct ActivityIndicator: UIViewRepresentable {
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let indicatorView = UIActivityIndicatorView(style: .large)
        indicatorView.color = .red
        indicatorView.startAnimating()
        return indicatorView
    }
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {}
}
