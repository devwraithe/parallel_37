import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:parallel_37/src/core/failure.dart';
import 'package:parallel_37/src/data/data_sources/local_data_source.dart';
import 'package:parallel_37/src/domain/entities/store.dart';
import 'package:parallel_37/src/domain/respositories/store_repository.dart';

import '../../../app/core/utilities/errors/exceptions.dart';

class StoreRepositoryImpl implements StoreRepository {
  final LocalDataSource localDataSource;
  StoreRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<Store>>> getMightLikeStores() async {
    try {
      final result = await localDataSource.getMightLikeStores();
      return Right(result.map((store) => store.toEntity()).toList());
    } on ServerException {
      return const Left(
        ServerFailure("message"),
      );
    } on SocketOption {
      return const Left(
        ConnectionFailure(
          "Failed to connect to the network",
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Store>>> popularStores() async {
    try {
      final result = await localDataSource.popularStores();
      return Right(result.map((store) => store.toEntity()).toList());
    } on ServerException {
      return const Left(
        ServerFailure("message"),
      );
    } on SocketOption {
      return const Left(
        ConnectionFailure(
          "Failed to connect to the network",
        ),
      );
    }
  }
}
