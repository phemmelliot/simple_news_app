import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_flutter_app/core/datastore/news_repository.dart';
import 'package:news_flutter_app/core/models/country_specific_news.dart';
import 'package:news_flutter_app/utils/helper.dart';
import 'package:provider/provider.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  Widget _buildArticleWidget(Articles article) {
    final formatter = DateFormat("yyyy-MM-dd");

    return InkWell(
      onTap: (){
        NewPageArgs newPageArgs = NewPageArgs(url: article.url, title: article.title);
        Navigator.pushNamed(context, '/news_webview', arguments: newPageArgs);
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(article.urlToImage),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken)
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  article.source.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                color: Colors.red,
                padding: EdgeInsets.all(5),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                article.title,
                style: TextStyle(color: Colors.white, fontSize: 16),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                article.author ?? '',
                style: TextStyle(color: Colors.white, fontSize: 16,),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                formatter.format(DateTime.parse(article.publishedAt)),
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    NewsRepository newsRepository = Provider.of(context);
    List<Articles> articles = newsRepository.countrySpecificNews.articles;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Helper.getResponsiveWidth(5, context)),
          child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    'US News',
                    style:
                        TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                );
              }
              Articles article = articles[index - 1];
              return _buildArticleWidget(article);
            },
            itemCount: newsRepository.countrySpecificNews.articles.length + 1,
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                height: 20,
              );
            },
          ),
        ),
      ),
    );
  }
}
