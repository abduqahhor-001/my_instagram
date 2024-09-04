import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_myinsta/pages/signup_page.dart';

import '../services/auth_service.dart';
import '../services/utils_service.dart';
import 'home_page.dart';

class SignInPage extends StatefulWidget {
  static final String id = "signin_page";

  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var isLoading = false;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  _doSignIn() async {
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();

    if (email.isEmpty || password.isEmpty) {
      Utils.fireToast("Please fill all fields");
      return;
    }

    setState(() {
      isLoading = true;
    });

    var user = await AuthService.signInUser(email, password);
    _responseSignIn(user);
  }

  _responseSignIn(User? user) {
    setState(() {
      isLoading = false;
    });

    if (user != null) {
      Navigator.pushReplacementNamed(context, HomePage.id);
    } else {
      Utils.fireToast("Sign In failed. Please check your credentials.");
    }
  }

  _callSignUpPage() {
    Navigator.pushReplacementNamed(context, SignUpPage.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(193, 53, 132, 1),
                Color.fromRGBO(131, 58, 180, 1),
              ]),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Instagram",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 45,
                              fontFamily: "Billabong"),
                        ),

                        //#email
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          height: 50,
                          padding: EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(7)),
                          child: TextField(
                            controller: emailController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                hintText: "Email",
                                border: InputBorder.none,
                                hintStyle:
                                TextStyle(fontSize: 17, color: Colors.white54)),
                          ),
                        ),

                        //#password
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          height: 50,
                          padding: EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(7)),
                          child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                hintText: "Password",
                                border: InputBorder.none,
                                hintStyle:
                                TextStyle(fontSize: 17, color: Colors.white54)),
                          ),
                        ),

                        //#signin
                        GestureDetector(
                          onTap: () {
                            _doSignIn();
                          },
                          child: Container(
                              margin: EdgeInsets.only(top: 10),
                              height: 50,
                              padding: EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(7)),
                              child: Center(
                                child: Text(
                                  "Sign In",
                                  style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                                ),
                              )),
                        ),
                      ],
                    )),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don`t have an account?",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                          onTap: () {
                            _callSignUpPage();
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                ),
              ],
            ),
            isLoading
                ? Center(
              child: CircularProgressIndicator(),
            )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
