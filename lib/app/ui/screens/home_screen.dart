import 'package:flash_briefs/app/ui/widgets/home_screen_header_widget.dart';
import 'package:flash_briefs/app/ui/widgets/post_lists_widget.dart';
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
            const HomeScreenHeaderWidget(),
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
                                '...Loading news',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
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
