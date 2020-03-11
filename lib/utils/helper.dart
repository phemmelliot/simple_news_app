import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Helper {
  static double getResponsiveHeight(double percent, BuildContext context) {
    return percent / 100 * MediaQuery.of(context).size.height;
  }

  static double getResponsiveWidth(double percent, BuildContext context) {
    return percent / 100 * MediaQuery.of(context).size.width;
  }

  static void displayError(String message, BuildContext context, {int duration = 5}) {
    Flushbar flushBar;
    flushBar = Flushbar(
      message: message,
      backgroundColor: Color(0xffcf6679),
      mainButton: FlatButton(
        onPressed: () {
          flushBar.dismiss([]);
        },
        child: Icon(
          Icons.cancel,
          color: Colors.white,
          size: 20,
        ),
      ),
      flushbarStyle: FlushbarStyle.GROUNDED,
      duration: Duration(seconds: duration),
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    )..show(context);
  }

  static void displaySuccess(String message, BuildContext context, {int duration = 5}) {
    Flushbar flushBar;

    flushBar = Flushbar(
      message: message,
      backgroundColor: Colors.greenAccent[400],
      mainButton: FlatButton(
        onPressed: () {
          flushBar.dismiss([]);
        },
        child: Icon(
          Icons.cancel,
          color: Colors.white,
          size: 20,
        ),
      ),
      flushbarStyle: FlushbarStyle.GROUNDED,
      duration: Duration(seconds: duration),
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    )..show(context);
  }

  static showPlatformProgressIndicator(BuildContext context) {
    Widget indicator;

    if (Platform.isIOS) {
      indicator = CupertinoActivityIndicator();
    } else if (Platform.isAndroid) {
      indicator = CircularProgressIndicator();
    }

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          child: Container(
            color: Colors.transparent,
            height: 100,
            width: 100,
            child: Center(
              child: indicator,
            ),
          ),
        );
      },
    );
  }

  static Future<void> showNotificationDialog(BuildContext context, Function retry) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 10.0,
          backgroundColor: Colors.white,
          child: Container(
            height: 200,
            width: Helper.getResponsiveWidth(90, context),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Internet Connection Error',
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'There was an issue with your network connection, please fix and try again',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RaisedButton(
                    onPressed: () {
                      Helper.dismissDialog(context);
                      retry();
                    },
                    child: Container(
                      child: Text('RETRY'),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<bool> showPlatformAlertDialog(BuildContext context, String title, String content,
      String yesActionLabel, String noActionLabel) {
    if (Platform.isIOS) {
      return showCupertinoDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: new Text(title),
            content: new Text(content),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text(yesActionLabel),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
              CupertinoDialogAction(
                child: Text(noActionLabel),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              )
            ],
          );
        },
      );
    } else {
      return showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(title),
            content: new Text(content),
            actions: <Widget>[
              FlatButton(
                child: Text(yesActionLabel),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
              FlatButton(
                child: Text(noActionLabel),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              )
            ],
          );
        },
      );
    }
  }

  static Future<void> showActionDialog(BuildContext context, Function buildModalContent) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 10.0,
          backgroundColor: Colors.black.withOpacity(0.2),
          child: buildModalContent(context),
        );
      },
    );
  }

  static dismissDialog(BuildContext context) {
    Navigator.pop(context);
  }

  static String handleError(DioError error) {
    String errorDescription = "";
    switch (error.type) {
      case DioErrorType.CANCEL:
        errorDescription = "Request to server was cancelled, please try again";
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        errorDescription = "Connection timeout with server, please try again";
        break;
      case DioErrorType.SEND_TIMEOUT:
        errorDescription = "Connection timeout with server, please try again";
        break;
      case DioErrorType.DEFAULT:
        errorDescription =
            "Connection to API server failed due to internet connection Check your internet connection and try again";
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        errorDescription = "Receive timeout in connection with API server";
        break;
      default:
        errorDescription = "Unexpected error encountered, please try again";
    }
    return errorDescription;
  }
}

class NewPageArgs {
  String url;
  String title;
  NewPageArgs({this.url, this.title});
}
