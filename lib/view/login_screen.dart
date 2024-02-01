
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temp_tracker/controller/login_controller.dart';
import 'package:temp_tracker/routes/app_pages.dart';
import 'package:temp_tracker/style/app_color.dart';
import 'package:temp_tracker/style/fonts.dart';
import 'package:temp_tracker/widgets/custom_input.dart';

class LoginScreen  extends  GetView<LoginController> {
   const LoginScreen ({super.key});

  @override
  Widget build(BuildContext context) {
      

          var size = MediaQuery.of(context).size;

    return  Scaffold(
      appBar: AppBar(title: Text( 'Login', style: robotoHugeWhite,),
       backgroundColor:  AppColor.primaryColor, iconTheme: const IconThemeData(
    color: Colors.white,), 
       ),
      body: Padding(padding: const EdgeInsets.only(left: 26,right: 26),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.1,),
      //          Container(
      //   width: size.width * 1 , 
      //   height: size.height * 0.2,
      //   child: Image.asset(Images.Logo),
      // ),
              const SizedBox(height: 50),
              const Text('LOGIN' ,style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold
              ),),                        const SizedBox(height: 20),
    
                CustomInput(
                  controller: controller.emailC, label:  'Email', hint: ''),
                  
                                                const SizedBox(height: 16),

                          
                        
                    CustomInput(
                    
                  controller: controller.passC, label:  'Password', hint: '',obscureText: true),
    
                                    const SizedBox(height:30),
      
          SizedBox(
                width: double.infinity,
        height: size.height * 0.09,
            child: ElevatedButton(
            onPressed: ()  async{
controller. login();
            },
             style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.primaryColor,
          ),
            child:Obx(
        () {
      return controller.isLoading.value
          ? const CircularProgressIndicator(color: Colors.white,)
          :  Text('login',style: robotoHugeWhite,);
        },
      ),
    
          ), 
          ),
    TextButton(onPressed: (){

Get.toNamed(Routes.FORGETPASSWORD);

    }, child: Text("Forget your password?"))
    
            ],
          ),
        ),
      ),
   
    );
  }
}