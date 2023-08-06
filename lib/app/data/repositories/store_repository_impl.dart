import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parallel_37/app/core/utilities/constants.dart';
import 'package:parallel_37/app/domain/repositories/store_repository.dart';

import '../../core/utilities/errors/exceptions.dart';

class StoreRepositoryImpl implements StoreRepository {
  @override
  Future<void> createStore(Map<String, dynamic> data) async {
    final itemsRef = Constants.firestore.collection("stores");
    try {
      final newItemRef = itemsRef.doc(); // this generates a new id
      final newItemId = newItemRef.id;

      await itemsRef.add({
        'store_id': newItemId,
        'name': data['name'],
        'email': data['email'],
        'phone': data['phone'],
        "location": data['location']
      }).then((value) {
        debugPrint("Flashcard created: $value");
      }).catchError((err) {
        debugPrint("Error creating flashcard: $err");
      });
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
final storeRepoProvider = Provider<StoreRepository>(
  (ref) => StoreRepositoryImpl(),
);
