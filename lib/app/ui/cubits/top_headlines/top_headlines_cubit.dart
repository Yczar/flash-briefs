import 'package:flash_briefs/app/data/models/news_article.dart';
import 'package:flash_briefs/app/data/services/news_api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flash_briefs/app/ui/cubits/top_headlines/top_headlines_state.dart';

/// A Cubit for managing the state of fetching top headlines.
///
/// This Cubit handles the process of fetching top headlines from a news API
/// and updates its state based on the progress and result of the fetch operation.
class TopHeadlinesCubit extends Cubit<TopHeadlinesState> {
  /// Initializes the Cubit with an initial state of [TopHeadlinesState.initial].
  TopHeadlinesCubit() : super(const TopHeadlinesState.initial());

  /// Fetches the top headlines and updates the Cubit's state accordingly.
  ///
  /// This method performs an asynchronous operation to fetch top headlines
  /// from a news API. Upon calling, it first emits a [TopHeadlinesState.loadInProgress]
  /// state to indicate that the fetch operation has started.
  ///
  /// Upon successful completion of the fetch operation, it emits a
  /// [TopHeadlinesState.loadSuccess] state with the fetched top headlines.
  ///
  /// If an error occurs during the fetch operation, it emits a
  /// [TopHeadlinesState.loadFailure] state to indicate the failure.
  ///
  /// This method utilizes the [NewsAPIService] to perform the actual
  /// fetch operation.
  Future<void> fetchTopHeadlines() async {
    emit(const TopHeadlinesState.loadInProgress());
    try {
      // Creates an instance of NewsAPIService to use for fetching top headlines.
      final newsAPIService = NewsAPIService();
      // Awaits the fetch operation and stores the result in `posts`.
      final List<NewsArticle> posts = await newsAPIService.fetchTopHeadlines();
      // Emits a success state with the fetched top headlines.
      emit(TopHeadlinesState.loadSuccess(posts));
    } catch (error) {
      // Emits a failure state if an error occurs during the fetch operation.
      emit(const TopHeadlinesState.loadFailure());
    }
  }
}
