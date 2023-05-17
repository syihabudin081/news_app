// ignore_for_file: unnecessary_null_comparison, file_names, constant_identifier_names, library_private_types_in_public_api, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:news_app/models/news_model.dart';
import 'package:google_fonts/google_fonts.dart';

enum Timezone { WIB, WITA, WIT }

class ArticleDetailScreen extends StatefulWidget {
  final Article article;

  const ArticleDetailScreen({Key? key, required this.article}) : super(key: key);

  @override
  _ArticleDetailScreenState createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  Timezone selectedTimezone = Timezone.WIB; // Default timezone

  String formatPublishedTime(String time, Timezone timezone) {
    final parsedTime = DateTime.parse(time).toLocal();

    String formattedTime;

    switch (timezone) {
      case Timezone.WIB:
        formattedTime = DateFormat('MMMM dd, yyyy HH:mm').format(parsedTime);
        break;
      case Timezone.WITA:
        formattedTime =
            DateFormat('MMMM dd, yyyy HH:mm').format(parsedTime.add(const Duration(hours: 1)));
        break;
      case Timezone.WIT:
        formattedTime =
            DateFormat('MMMM dd, yyyy HH:mm').format(parsedTime.add(const Duration(hours: 2)));
        break;
    }

    return formattedTime;
  }

Future <void> launchURL(String url) async{
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Article Detail'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.article.urlToImage != null && widget.article.urlToImage!.isNotEmpty)
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: widget.article.urlToImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  alignment: Alignment.center,
                ),
              ),
            const SizedBox(height: 16.0),
            Text(
              widget.article.title,
              style: GoogleFonts.montserrat(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
              return Row(
                children: [
                  DropdownButton<Timezone>(
                    value: selectedTimezone,
                    onChanged: (Timezone? newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedTimezone = newValue;
                        });
                      }
                    },
                    items: Timezone.values.map((Timezone timezone) {
                      return DropdownMenuItem<Timezone>(
                        value: timezone,
                        child: Text(timezone.toString()),
                      );
                    }).toList(),
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    formatPublishedTime(widget.article.publishedAt!, selectedTimezone),
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              );
            }),
            const SizedBox(height: 8.0),
            Text(
              widget.article.author!,
              style: GoogleFonts.montserrat(
                fontSize: 16.0,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(height: 15.0),
            Text(
              widget.article.description ?? 'No description',
              style: GoogleFonts.montserrat(fontSize: 18.0),
            ),
            const SizedBox(height: 15.0),
            ElevatedButton(
              onPressed: () => launchURL(widget.article.url!),
              child: const Text('Read More'),
            ),
          ],
        ),
      ),
    );
  }
}
