import 'package:flutter/material.dart';
import 'package:news_flutter_app/core/models/country_specific_news.dart';

class NewsRepository extends ChangeNotifier {
  CountrySpecificNews _countrySpecificNews;

  CountrySpecificNews get countrySpecificNews => _countrySpecificNews;

  set countrySpecificNews(CountrySpecificNews value) {
    _countrySpecificNews = value;
    notifyListeners();
  }


}
