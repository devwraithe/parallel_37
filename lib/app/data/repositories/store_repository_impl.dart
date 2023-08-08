import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parallel_37/app/core/utilities/constants.dart';
import 'package:parallel_37/app/domain/repositories/store_repository.dart';

import '../../core/utilities/errors/exceptions.dart';

class StoreRepositoryImpl implements StoreRepository {
  @override
  Future<void> createStore(Map<String, dynamic> data) async {
    try {
      final storeCollection = Constants.firestore.collection("stores");
      final storeDocRef = storeCollection.doc();
      final storeId = storeDocRef.id;

      await storeCollection.add({
        'user_id': Constants.firebaseAuth.currentUser!.uid,
        'store_id': storeId,
        'name': data['name'],
        'email': data['email'],
        'phone': data['phone'],
        "location": data['location']
      }).then((value) {
        debugPrint("Store Created: $value");
      }).catchError((err) {
        debugPrint("Error Creating Store: $err");
      });
    } on SocketException catch (e) {
      debugPrint("SocketException: $e");
      throw ConnectionException(Constants.socketError);
    } catch (e) {
      debugPrint("Something went wrong: $e");
      throw AuthException(Constants.unknownError);
    }
  }

  @override
  Future<String> getStoreId() async {
    try {
      final user = Constants.firebaseAuth.currentUser!;
      print("uid: ${user.uid}");
      final store = Constants.firestore.collection('stores');
      print("store: ${store.parent}");
      final querySnapshot =
          await store.where('user_id', isEqualTo: user.uid).get();
      print("query snapshot: ${querySnapshot.docs}");
      // directly access the first document
      final docSnapshot = querySnapshot.docs.first;
      // get the document id
      String docId = docSnapshot.id;
      // return the id
      return docId;
    } on SocketException catch (e) {
      throw ConnectionException(Constants.socketError);
    } catch (e) {
      debugPrint("Something went wrong: $e");
      return "";
    }
  }
}

// provider
final storeRepoProvider = Provider<StoreRepository>(
  (ref) => StoreRepositoryImpl(),
);
