import 'package:flash_briefs/app/data/models/news_article.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class PostDetailScreen extends StatelessWidget {
  final NewsArticle article;

  const PostDetailScreen({Key? key, required this.article}) : super(key: key);

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the summary screen
          // Navigator.of(context).push(MaterialPageRoute(
          //   builder: (context) => NewsSummaryScreen(post: post),
          // ));
        },
        child: const Icon(
          Icons.summarize,
        ),
        tooltip: 'Summarize',
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (article.urlToImage != null)
                    Image.network(
                      article.urlToImage!,
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
            height: 20,
          ),
        ],
      ),
    );
  }
}

Future<void> _launchURL(String url) async {
  final chromeSafariBrowser = ChromeSafariBrowser();
  chromeSafariBrowser.open(url: Uri.parse(url));
//   if (await canLaunchUrl(Uri.parse(url))) {
//     await launchUrl(Uri.parse(url));
//   } else {
//     throw 'Could not launch $url';
//   }
}
