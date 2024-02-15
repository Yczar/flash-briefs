import 'package:flash_briefs/app/data/models/news_article.dart';
import 'package:flash_briefs/app/data/service/news_api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flash_briefs/app/ui/cubits/top_headlines/top_headlines_state.dart';

class TopHeadlinesCubit extends Cubit<TopHeadlinesState> {
  TopHeadlinesCubit() : super(const TopHeadlinesState.initial());
  Future<void> fetchTopHeadlines() async {
    emit(const TopHeadlinesState.loadInProgress());
    try {
      final newsAPIService = NewsAPIService();
      final List<NewsArticle> posts = await newsAPIService.fetchTopHeadlines();
      emit(TopHeadlinesState.loadSuccess(posts));
    } catch (error) {
      emit(const TopHeadlinesState.loadFailure());
    }
  }
}
