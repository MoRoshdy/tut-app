import 'dart:async';

import 'package:tut_app_with_clean_architecture/app/functions.dart';
import 'package:tut_app_with_clean_architecture/domain/useCase/forgot_password_useCase.dart';
import 'package:tut_app_with_clean_architecture/presentation/base/base_view_model.dart';
import 'package:tut_app_with_clean_architecture/presentation/common/state_renderer/state_renderer.dart';
import 'package:tut_app_with_clean_architecture/presentation/common/state_renderer/state_renderer_impl.dart';

class ForgotPasswordViewModel extends BaseViewModel
    with ForgotPasswordViewModelInputs, ForgotPasswordViewModelOutputs {
  final ForgotPasswordUseCase _forgotPasswordUseCase;

  ForgotPasswordViewModel(this._forgotPasswordUseCase);

  var email = "";

  final StreamController _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController _areAllInputsValidStreamController =
      StreamController<void>.broadcast();

  @override
  void dispose() {
    super.dispose();
    _emailStreamController.close();
    _areAllInputsValidStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputAreAllInputsValid => _areAllInputsValidStreamController.sink;

  @override
  Stream<bool> get outIsEmailValid =>
      _emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<bool> get outAreAllInputsValid =>
      _areAllInputsValidStreamController.stream
          .map((_) => _areAllInputsValid());

  @override
  setEmail(String email) {
    inputEmail.add(email);
    this.email = email;
    inputAreAllInputsValid.add(null);
  }

  @override
  resetPassword() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));

    (await _forgotPasswordUseCase.execute(email)).fold(
      (failure) {
        inputState.add(
            ErrorState(StateRendererType.popupErrorState, failure.message));
      },
      (supportMessage) {
        inputState.add(SuccessState(supportMessage));
      },
    );
  }


  bool _areAllInputsValid() {
    return isEmailValid(email);
  }
}

abstract class ForgotPasswordViewModelInputs {
  setEmail(String email);
  resetPassword();

  Sink get inputEmail;
  Sink get inputAreAllInputsValid;
}

abstract class ForgotPasswordViewModelOutputs {
  Stream<bool> get outIsEmailValid;
  Stream<bool> get outAreAllInputsValid;
}
