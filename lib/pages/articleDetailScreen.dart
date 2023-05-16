import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:news_app/models/news_model.dart';
import 'package:google_fonts/google_fonts.dart';



class ArticleDetailScreen extends StatelessWidget {
  final Article article;

  const ArticleDetailScreen({Key? key, required this.article}) : super(key: key);

  
Future <void> launchURL(String url) async{
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
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
        title: Text('Article Detail'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.urlToImage != null && article.urlToImage!.isNotEmpty)
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: article.urlToImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  alignment: Alignment.center,
                 
                ),
              ),
            SizedBox(height: 16.0),
            Text(
              article.title,
              style: GoogleFonts.montserrat(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
                 formatPublishedTime(article.publishedAt),
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
             SizedBox(height: 8.0),
            Text(
                 article.author,
              style: GoogleFonts.montserrat(
                fontSize: 16.0,
                color: Colors.blueGrey,
                
                
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              article.description ?? 'No description',
              style: GoogleFonts.montserrat(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => launchURL(article.url),
              child: Text('Read More'),
            ),
          ],
        ),
      ),
    );
  }
}