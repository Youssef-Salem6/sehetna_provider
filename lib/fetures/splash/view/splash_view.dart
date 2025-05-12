import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sehetne_provider/core/Colors.dart';
import 'package:sehetne_provider/core/nav_view.dart';
import 'package:sehetne_provider/fetures/auth/view/documents_status_view.dart';
import 'package:sehetne_provider/fetures/auth/view/login_view.dart';
import 'package:sehetne_provider/fetures/auth/view/register_documents_view.dart';
import 'package:sehetne_provider/fetures/onBoarding/views/onboarding_view.dart';
import 'package:sehetne_provider/main.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      if (pref.getString("token") != null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const NavView()),
          (route) => false,
        );
      } else {
        if (pref.getBool("isFirstTime") == null) {
          // First-time user, navigate to OnBoardingView
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const OnBoardingView()),
            (route) => false,
          );
        } else {
          // Check the user's location and navigate accordingly
          final location = pref.getString("location");
          final email = pref.getString("email");

          if (location == "documentsStatus" && email != null) {
            // Navigate to DocumentsStatusView
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => DocumentsStatusView(email: email),
              ),
              (route) => false,
            );
          } else if (location == "uploadDocuments" && email != null) {
            // Navigate to RegisterDocumentsView
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => RegisterDocumentsView(email: email),
              ),
              (route) => false,
            );
          } else {
            // Default navigation to LoginView
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginView()),
              (route) => false,
            );
          }
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center, // Center the gradient
            colors: bgColorList,
            stops: [0.05, 0.6, 3], // Adjust the stops for smooth transitions
          ),
        ),
        child: Center(child: SvgPicture.asset("assets/images/Logo.svg")),
      ),
    );
  }
}
