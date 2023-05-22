

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class VendorController {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

 

//FUNCTION TO STORE IMAGE IN FIREBASE STORE

 _uploadVendorImageToStorage(Uint8List? image)async{
  Reference ref = 
       _storage.ref().child('storeImages').child(_auth.currentUser!.uid);

  UploadTask uploadTask = ref.putData(image!);

  TaskSnapshot snapshot = await uploadTask;

  String downloadUrl = await snapshot.ref.getDownloadURL();

  return downloadUrl;

 }

//FUNCTION TO STORE IMAGE IN FIREBASE STORAGE END HERE
  //FUNCTION TO PICK STORE IMAGE
  pickStoreImage(ImageSource source)async{
    final ImagePicker _imagePicker = ImagePicker();
   XFile? _file = await _imagePicker.pickImage(source: source);

   if(_file!=null){
    return await _file.readAsBytes();
   }else{
    print('No Image Selected');
   }
  }

//FUNCTION TO PICK STORE IMAGE ENDS HERE

  
//FUNCTION TO SAVE VENDORE DATA
 Future< String> registerVendor(
    String bussinessName, 
    String email, 
    String phoneNumber, 
    String countryValue, 
    String stateValue, 
    String cityValue, 
    String taxRegistered, 
    String taxNumber,
    Uint8List? image,
    ) async{
      String res = 'some error occured' ;
      try {
        
        String storeImage = await _uploadVendorImageToStorage(image);
            //save data to cloud firestore

          await _firestore
            .collection('vendors').doc(_auth.currentUser!.uid).set({
              'bussinessName': bussinessName,
              'email' : email,
              'phoneNumber': phoneNumber,
              'countryValue': cityValue,
              'stateValue': stateValue,
              'cityValue': cityValue,
              'taxRegistered': taxRegistered,
              'taxNumber': taxNumber,
              'storeImage':storeImage,
              'approved':false,
              'vendorId': _auth.currentUser!.uid,
            });
         
          ;
      } catch (e) {
        res = e.toString();
      }
      return res;
  }

 //FUNCTION TO SAVE DATE END HERE
}