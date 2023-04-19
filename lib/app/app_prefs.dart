// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tut_app_with_clean_architecture/presentation/resources/language_manager.dart';

const String PREFS_KEY_LANG = "PREFS_KEY_LANG";
const String PREFS_KEY_ONBOARDING_SCREEN_VIEWED = "PREFS_KEY_ONBOARDING_SCREEN_VIEWED";
const String PREFS_KEY_IS_USER_LOGGED_IN = "PREFS_KEY_IS_USER_LOGGED_IN";

class AppPreferences{
 final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(PREFS_KEY_LANG);
    if(language!=null && language.isNotEmpty)
      {
        return language;
      }
    else
      {
        return LanguageType.ENGLISH.getValue();
      }
  }

  Future<void> changeAppLanguage() async {
    String currentLanguage = await getAppLanguage();
    if(currentLanguage == LanguageType.ENGLISH.getValue()){
      _sharedPreferences.setString(PREFS_KEY_LANG, LanguageType.ARABIC.getValue());
    }else{
      _sharedPreferences.setString(PREFS_KEY_LANG, LanguageType.ENGLISH.getValue());
    }
  }

 Future<Locale> getLocale() async {
   String currentLanguage = await getAppLanguage();
   if(currentLanguage == LanguageType.ENGLISH.getValue()){
     return ENGLISH_LOCALE;
   }else{
     return ARABIC_LOCALE;
   }
 }

  // onBoarding

  Future<void> setOnBoardingScreenViewed() async{
    _sharedPreferences.setBool(PREFS_KEY_ONBOARDING_SCREEN_VIEWED, true);
  }

 Future<bool> isOnBoardingScreenViewed() async{
  return _sharedPreferences.getBool(PREFS_KEY_ONBOARDING_SCREEN_VIEWED) ?? false;
 }

 // login

 Future<void> setUserLoggedIn() async{
   _sharedPreferences.setBool(PREFS_KEY_IS_USER_LOGGED_IN, true);
 }

 Future<bool> isUserLoggedIn() async{
   return _sharedPreferences.getBool(PREFS_KEY_IS_USER_LOGGED_IN) ?? false;
 }

 Future<void> logout() async {
   _sharedPreferences.remove(PREFS_KEY_IS_USER_LOGGED_IN);
 }
}