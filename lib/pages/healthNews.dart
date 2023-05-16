import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/pages/articleDetailScreen.dart';
import 'package:news_app/services/api_service.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';

class HealthNewsScreen extends StatefulWidget {
  @override
  _HealthNewsScreenState createState() => _HealthNewsScreenState();
}

class _HealthNewsScreenState extends State<HealthNewsScreen> {
  final NewsApiService _apiService = NewsApiService();
  List<Article> _articles = [];

  @override
  void initState() {
    super.initState();
    fetchNewsData();
  }

  Future<void> fetchNewsData() async {
    try {
      final articles = await _apiService.fetchArticles("health");
      print('Fetched ${articles.length} articles');
      setState(() {
        _articles = articles;
      });
    } catch (e) {
      print('Error fetching news: $e');
      // Handle error
    }
  }

  String formatPublishedTime(String time) {
    final parsedTime = DateTime.parse(time);
    final formattedTime = DateFormat('MMMM dd, yyyy HH:mm').format(parsedTime);
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health News'),
      ),
      
      body: _articles.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.symmetric(vertical: 0.0),
              child: Column(
                children: [
                  CarouselSlider(
                    items: _articles
                        .take(3)
                        .map((article) => buildCarouselItem(context, article))
                        .toList(),
                    options: CarouselOptions(
                      height: 200,
                      viewportFraction: 1.0,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      initialPage: 0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Today Hot News!',
                            style: GoogleFonts.montserrat(
                              fontSize: 15.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _articles.length - 3,
                      itemBuilder: (context, index) {
                        final article = _articles[index + 3];
                        return ListTile(
                          title: Text(
                            article.title,
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 8.0),
                              Text(
                                article.author ?? 'No Author',
                                style: GoogleFonts.montserrat(
                                  fontSize: 12.0,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                formatPublishedTime(article.publishedAt),
                                style: GoogleFonts.montserrat(
                                  fontSize: 12.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          leading: article.urlToImage != null &&
                                  article.urlToImage.isNotEmpty
                              ? CachedNetworkImage(
                                  imageUrl: article.urlToImage,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                  fit: BoxFit.cover,
                                  width: 80.0,
                                  height: 80.0,
                                )
                              : Container(
                                  width: 80.0,
                                  height: 80.0,
                                  color: Colors.grey[300],
                                ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ArticleDetailScreen(
                                  article: article,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget buildCarouselItem(BuildContext context, Article article) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleDetailScreen(
              article: article,
            ),
          ),
        );
      },
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Stack(
          children: [
            article.urlToImage != null &&
                                  article.urlToImage.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: article.urlToImage,
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    alignment: Alignment.center,
                  )
                : Container(color: Colors.grey[300]),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black87],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Text(
                  article.title ?? '',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
