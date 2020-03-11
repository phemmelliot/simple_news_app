import 'package:flutter/material.dart';
import 'package:news_flutter_app/base/base_widget.dart';
import 'package:news_flutter_app/core/viewmodels/splash_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<SplashScreenViewModel>(
      model: SplashScreenViewModel(context),
      initData: true,
      builder: (context, model, child){
        return Scaffold(
            backgroundColor: Color(0xFFC70000),
            body: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/news_icon.png', height: 100, width: 100,),
                  SizedBox(height: 20,),
                  Text('News App', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                  SizedBox(height: 20,),
                  model.isBusy ? CircularProgressIndicator() : Container()
                ],
              ),
            )
        );
      },
    );
  }
}
