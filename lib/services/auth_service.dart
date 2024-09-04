import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../pages/signin_page.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;

  // Check if the user is logged in
  static bool isLoggedIn() {
    final User? firebaseUser = _auth.currentUser;
    return firebaseUser != null;
  }

  // Get the current user ID
  static String currentUserId() {
    final User? firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      return firebaseUser.uid;
    } else {
      throw Exception("No user currently logged in");
    }
  }

  // Sign in user with email and password
  static Future<User?> signInUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      // Handle sign-in errors
      print("Error signing in: $e");
      return null;
    }
  }

  // Sign up user with fullname, email, and password
  static Future<User?> signUpUser(String fullname, String email, String password) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = authResult.user;
      if (user != null) {
        // Optionally, you can update user profile information here
        // e.g., user.updateProfile(displayName: fullname);
      }
      return user;
    } catch (e) {
      // Handle sign-up errors
      print("Error signing up: $e");
      return null;
    }
  }

  // Sign out user
  static Future<void> signOutUser(BuildContext context) async {
    try {
      await _auth.signOut();
      Navigator.pushReplacementNamed(context, SignInPage.id);
    } catch (e) {

      print("Error signing out: $e");
    }
  }
}
