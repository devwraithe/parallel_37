import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Constants {
  // strings
  static String fontFamily = "Mona";
  static String socketError = "No Internet Connection";
  static String unknownError = "Something went wrong";
  static String timeout = "Error connecting";
  static String empty = "Nothing here yet";

  // double
  static double inputRadius = 6;

  // firebase
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static User? user = firebaseAuth.currentUser;

  // others
  static AutovalidateMode validateMode = AutovalidateMode.onUserInteraction;
  static SizedBox prefixSpace = const SizedBox(width: 20);
  static EdgeInsets padding = const EdgeInsets.symmetric(
    horizontal: 18,
    vertical: 24,
  );
}
