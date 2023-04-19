// ignore_for_file: file_names

import 'package:dartz/dartz.dart';
import 'package:tut_app_with_clean_architecture/data/network/failure.dart';
import 'package:tut_app_with_clean_architecture/domain/repository/repository.dart';
import 'package:tut_app_with_clean_architecture/domain/useCase/base_useCase.dart';

class ForgotPasswordUseCase implements BaseUseCase<String, String>{
  final Repository _repository;

  ForgotPasswordUseCase(this._repository);

  @override
  Future<Either<Failure, String>> execute(String input) async {
    return await _repository.forgotPassword(input);
  }

}

