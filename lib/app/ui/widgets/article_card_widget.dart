import 'package:flash_briefs/app/data/models/news_article.dart';
import 'package:flash_briefs/app/ui/screens/post_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ArticleCardWidget extends StatelessWidget {
  const ArticleCardWidget({
    super.key,
    required this.article,
  });
  final NewsArticle article;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => PostDetailScreen(
            article: article,
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            _ArticleImage(imageUrl: article.urlToImage),
            const SizedBox(height: 18),
            _ArticleTitle(title: article.title),
            const SizedBox(height: 16),
            _ArticleAuthorAndDate(
              article: article,
            ),
          ],
        ),
      ),
    );
  }
}

class _ArticleImage extends StatelessWidget {
  const _ArticleImage({
    super.key,
    required this.imageUrl,
  });
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 164,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(imageUrl ?? ''),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _ArticleTitle extends StatelessWidget {
  const _ArticleTitle({
    super.key,
    required this.title,
  });
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title ?? '',
      style: GoogleFonts.openSans().copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 15,
        color: const Color(0xFF19202D),
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _ArticleAuthorAndDate extends StatelessWidget {
  const _ArticleAuthorAndDate({
    super.key,
    required this.article,
  });
  final NewsArticle article;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 19,
          child: Text(
            _getInitials(article.author ?? ''),
            style: GoogleFonts.openSans().copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: const Color(0xFF19202D),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                article.author ?? '',
                style: GoogleFonts.openSans().copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: const Color(0xFF19202D),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                DateFormat("MMM d, yyyy")
                    .format(DateTime.parse(article.publishedAt ?? '')),
                style: GoogleFonts.openSans().copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: const Color(0xFF9397A0),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  String _getInitials(String name) {
    return name.isNotEmpty
        ? name.trim().split(' ').map((e) => e[0].toUpperCase()).take(2).join()
        : '';
  }
}
