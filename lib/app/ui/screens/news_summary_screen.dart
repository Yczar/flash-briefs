import 'package:flash_briefs/app/data/models/news_article.dart';
import 'package:flash_briefs/app/ui/cubits/summarize_article/summarize_article_cubit.dart';
import 'package:flash_briefs/app/ui/cubits/summarize_article/summarize_article_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;

class NewsSummaryScreen extends StatefulWidget {
  final NewsArticle article;

  const NewsSummaryScreen({
    super.key,
    required this.article,
  });

  @override
  State<NewsSummaryScreen> createState() => _NewsSummaryScreenState();
}

class _NewsSummaryScreenState extends State<NewsSummaryScreen> {
  late SummarizeArticleCubit _summarizeArticleCubit;
  @override
  void initState() {
    super.initState();
    _summarizeArticleCubit = SummarizeArticleCubit();
    _summarizeArticle();
  }

  @override
  Widget build(BuildContext context) {
    print(_summarizeArticleCubit.state);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Summary',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.article.title ?? 'No Title',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocProvider.value(
                value: _summarizeArticleCubit,
                child:
                    BlocBuilder<SummarizeArticleCubit, SummarizeArticleState>(
                  builder: (context, state) {
                    return state.when(
                      initial: () => const SizedBox.shrink(),
                      loadInProgress: () => const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      loadSuccess: (summaries) => ListView.builder(
                        itemCount: summaries.length,
                        itemBuilder: (_, index) => RichText(
                          text: TextSpan(
                            style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.black), // Default text style
                            children: parseMarkdown(
                              summaries[index],
                            ),
                          ),
                        ),
                        //  Text(
                        //   summaries[index],
                        //   style: GoogleFonts.openSans(
                        //     fontSize: 16,
                        //     color: Colors.black,
                        //   ),
                        // ),
                      ),
                      loadFailure: () => const Center(
                        child: Text('Failed to fetch summary'),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _summarizeArticle() async {
    final webContent =
        await _extractAllParagraphsFromUrl(widget.article.url ?? '');

    _summarizeArticleCubit.summarizeArticle(webContent);
  }

  Future<String> _extractAllParagraphsFromUrl(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Parse the HTML document
      dom.Document document = parser.parse(response.body);

      // Extract all paragraph elements
      List<dom.Element> paragraphElements = document.querySelectorAll('p');
      String allParagraphsText =
          paragraphElements.map((e) => e.text.trim()).join('\n\n');

      return allParagraphsText;
    } else {
      throw Exception('Failed to load webpage');
    }
  }

  @override
  void dispose() {
    _summarizeArticleCubit.close();
    super.dispose();
  }

  List<TextSpan> parseMarkdown(String text) {
    List<TextSpan> spans = [];
    RegExp exp = RegExp(r'\*\*(.*?)\*\*');
    String tempText = text;

    while (exp.hasMatch(tempText)) {
      final match = exp.firstMatch(tempText);
      if (match != null) {
        final beforeText = tempText.substring(0, match.start);
        final boldText = match.group(1);

        if (beforeText.isNotEmpty) {
          spans.add(TextSpan(text: beforeText));
          spans.add(const TextSpan(text: '\n\n'));
        }
        if (boldText != null) {
          spans.add(
            TextSpan(
              text: boldText,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }

        tempText = tempText.substring(match.end);
      }
    }

    if (tempText.isNotEmpty) {
      spans.add(TextSpan(text: tempText));
    }

    return spans;
  }
}
