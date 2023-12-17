import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temp_tracker/widgets/custom_toast.dart';

class CreateAccountController extends GetxController {

  TextEditingController nameC = TextEditingController();
    TextEditingController emailC = TextEditingController();

  TextEditingController passC = TextEditingController();

 var isLoading = false.obs;



 
  // Future<void> createUserData() async {
  //   try {
  //     UserCredential userCredential =
  //         await auth.createUserWithEmailAndPassword(
  //       email: emailC.text,
  //       password: passC.text,
  //     );

  //     await userCredential.user!.sendEmailVerification();
  //     if (userCredential.user != null) {
  //       RxString uid = userCredential.user!.uid.obs;

  //       DocumentReference user =
  //           firestore.collection("user").doc(uid.value);
  //       await user.set({
  //         "name": nameC.text,
  //         "email": emailC.text,
  //         "userId": uid.value,
  //         "createdAt": DateTime.now().toIso8601String(),
  //         "role":"Admin"
  //       });

  //       Get.back();

  //       CustomToast.successToast('تم إضافة مستخدم جديد بنجاح');
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       print('The password provided is too weak.');
  //               CustomToast.successToast('كلمة المرور قصيرة جدا يجب ان تحتوي على الاقل 6 احرف او ارقام');

  //     } else if (e.code == 'email-already-in-use') {
  //       CustomToast.errorToast('هذا الحساب موجود بالفعل');
  //     } else if (e.code == 'wrong-password') {
  //       CustomToast.errorToast('كلمة المرور خاطئة');
  //     } else {
  //       CustomToast.errorToast('error : ${e.code}');
  //       print("the problem is ${e.code}");
  //     }
  //   } catch (e) {
  //     CustomToast.errorToast(' خطأ: $e');
  //     print('the error is $e');
  //   }
  // }



}
