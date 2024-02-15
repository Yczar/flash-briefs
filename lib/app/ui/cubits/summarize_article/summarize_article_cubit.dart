import 'package:flash_briefs/app/ui/cubits/summarize_article/summarize_article_state.dart';
import 'package:flash_briefs/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

/// A Cubit for managing the state of article summarization.
///
/// This Cubit handles the process of summarizing web article content
/// by interacting with a generative model API. It updates its state
/// based on the progress and result of the summarization process.
class SummarizeArticleCubit extends Cubit<SummarizeArticleState> {
  /// Initializes the Cubit with an initial state of [SummarizeArticleState.initial].
  SummarizeArticleCubit() : super(const SummarizeArticleState.initial());

  /// Summarizes the given web article content.
  ///
  /// This method takes the raw content of a web article as input and
  /// uses a generative model to produce a concise summary. The state
  /// of the Cubit is updated to reflect the progress and outcome of
  /// the summarization process.
  ///
  /// The method emits:
  /// - [SummarizeArticleState.loadInProgress] when the summarization process
  /// starts.
  /// - [SummarizeArticleState.loadSuccess] with the summary upon successful
  /// completion.
  /// - [SummarizeArticleState.loadFailure] if an error occurs during the
  /// process.
  ///
  /// Parameters:
  /// - [articleURL]: A [String] containing the url for the content of a
  /// web article.
  Future<void> summarizeArticle(String articleURL) async {
    emit(const SummarizeArticleState.loadInProgress());
    try {
      // Retrieves web content directly from the html page
      final webContent = await Utils.extractAllParagraphsFromUrl(articleURL);
      // Retrieves the API key for the generative model from environment variables.
      const apiKey = String.fromEnvironment('geminiAPIKey');

      // Initializes the generative model with specific settings, including
      // the model type and safety settings to filter out unwanted content.
      final model = GenerativeModel(
        model: 'gemini-pro',
        apiKey: apiKey,
        safetySettings: [
          SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.none)
        ],
      );

      // Constructs the prompt for the generative model to ensure the summary
      // focuses on the main points and key details of the article, excluding
      // irrelevant information.
      final String prompt =
          'Given the following article content, please generate a concise bullet'
          ' point summary highlighting the main points and key details. '
          'Ignore any non-relevant elements such as menus, promotions, and '
          'other unrelated information to the main article narrative: $webContent';

      // Prepares the content for the generative model based on the constructed prompt.
      final content = [Content.text(prompt)];

      // Calls the generative model to generate the summary based on the
      // provided content.
      final response = await model.generateContent(content);

      // Emits a success state with the generated summary.
      emit(
        SummarizeArticleState.loadSuccess(
          [response.text ?? ''],
        ),
      );
    } catch (error) {
      // Emits a failure state if an error occurs during the summarization
      // process.
      emit(const SummarizeArticleState.loadFailure());
    }
  }
}
