import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parallel_37/app/core/utilities/constants.dart';
import 'package:parallel_37/app/core/utilities/errors/failure.dart';

import '../../../../core/utilities/errors/exceptions.dart';
import '../../domain/repositories/store_repository.dart';
import '../models/store_model.dart';

class StoreRepositoryImpl implements StoreRepository {
  // global variables
  final user = Constants.firebaseAuth.currentUser;

  @override
  Future<void> createStore(Map<String, dynamic> data) async {
    try {
      final storeCollection = Constants.firestore.collection("stores");

      await storeCollection.add({
        'user_id': Constants.firebaseAuth.currentUser!.uid,
        'name': data['name'],
        'email': data['email'],
        'phone': data['phone'],
        "location": data['location']
      }).then((value) {
        debugPrint("Store Created Successfully: $value");
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

  // check if the current user has a store created
  @override
  Future<Either<Failure, StoreModel>> checkStore() async {
    try {
      final querySnapshot = await Constants.firestore
          .collection('stores')
          // check if current user id is equal
          .where('user_id', isEqualTo: user!.uid)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        debugPrint("[QUERY DATA SNAPSHOT] ${querySnapshot.docs.first.data()}");
        final store = StoreModel.fromSnapshot(querySnapshot.docs.first);
        debugPrint("[PARSE IN MODEL] ${store.id}");
        return Right(store);
      } else {
        return Left(Failure(""));
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
