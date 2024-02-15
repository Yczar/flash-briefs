import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;

/// A utility class containing helper methods for various operations.
///
/// This class provides static methods for parsing markdown-like text into
/// [TextSpan] objects and extracting text content from web pages.
class Utils {
  /// Parses a markdown-like string into a list of [TextSpan] objects.
  ///
  /// This method searches for patterns resembling bold markdown syntax (e.g., `**bold text**`)
  /// and converts them into [TextSpan] objects with appropriate styling. Text not marked
  /// as bold is also converted into [TextSpan] objects but without bold styling.
  ///
  /// Parameters:
  /// - [text]: The markdown-like string to be parsed.
  ///
  /// Returns:
  /// A list of [TextSpan] objects representing the parsed text. Bold text is styled
  /// accordingly, and non-bold text is included as regular [TextSpan] objects. Each
  /// piece of text separated by markdown-like bold syntax is also separated by two
  /// newline characters in the output.
  ///
  /// Example:
  /// Given the input string `"This is **bold** text"`, this method will return a list
  /// containing [TextSpan] objects for "This is ", a bold [TextSpan] for "bold", and
  /// another [TextSpan] for " text".
  static List<TextSpan> parseMarkdown(String text) {
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

  /// Extracts and concatenates all paragraph text from the specified URL.
  ///
  /// This method performs an HTTP GET request to fetch the content of the webpage
  /// at the given URL. It then parses the HTML content to extract text from all
  /// `<p>` elements, concatenating them with two newline characters between each paragraph.
  ///
  /// Parameters:
  /// - [url]: The URL of the webpage from which to extract paragraph text.
  ///
  /// Returns:
  /// A [Future] that resolves to a single [String] containing all extracted paragraph
  /// texts concatenated together, separated by two newline characters.
  ///
  /// Throws:
  /// An [Exception] if the HTTP request fails or if the status code is not 200.
  ///
  /// Example:
  /// If the webpage contains three paragraphs with the texts "First paragraph.",
  /// "Second paragraph.", and "Third paragraph.", this method will return
  /// "First paragraph.\n\nSecond paragraph.\n\nThird paragraph.".
  static Future<String> extractAllParagraphsFromUrl(String url) async {
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
}
