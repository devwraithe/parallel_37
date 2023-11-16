import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parallel_37/app/core/utilities/constants.dart';
import 'package:parallel_37/app/data/models/menu_model.dart';

import '../../core/utilities/errors/exceptions.dart';
import '../../core/utilities/errors/failure.dart';
import '../../domain/repositories/menu_repository.dart';
import '../models/menu_item_model.dart';

class MenuRepositoryImpl implements MenuRepository {
  // global variables
  final user = Constants.firebaseAuth.currentUser;

  @override
  Future<void> createMenu(Map<String, dynamic> data) async {
    try {
      final storeCollection = Constants.firestore.collection("stores");
      final storeDocRef = storeCollection.doc(data['store_id']);
      final menuCollection = storeDocRef.collection("store_menu");

      await menuCollection.add({
        'menu_type': data['menu_type'],
        'menu_name': data['menu_name'],
        'user_id': user!.uid,
      }).then((value) {
        debugPrint("Menu Created: $value");
      }).catchError((err) {
        debugPrint("Error Creating Menu: $err");
      });
    } on SocketException catch (e) {
      debugPrint("SocketException: $e");
      throw ConnectionException(Constants.socketError);
    } catch (e) {
      debugPrint("Something went wrong: $e");
      throw AuthException(Constants.unknownError);
    }
  }

  // show the a list of the menu
  @override
  Future<Either<Failure, List<MenuModel>>> getMenu(String id) async {
    try {
      final storeCollection = Constants.firestore.collection("stores");
      final storeDocRef = storeCollection.doc(id);
      final querySnapshot = await storeDocRef
          .collection('store_menu')
          // retrieve menu with the user_id or store id (poss)
          .where('user_id', isEqualTo: user!.uid)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        debugPrint("[QUERY DATA SNAPSHOT] ${querySnapshot.docs.first.data()}");
        final menuList = querySnapshot.docs.map((menu) {
          return MenuModel.fromSnapshot(menu);
        }).toList();
        debugPrint("[PARSE IN MODEL] ${menuList.length}");
        return Right(menuList);
      } else {
        return Left(Failure("No Menu"));
      }
    } on SocketException catch (_) {
      throw ConnectionException(Constants.socketError);
    } on FirebaseAuthException catch (e) {
      debugPrint("[AUTH EXCEPTION] $e");
      throw ServerException(e.toString());
    } on FirebaseException catch (e) {
      debugPrint("[FIREBASE EXCEPTION] $e");
      throw ServerException(e.toString());
    } catch (e) {
      debugPrint("[SOMETHING WENT WRONG]: $e");
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> createMenuItem(Map<String, dynamic> data) async {
    try {
      final storeCollection = Constants.firestore.collection("stores");
      final storeDocRef = storeCollection.doc(data['store_id']);
      final menuCollection = storeDocRef.collection("store_menu");
      final menuDocRef = menuCollection.doc(data['menu_id']);
      final menuItemCollection = menuDocRef.collection(data['type']);

      await menuItemCollection.add({
        'name': data['name'],
        'price': data['price'],
        'user_id': user!.uid,
      }).then((value) {
        debugPrint("Menu Item Created: $value");
      }).catchError((err) {
        debugPrint("Error Creating Menu Item: $err");
      });
    } on SocketException catch (e) {
      debugPrint("SocketException: $e");
      throw ConnectionException(Constants.socketError);
    } catch (e) {
      debugPrint("Something went wrong: $e");
      throw AuthException(Constants.unknownError);
    }
  }

  // show the a list of the menu
  @override
  Future<Either<Failure, List<MenuItemModel>>> getMenuItems(
      Map<String, dynamic> data) async {
    try {
      print("Data coming from ui: $data");
      final storeCollection = Constants.firestore.collection("stores");
      final storeDocRef = storeCollection.doc(data['store_id']);
      final menuCollection = storeDocRef.collection("store_menu");
      final menuDocRef = menuCollection.doc(data['menu_id']);

      final querySnapshot = await menuDocRef
          .collection(data['type'])
          // retrieve menu with the user_id or store id (poss)
          .where('user_id', isEqualTo: user!.uid)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        debugPrint("[QUERY DATA SNAPSHOT] ${querySnapshot.docs.first.data()}");
        final menuItemList = querySnapshot.docs.map((menu) {
          return MenuItemModel.fromSnapshot(menu);
        }).toList();
        debugPrint("[PARSE IN MODEL] ${menuItemList.length}");
        return Right(menuItemList);
      } else {
        return Left(Failure("No Menu"));
      }
    } on SocketException catch (_) {
      throw ConnectionException(Constants.socketError);
    } on FirebaseAuthException catch (e) {
      debugPrint("[AUTH EXCEPTION] $e");
      throw ServerException(e.toString());
    } on FirebaseException catch (e) {
      debugPrint("[FIREBASE EXCEPTION] $e");
      throw ServerException(e.toString());
    } catch (e) {
      debugPrint("[SOMETHING WENT WRONG]: $e");
      throw ServerException(e.toString());
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
