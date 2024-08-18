import 'package:flutter/material.dart';
import 'package:flutter_myinsta/pages/signin_page.dart';
import 'package:flutter_myinsta/services/utils_service.dart';

import 'home_page.dart';

class SignupPage extends StatefulWidget {
  static final String id = "signup_page";
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var isLoading = false;

  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordContoller = TextEditingController();
  var cPasswordContoller = TextEditingController();

  _doSignUp(){
    String fullName = fullNameController.text.toString().trim();
    String email = emailController.text.toString().trim();
    String password = passwordContoller.text.toString().trim();
    String cPassword = cPasswordContoller.text.toString().trim();
    if(email.isEmpty || password.isEmpty || cPassword.isEmpty || fullName.isEmpty) return;

    if(password != cPassword){
      Utils.fireToast("iltimos parol va qayta parolni bir hil kirgazing");
      return ;
    }

    Navigator.pushReplacementNamed(context, HomePage.id);
  }
  _callSignIn(){
    Navigator.pushReplacementNamed(context, SigninPage.id);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(232, 150, 94, 1.0),
                  Color.fromRGBO(211, 102, 64, 1.0),
                ]
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),

                        child: Column(

                          children: [
                            Text("Instagram", style: TextStyle(color: Colors.white, fontSize: 50,fontFamily: "Billabong"),),

                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10 , right: 10),
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(206, 150, 108, 1.0),
                                borderRadius: BorderRadius.circular(8),

                              ),
                              child: TextField(
                                controller: fullNameController,
                                style: TextStyle(fontSize : 16, color:  Colors.white),
                                decoration: InputDecoration(
                                  hintText: "Fullname",
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(fontSize: 17 ,color: Colors.white24),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10 , right: 10),
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(206, 150, 108, 1.0),
                                borderRadius: BorderRadius.circular(8),

                              ),
                              child: TextField(
                                controller: emailController,
                                style: TextStyle(fontSize : 16, color:  Colors.white),
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(fontSize: 17 ,color: Colors.white24),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10 , right: 10),
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(206, 150, 108, 1.0),
                                borderRadius: BorderRadius.circular(8),

                              ),
                              child: TextField(
                                controller: passwordContoller,
                                obscureText: true,
                                style: TextStyle(fontSize : 16, color:  Colors.white),
                                decoration: InputDecoration(

                                  hintText: "password",
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(fontSize: 17 ,color: Colors.white24),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10 , right: 10),
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(206, 150, 108, 1.0),
                                borderRadius: BorderRadius.circular(8),

                              ),
                              child: TextField(
                                controller: cPasswordContoller,
                                obscureText: true,
                                style: TextStyle(fontSize : 16, color:  Colors.white),
                                decoration: InputDecoration(

                                  hintText: "Confirm password",
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(fontSize: 17 ,color: Colors.white24),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: (){
                                _doSignUp();
                              },
                              child: Container(

                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1.0 ,color: Color.fromRGBO(206, 150, 108, 1.0)),
                                    borderRadius: BorderRadius.circular(8),
                                  ),

                                  child: Center(
                                    child:  Text("Sign up",style: TextStyle(fontSize: 17 ,color: Colors.white24),),
                                  )


                              ),
                            )
                          ],
                        ),

                      )
                    ],
                  )
              ),
              GestureDetector(
                onTap: (){
                  _callSignIn();
                },
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Alread have an account?",style: TextStyle(color: Colors.white,fontSize: 16 ),),
                    Text("Sign in",style: TextStyle(color: Colors.white,fontSize: 16 , fontWeight: FontWeight.bold ),),

                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        )
    );
  }

}
