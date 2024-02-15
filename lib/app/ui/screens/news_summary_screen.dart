import 'package:flash_briefs/app/data/models/news_article.dart';
import 'package:flash_briefs/app/ui/cubits/summarize_article/summarize_article_cubit.dart';
import 'package:flash_briefs/app/ui/cubits/summarize_article/summarize_article_state.dart';
import 'package:flash_briefs/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Summary',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RefreshIndicator(
          onRefresh: () => _summarizeArticleCubit.summarizeArticle(
            widget.article.url ?? '',
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.article.title ?? 'No Title',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                          child: IntrinsicHeight(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '...Generating summary',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        loadSuccess: (summaries) => ListView.builder(
                          itemCount: summaries.length,
                          itemBuilder: (_, index) => RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                              ), // Default text style
                              children: Utils.parseMarkdown(
                                summaries[index],
                              ),
                            ),
                          ),
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
      ),
    );
  }

  Future<void> _summarizeArticle() async {
    _summarizeArticleCubit.summarizeArticle(widget.article.url ?? '');
  }

  @override
  void dispose() {
    _summarizeArticleCubit.close();
    super.dispose();
  }
}
