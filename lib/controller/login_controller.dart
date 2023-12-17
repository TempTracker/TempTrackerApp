
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temp_tracker/routes/app_pages.dart';
import 'package:temp_tracker/widgets/custom_toast.dart';




class LoginController extends GetxController {
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

 var isLoading = false.obs;


// Future<void> login() async {
//   isLoading.value = true;

//   if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
//     try {
//       final credential = await auth.signInWithEmailAndPassword(
//         email: emailC.text.trim(),
//         password: passC.text,
//       );

   
//       isLoading.value = false;

//       // Assuming getUser and updateUser are asynchronous operations.
//       await updateUser();

//       await Get.offNamed(Routes.MAINPAGE);
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         CustomToast.errorToast("الحساب غير موجود".tr);
//       } else if (e.code == 'wrong-password') {
//         CustomToast.errorToast("كلمة المرور غير صحيحة".tr);
//       } else {
//         CustomToast.errorToast("${"Error_because".tr}${e.toString()}");
//         print('the error $e');
//       }
//       isLoading.value = false;
//     } catch (e) {
//       CustomToast.errorToast("${"Error_because".tr}${e.toString()}");
//       print('the error $e');
//       isLoading.value = false;
//     }
//   } else {
//     CustomToast.errorToast('please_complete_data'.tr);
//     isLoading.value = false;
//   }


// }






  void logout() async {
    // //await auth.signOut();
    // Get.delete<HomeController>();
    // Get.offAllNamed(Routes.LOGIN);
  }
}