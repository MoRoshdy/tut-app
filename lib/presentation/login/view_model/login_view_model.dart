// ignore_for_file: avoid_print

import 'dart:async';

import 'package:tut_app_with_clean_architecture/domain/useCase/login_useCase.dart';
import 'package:tut_app_with_clean_architecture/presentation/base/base_view_model.dart';
import 'package:tut_app_with_clean_architecture/presentation/common/freezed_data_classes.dart';
import 'package:tut_app_with_clean_architecture/presentation/common/state_renderer/state_renderer.dart';
import 'package:tut_app_with_clean_architecture/presentation/common/state_renderer/state_renderer_impl.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  var loginObject = LoginObject("", "");

  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _areAllInputsValidStreamController =
      StreamController<void>.broadcast();
   StreamController isUserLoggedInSuccessfullyStreamController =
      StreamController<bool>();

  //inputs

  @override
  void dispose() {
    super.dispose();
    _userNameStreamController.close();
    _passwordStreamController.close();
    _areAllInputsValidStreamController.close();
    isUserLoggedInSuccessfullyStreamController.close();
  }

  @override
  void start() {
    // view model should tell view please show content state
    inputState.add(ContentState());
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputAreAllInputsValid => _areAllInputsValidStreamController.sink;

  @override
  login() async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.popupLoadingState));

    (await _loginUseCase.execute(
      LoginUseCaseInput(loginObject.userName, loginObject.password),
    ))
        .fold(
      (failure)
      {
        inputState.add(ErrorState(StateRendererType.popupErrorState, failure.message));
      },
      (data)
      {
        // content
        inputState.add(ContentState());
        // Navigate to main screen
        isUserLoggedInSuccessfullyStreamController.add(true);
      },
    );
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    inputAreAllInputsValid.add(null);
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(userName: userName);
    inputAreAllInputsValid.add(null);
  }

  //outputs

  @override
  Stream<bool> get outIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  Stream<bool> get outAreAllInputsValid =>
      _areAllInputsValidStreamController.stream
          .map((_) => _areAllInputsValid());

  // Stream<String> get outIsUserNameValid2 => _userNameStreamController.stream
  //     .map((userName) => _isUserNameValid2(userName));
  //
  // String _isUserNameValid2(String userName) {
  //   if (userName.isNotEmpty) {
  //     if (userName.length >= 6) {
  //       return "";
  //     } else {
  //       return "UserName must be 6 characters or more";
  //     }
  //   } else {
  //     return "Enter a password";
  //   }
  // }

  bool _areAllInputsValid() {
    return _isPasswordValid(loginObject.password) &&
        _isUserNameValid(loginObject.userName);
  }

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUserNameValid(String userName) {
    return userName.isNotEmpty;
  }
}

abstract class LoginViewModelInputs {
  setUserName(String userName);

  setPassword(String password);

  login();

  Sink get inputUserName;

  Sink get inputPassword;

  Sink get inputAreAllInputsValid;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outIsUserNameValid;

  Stream<bool> get outIsPasswordValid;

  Stream<bool> get outAreAllInputsValid;
}
