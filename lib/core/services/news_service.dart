import 'package:dio/dio.dart';
import 'package:news_flutter_app/core/datastore/news_repository.dart';
import 'package:news_flutter_app/core/models/country_specific_news.dart';
import 'package:news_flutter_app/core/services/api.dart';

class NewsService{
  Dio apiClient = ApiClient.getClient();

  Future<Response> fetchCountrySpecificNews(NewsRepository newsRepository) async {
    Map<String, dynamic> queries = {
      'country': 'us'
    };
    Response response = await apiClient.get('/top-headlines', queryParameters: queries);

    if(response.statusCode == 200){
      newsRepository.countrySpecificNews = CountrySpecificNews.fromJson(response.data);
    }

    return response;
  }
}
