import 'package:flash_briefs/app/ui/widgets/post_lists_widget.dart';
import 'package:intl/intl.dart';
import 'package:flash_briefs/app/ui/cubits/top_headlines/top_headlines_cubit.dart';
import 'package:flash_briefs/app/ui/cubits/top_headlines/top_headlines_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TopHeadlinesCubit _topHeadlinesCubit;

  @override
  void initState() {
    super.initState();
    _topHeadlinesCubit = TopHeadlinesCubit()..fetchTopHeadlines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFCFC),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/profile_image.png',
                    height: 49,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome Back!',
                        style: GoogleFonts.openSans().copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: const Color(0xFF19202D),
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        DateFormat("MMM d, yyyy").format(
                          DateTime.now(),
                        ),
                        style: GoogleFonts.openSans().copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: const Color(0xFF19202D),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Top News',
              style: GoogleFonts.openSans().copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: const Color(0xFF19202D),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: BlocProvider.value(
                value: _topHeadlinesCubit,
                child: BlocBuilder<TopHeadlinesCubit, TopHeadlinesState>(
                  builder: (context, state) {
                    return state.when(
                      initial: () => const SizedBox.shrink(),
                      loadInProgress: () => const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      loadSuccess: (articles) => PostListsWidget(
                        articles: articles,
                      ),
                      loadFailure: () => const Center(
                        child: Text('Failed to fetch posts'),
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
}
