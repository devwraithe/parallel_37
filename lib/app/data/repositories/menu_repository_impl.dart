import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parallel_37/app/core/utilities/constants.dart';

import '../../core/utilities/errors/exceptions.dart';
import '../../domain/repositories/menu_repository.dart';

class MenuRepositoryImpl implements MenuRepository {
  @override
  Future<void> createMenu(Map<String, dynamic> data) async {
    try {
      // for stores
      final storeCollection = Constants.firestore.collection("stores");
      final storeDocRef = storeCollection.doc(data['store_id']);

      final menuCollection = storeDocRef.collection("store_menu");
      // final menuDocRef = menuCollection.doc();
      // final menuId = menuDocRef.id;

      // add a menu to the store menu
      menuCollection;
      //     .add({
      //   'user_id': Constants.firebaseAuth.currentUser!.uid,
      // }).then((value) {
      //   debugPrint("Store Created: $value");
      // }).catchError((err) {
      //   debugPrint("Error Creating Store: $err");
      // });

      // reference to the parent document i.e stores
      // final storesCollectionRef = Constants.firestore.collection("stores");
      // final storesDocumentRef = storesCollectionRef.doc(data['store_id']);

      // // create a sub-collection in the parent doc
      // final menuCollectionRef = Constants.firestore.collection('menu');
      //
      // print("Menu - ${menuCollectionRef}");
      //
      // // // add info to the sub-collection
      // // menuCollectionRef.add({
      // //   "collection_info": "something for the menu docs",
      // //   "store_id": data['store_id'],
      // // }).then((value) {
      // //   debugPrint("Done: $value");
      // // }).catchError((err) {
      // //   debugPrint("Error: $err");
      // // });
    } on SocketException catch (e) {
      debugPrint("SocketException: $e");
      throw ConnectionException(Constants.socketError);
    } catch (e) {
      debugPrint("Something went wrong: $e");
      throw AuthException(Constants.unknownError);
    }
  }

  @override
  Future<String> getMenuDocId(Map<String, dynamic> data) async {
    try {
      final menu = Constants.firestore.collection('menu');
      print("store: ${menu.parent}");
      final querySnapshot = await menu
          .where(
            'store_id',
            isEqualTo: data['store_id'],
          )
          .get();
      print("query snapshot: ${querySnapshot.docs}");
      // directly access the first document
      final docSnapshot = querySnapshot.docs.first;
      // get the document id
      String docId = docSnapshot.id;
      print("menu id");
      // return the id
      return docId;
    } on SocketException catch (e) {
      throw ConnectionException(Constants.socketError);
    } catch (e) {
      debugPrint("Something went wrong: $e");
      return "";
    }
  }

  // add item to menu
  @override
  Future<void> addItemToMenu(Map<String, dynamic> data) async {
    try {
      // for stores
      final storeCollection = Constants.firestore.collection("stores");
      final storeDocRef = storeCollection.doc(data['store_id']);

      final menuCollection = storeDocRef.collection("store_menu");
      final menuDocRef = menuCollection.doc(data['menu_id']);

      final menuItemCollection = storeDocRef.collection("burgers");
      // final menuId = menuDocRef.id;

      // add a menu to the store menu
      menuItemCollection;

      // // reference to the menu collection within stores
      // // final storesCollection = Constants.firestore.collection('stores');
      // // final storesDoc = storesCollection.doc(data['store_id']);
      // final menuCollection = Constants.firestore.collection('menu');
      // print(">>> Menu ID: ${data['menu_id']} <<<");
      // final menuDocument = menuCollection.doc(data['menu_id']);
      // final itemCollection = menuDocument.collection("burgers"); // dynamic
      // // create the item in the menu e.g burgers
      // itemCollection.add({
      //   'menu_name': 'burgers',
      // }).then((value) {
      //   debugPrint("Done: $value");
      // }).catchError((err) {
      //   debugPrint("Error: $err");
      // });
      // add burger variations to the "Burgers" document (similar to your previous code)
      // await burgersDocumentRef.collection('variations');
      //     .add({
      //   'itemName': 'Hamburger',
      //   'itemDescription': 'Classic beef patty...',
      //   'itemPrice': 5.99,
      // }).then((value) {
      //   debugPrint("Flashcard created: $value");
      // }).catchError((err) {
      //   debugPrint("Error creating flashcard: $err");
      // });
    } on SocketException catch (e) {
      debugPrint("SocketException: $e");
      throw ConnectionException(Constants.socketError);
    } catch (e) {
      debugPrint("Something went wrong: $e");
      throw AuthException(Constants.unknownError);
    }
  }
}

// provider
final menuRepoProvider = Provider<MenuRepository>(
  (ref) => MenuRepositoryImpl(),
);
