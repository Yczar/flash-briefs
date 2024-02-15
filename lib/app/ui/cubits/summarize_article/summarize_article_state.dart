import 'package:freezed_annotation/freezed_annotation.dart';

part 'summarize_article_state.freezed.dart';

@freezed
class SummarizeArticleState with _$SummarizeArticleState {
  const factory SummarizeArticleState.initial() = _Initial;
  const factory SummarizeArticleState.loadInProgress() = _LoadInProgress;
  const factory SummarizeArticleState.loadSuccess(List<String> summary) =
      _LoadSuccess;
  const factory SummarizeArticleState.loadFailure() = _LoadFailure;
}
