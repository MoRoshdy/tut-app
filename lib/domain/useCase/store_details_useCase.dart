// ignore_for_file: file_names

import 'package:dartz/dartz.dart';
import 'package:tut_app_with_clean_architecture/data/network/failure.dart';
import 'package:tut_app_with_clean_architecture/domain/model/models.dart';
import 'package:tut_app_with_clean_architecture/domain/repository/repository.dart';
import 'package:tut_app_with_clean_architecture/domain/useCase/base_useCase.dart';

class StoreDetailsUseCase extends BaseUseCase<void, StoreDetails> {
  Repository repository;

  StoreDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, StoreDetails>> execute(void input) {
    return repository.getStoreDetails();
  }
}
