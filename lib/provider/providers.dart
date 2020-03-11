import 'package:news_flutter_app/core/datastore/news_repository.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<NewsRepository>(
    create: (context) => NewsRepository(),
  ),
];
