import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:parallel_37/app/core/utilities/errors/failure.dart';

import '../../../core/utilities/constants.dart';
import '../../../core/utilities/errors/exceptions.dart';
import '../domain/inventory_repository.dart';

class InventoryRepositoryImpl implements InventoryRepository {
  @override
  Future<Either<Failure, void>> addCategory(String category) async {
    try {
      final categories = Constants.firestore.collection("categories");

      await categories.add({
        'category': category,
      });

      return const Right(null);
    } catch (e) {
      if (e is FirebaseException) {
        return Left(Failure(e.message ?? Constants.unknownError));
      }
      throw ServerException(Constants.unknownError);
    }
  }

  @override
  Future<Either<Failure, List<String>>> getCategories() async {
    try {
      final categories = Constants.firestore.collection('categories');
      final querySnapshot = await categories.get();

      if (querySnapshot.docs.isNotEmpty) {
        final categoriesList = querySnapshot.docs.map((doc) {
          return doc['category'] as String;
        }).toList();

        return Right(categoriesList);
      } else {
        return Left(Failure(Constants.empty));
      }
    } on SocketException catch (_) {
      throw ConnectionException(Constants.socketError);
    } on TimeoutException catch (_) {
      throw ConnectionException(Constants.timeout);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
