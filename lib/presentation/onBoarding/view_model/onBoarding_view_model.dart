

// ignore_for_file: file_names

import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:tut_app_with_clean_architecture/domain/model/models.dart';
import 'package:tut_app_with_clean_architecture/presentation/base/base_view_model.dart';
import 'package:tut_app_with_clean_architecture/presentation/resources/assets_manager.dart';
import 'package:tut_app_with_clean_architecture/presentation/resources/strings_manager.dart';

class OnBoardingViewModel extends BaseViewModel with OnBoardingViewModelInputs,OnBoardingViewModelOutputs{
  final StreamController _streamController = StreamController<SliderViewObject>();
  late final List<SliderObject> _list = _getSliderData();
   int _currentIndex = 0;

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {

    _postDataToView();
  }

  @override
  int goNext() {
    int nextIndex = ++_currentIndex;
    if (nextIndex == _list.length) {
      nextIndex = 0;
    }
    return nextIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = --_currentIndex;
    if (previousIndex == -1) {
      previousIndex = _list.length - 1;
    }
    return previousIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  Stream<SliderViewObject> get outputSliderViewObject => _streamController.stream.map((sliderViewObject) => sliderViewObject);

  List<SliderObject> _getSliderData() => [
    SliderObject(AppStrings.onBoardingTitle1.tr(),
        AppStrings.onBoardingSubTitle1.tr(), ImageAssets.onBoardingLogo1),
    SliderObject(AppStrings.onBoardingTitle2.tr(),
        AppStrings.onBoardingSubTitle2.tr(), ImageAssets.onBoardingLogo2),
    SliderObject(AppStrings.onBoardingTitle3.tr(),
        AppStrings.onBoardingSubTitle3.tr(), ImageAssets.onBoardingLogo3),
    SliderObject(AppStrings.onBoardingTitle4.tr(),
        AppStrings.onBoardingSubTitle4.tr(), ImageAssets.onBoardingLogo4),
  ];

  void _postDataToView(){
    inputSliderViewObject.add(SliderViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }
}

abstract class OnBoardingViewModelInputs{
  int goNext();
  int goPrevious();
  void onPageChanged(int index);

  Sink get inputSliderViewObject;
}

abstract class OnBoardingViewModelOutputs{
  Stream<SliderViewObject> get outputSliderViewObject;
}