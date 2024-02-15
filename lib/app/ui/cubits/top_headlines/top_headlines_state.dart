import 'package:flash_briefs/app/data/models/news_article.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'top_headlines_state.freezed.dart';

@freezed
class TopHeadlinesState with _$TopHeadlinesState {
  const factory TopHeadlinesState.initial() = _Initial;
  const factory TopHeadlinesState.loadInProgress() = _LoadInProgress;
  const factory TopHeadlinesState.loadSuccess(List<NewsArticle> posts) =
      _LoadSuccess;
  const factory TopHeadlinesState.loadFailure() = _LoadFailure;
}
