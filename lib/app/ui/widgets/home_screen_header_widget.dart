import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomeScreenHeaderWidget extends StatelessWidget {
  const HomeScreenHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
