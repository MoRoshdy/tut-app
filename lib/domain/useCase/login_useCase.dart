// ignore_for_file: file_names

import 'package:dartz/dartz.dart';
import 'package:tut_app_with_clean_architecture/data/network/failure.dart';
import 'package:tut_app_with_clean_architecture/data/network/requests.dart';
import 'package:tut_app_with_clean_architecture/domain/model/models.dart';
import 'package:tut_app_with_clean_architecture/domain/repository/repository.dart';
import 'package:tut_app_with_clean_architecture/domain/useCase/base_useCase.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication>{
  final Repository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(LoginUseCaseInput input) async{
    return await _repository.login(LoginRequest(input.username, input.password));
  }

}

class LoginUseCaseInput{
  String username;
  String password;

  LoginUseCaseInput(this.username, this.password);
}