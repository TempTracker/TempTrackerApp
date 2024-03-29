
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temp_tracker/routes/app_pages.dart';
import 'package:temp_tracker/widgets/custom_toast.dart';




class LoginController extends GetxController {
   FirebaseAuth auth = FirebaseAuth.instance;
     FirebaseFirestore firestore = FirebaseFirestore.instance;
  LoginController({required this.sharedPreferences});

  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
 final SharedPreferences sharedPreferences;

 var isLoading = false.obs;


Future<void> login() async {
  isLoading.value = true;

  if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
    try {
      final credential = await auth.signInWithEmailAndPassword(
        email: emailC.text.trim(),
        password: passC.text,
      );
 sharedPreferences.setString('userId', auth.currentUser!.uid); //????????

       await  getUser();
          
          // Get the user's email and username from Firebase Authentication
          String email = auth.currentUser!.email ?? '';
          
          // Store the user's email andusername in SharedPreferences
          sharedPreferences.setString('email', email);
          

   
      isLoading.value = false;

   

      await Get.offNamed(Routes.MAINPAGE, arguments:  auth.currentUser!.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        CustomToast.errorToast("Account not found");
      } else if (e.code == 'wrong-password') {
        CustomToast.errorToast("Wrong Email or Password");
      } else {
        CustomToast.errorToast("Wrong Email or Password");
        print('the error $e');
      }
      isLoading.value = false;
    } catch (e) {
        CustomToast.errorToast("Wrong Email or Password");
      print('the error $e');
      isLoading.value = false;
    }
  } else {
    CustomToast.errorToast('Please complete all the fields');
    isLoading.value = false;
  }


}



  Future getUser() async {
    String? phone;
    String? userName;
    String? email;
    await firestore
        .collection('user')
        .doc(auth.currentUser!.uid)
        .get()
        .then((data) {
            userName = data['name'];
      phone = data['phone'];
    
      email = data['email'];
      sharedPreferences.setString('name', userName!);

      sharedPreferences.setString('phone', phone!);
        sharedPreferences.setString('email', email!);
    });
  }

}