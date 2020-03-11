import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_flutter_app/utils/helper.dart';

abstract class BaseModel extends ChangeNotifier {
  bool _isBusy = false;
  bool _isLoadingMore = false;
  bool _hasWidgetSpecificError = false;
  String _serverError;
  String _authorizationError;
  String _connectionError;
  String _otherError;

  bool get isBusy => _isBusy;
  bool get hasWidgetSpecificError => _hasWidgetSpecificError;
  String get serverError => _serverError;
  String get authorizationError => _authorizationError;
  String get connectionError => _connectionError;
  String get otherError => _otherError;
  bool get isLoadingMore => _isLoadingMore;

  set setIsLoadingMore(bool value) {
    _isLoadingMore = value;
  }

  fetchInitialData() {

  }

  void setBusy(bool state){
    _isBusy = state;
    notifyListeners();
  }

  void setHasWidgetSpecificError() {
    _hasWidgetSpecificError = true;
    notifyListeners();
  }

  void normalizeErrorState() {
    _hasWidgetSpecificError = false;
    _serverError = null;
    _authorizationError = null;
    _connectionError = null;
  }

  void setGenericErrorMessage(Response response, BuildContext context, {Function retry}){
    // Take note that 600 is a status code I created myself to notify the viewmodels that the error is from dio
    if(response.statusCode == 600) {
      Helper.showNotificationDialog(context, retry);
    } else {
      // Do something else
    }
  }
}
