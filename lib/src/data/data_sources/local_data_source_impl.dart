import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:parallel_37/src/core/api_utils.dart';
import 'package:parallel_37/src/data/data_sources/local_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:parallel_37/src/data/models/store_model.dart';

class LocalDataSourceImpl implements LocalDataSource {
  final http.Client client;
  const LocalDataSourceImpl(this.client);

  @override
  Future<List<StoreModel>> getMightLikeStores() async {
    try {
      final response =
          await rootBundle.loadString(AppConstants.mightLikeStores);
      final List responseData = await json.decode(response)["data"];
      List<StoreModel> stores = [];
      stores = responseData
          .map<StoreModel>(
            (storeJson) => StoreModel.fromJson(storeJson),
          )
          .toList();
      return stores;
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future<List<StoreModel>> popularStores() async {
    try {
      final response =
          await rootBundle.loadString(AppConstants.popularStores);
      final List responseData = await json.decode(response)["data"];
      List<StoreModel> stores = [];
      stores = responseData
          .map<StoreModel>(
            (storeJson) => StoreModel.fromJson(storeJson),
          )
          .toList();
      return stores;
    } catch (err) {
      rethrow;
    }
  }
}
