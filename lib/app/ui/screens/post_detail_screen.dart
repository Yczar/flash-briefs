import 'package:cached_network_image/cached_network_image.dart';
import 'package:flash_briefs/app/data/models/news_article.dart';
import 'package:flash_briefs/app/ui/screens/news_summary_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class PostDetailScreen extends StatelessWidget {
  final NewsArticle article;

  const PostDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          article.title ?? 'Post Detail',
          style: GoogleFonts.openSans(),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NewsSummaryScreen(
              article: article,
            ),
          ));
        },
        tooltip: 'Summarize',
        label: const Text(
          'Summarize',
        ),
        icon: const Icon(
          Icons.summarize,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (article.urlToImage != null)
                    CachedNetworkImage(
                      imageUrl: article.urlToImage!,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          article.title ?? '',
                          style: GoogleFonts.openSans(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'By ${article.author ?? "Unknown"}',
                          style: GoogleFonts.openSans(
                              fontSize: 16, color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          DateFormat('MMM d, yyyy').format(DateTime.parse(
                              article.publishedAt ??
                                  DateTime.now().toIso8601String())),
                          style: GoogleFonts.openSans(
                              fontSize: 14, color: Colors.grey),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          article.content ?? 'No content available.',
                          style: GoogleFonts.openSans(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => _launchURL(article.url ?? ''),
            child: const Text('Continue Reading'),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final chromeSafariBrowser = ChromeSafariBrowser();
    chromeSafariBrowser.open(url: Uri.parse(url));
  }
}
