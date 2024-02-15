import 'package:bloc/bloc.dart';
import 'package:flash_briefs/app/ui/cubits/summarize_article/summarize_article_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class SummarizeArticleCubit extends Cubit<SummarizeArticleState> {
  SummarizeArticleCubit() : super(const SummarizeArticleState.initial());
  Future<void> summarizeArticle(String webContent) async {
    print('Summarizing');
    emit(const SummarizeArticleState.loadInProgress());
    try {
      const apiKey = String.fromEnvironment('geminiAPIKey');

      final model = GenerativeModel(
        model: 'gemini-pro',
        apiKey: apiKey,
        safetySettings: [
          SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.none)
        ],
      );

      final String prompt =
          'Given the following article content, please generate a concise bullet point summary highlighting the main points and key details. Ignore any non-relevant elements such as menus, promotions, and other unrelated information to the main article narrative: $webContent';

      final content = [Content.text(prompt)];

      final response = await model.generateContent(content);

      emit(SummarizeArticleState.loadSuccess([response.text ?? '']));
    } catch (error) {
      print(error);
      emit(const SummarizeArticleState.loadFailure());
    }
  }
}
