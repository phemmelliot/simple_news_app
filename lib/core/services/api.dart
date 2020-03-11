import 'package:dio/dio.dart';
import 'package:news_flutter_app/utils/helper.dart';

class ApiClient {
  static Dio getClient({String baseUrl = 'http://newsapi.org/v2/', bool hasTimeout = true,}) {
    Dio dio = Dio();
    Map<String, dynamic> queryParameters = {
      'apiKey': '32b57538efdf42cd8a4a2262ff12a58c',
    };

    dio.options.baseUrl = baseUrl;
    dio.options.queryParameters = queryParameters;

    if(hasTimeout){
      dio.options.connectTimeout = 10000;
      dio.options.receiveTimeout = 10000;
    }

    dio.options.contentType = 'application/json';

    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options) {
          print("This is the request ${options.uri.toString()}");
          return options;
        },
        onResponse: (Response response) {
          print("This is the response ${response.statusCode}");
          return response;
        },
        onError: (DioError error) {
          Response errorResponse;
          if(error.type == DioErrorType.RESPONSE){
            print(error.response.data);
            errorResponse = error.response;
          } else {
            String errorMessage = Helper.handleError(error);

            // Take note that 600 is not a real status code, it was used to indicate client dio error like network connection failure
            Response newRes = Response(statusCode: 600, data: { 'message': errorMessage});
            errorResponse = newRes;
          }

          return errorResponse;
        }
    ));

    return dio;
  }

}
