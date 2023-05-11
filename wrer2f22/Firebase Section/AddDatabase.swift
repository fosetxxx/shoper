//
//  AddDatabase.swift
//  wrer2f22
//
//  Created by Semih Karahan on 10.05.2023.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

struct addDatabase: View {
    
    // değişkenler
    @State private var showImagePicker = false
    @State private var selectedImages: [UIImage] = []
    @State private var isUploading = false
    @State private var currentUser = ""
    
    // bind edilerek db eklenecek değişkenler
    @State var shoppingNumber = String()
    @State var name = String()
    @State var surname = String()
    @State var citizenNo = String()
    @State var email = String()
    @State var birthday = String()
    @State var phone = String()
    @State var product = String()
    @State var adress = String()
    @State var billNumber = String()
    @State var cargoCompany = String()
    @State var cargoTrackingNumber = String()
    @State var note = String()
    // bind edilmeden ( kullanıcı görmeden ) db eklenecek değişkenler
    var currentDay = "\(Date())"
    @State var recordNumber: Int = 0
    
    
    var body: some View{
        VStack{
            List {
                Group{
                    TextField("Alışveriş No", text: $shoppingNumber)
                    TextField("Ad", text: $name)
                    TextField("Soyad", text: $surname)
                    TextField("T.C. No", text: $citizenNo)
                    TextField("E-posta", text: $email)
                    TextField("Doğum Tarihi", text: $birthday)
                    TextField("Telefon", text: $phone)
                }
                    .frame(width: 300, height: 30)
                    .background(Color(red: 0.2, green: 0.35, blue: 0.95, opacity: 0.2))
                    .foregroundColor(Color.black)
                    .accentColor(Color.white)
                    .border(Color.blue, width: 1)
                    .padding()
                Group{
                    TextField("Ürün", text: $product)
                    TextField("Adres", text: $adress)
                    TextField("Fatura No", text: $billNumber)
                    TextField("Kargo Firması", text: $cargoCompany)
                    TextField("Kargo Takip No", text: $cargoTrackingNumber)
                    TextField("Not", text: $note)
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
                
                Button("Kaydet") {
                    if name == "" || surname == "" || email == "" || phone == "" {
                        Alert().showAlert(title: "Hata", message: "Ad, soyad, e-posta ve telefon boş bırakılamaz.")
                    } else {
                        isUploading = true
                        uploadStrings()
                    }
                }
                
                if isUploading{
                    ActivityIndicator()
                }
            }
            
        }.sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImages: $selectedImages)
        }
    }
    
    func uploadStrings(){
        if let curUser = Auth.auth().currentUser?.email {
            currentUser = "\(curUser)" as String
            print(currentUser)
        } else {
            print("No admin detected!")
        }
        let customerNS = "\(name) \(surname)"
        let customerInfoArray = ["name" : name,
                                 "surname" : surname,
                                 "citizenNo" : citizenNo,
                                 "email" : email,
                                 "birthday" : birthday,
                                 "phone" : phone] as [String : Any]
        let shoppingInfoArray = ["recorNumber" : recordNumber,
                                 "adress" : adress,
                                 "product" : product,
                                 "billNumber" : billNumber,
                                 "cargoCompany" : cargoCompany,
                                 "cargoTrackingNumber" : cargoTrackingNumber,
                                 "note" : note] as [String : Any]
        
        let firestoreDatabase = Firestore.firestore()
        var firestoreRef : DocumentReference? = nil
        
        let db = Firestore.firestore()
        let parentDbRef = db.collection("\(currentUser)").document("\(customerNS)")
        parentDbRef.setData(customerInfoArray) { error in
            if error != nil {
                Alert().showAlert(title: "Hata", message: error?.localizedDescription ?? "Error")
            }
        }
        let childDbRef = parentDbRef.collection("Shopping Info").document("\(currentDay)")
        childDbRef.setData(shoppingInfoArray) { error in
            if error != nil {
                Alert().showAlert(title: "Hata", message: error?.localizedDescription ?? "Error")
            } else {
                let storage = Storage.storage()
                let storageRef = storage.reference()
                if selectedImages.isEmpty {
                    print("No image to upload.")
                    isUploading = false
                    shoppingNumber = ""
                    name = ""
                    surname = ""
                    citizenNo = ""
                    email = ""
                    birthday = ""
                    phone = ""
                    product = ""
                    adress = ""
                    billNumber = ""
                    cargoCompany = ""
                    cargoTrackingNumber = ""
                    note = ""
                } else {
                    for image in selectedImages {
                        guard let imageData = image.jpegData(compressionQuality: 0.8) else { continue }
                        let uuid = UUID().uuidString
                        let imageRef = storageRef.child("\(customerNS)_\(recordNumber)/\(customerNS)_\(uuid).jpeg")
                        let metaData = StorageMetadata()
                        metaData.contentType = "image/jpeg"
                        
                        imageRef.putData(imageData, metadata: metaData) { metaData, error in
                            if let error = error {
                                Alert().showAlert(title: "Hata", message: error.localizedDescription )
                                return
                            } else {
                                print("Upload OK!")
                                isUploading = false
                                isUploading = false
                                shoppingNumber = ""
                                name = ""
                                surname = ""
                                citizenNo = ""
                                email = ""
                                birthday = ""
                                phone = ""
                                product = ""
                                adress = ""
                                billNumber = ""
                                cargoCompany = ""
                                cargoTrackingNumber = ""
                                note = ""
                            }
                        }
                    }
                }
            }
        }
        
        
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




