import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_flutter_app/base/base_model.dart';
import 'package:news_flutter_app/core/datastore/news_repository.dart';
import 'package:news_flutter_app/core/services/news_service.dart';
import 'package:provider/provider.dart';

class SplashScreenViewModel extends BaseModel{
  final BuildContext context;
  final NewsService api = NewsService();
  SplashScreenViewModel(this.context);

  @override
  fetchInitialData() {
    fetchNews();
  }

  void fetchNews() async {
    NewsRepository newsRepository = Provider.of(context, listen: false);
    setBusy(true);

    Response response = await api.fetchCountrySpecificNews(newsRepository);
    setBusy(false);
    if(response.statusCode == 200){
      Navigator.pushNamed(context, '/news_screen');
    } else {
      setGenericErrorMessage(response, context, retry: () => fetchNews());
    }

  }
}
