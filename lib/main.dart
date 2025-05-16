import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sehetne_provider/fetures/auth/manager/documentsStatus/documents_status_cubit.dart';
import 'package:sehetne_provider/fetures/auth/manager/requiredDocuments/required_documents_cubit.dart';
import 'package:sehetne_provider/fetures/auth/manager/updateFcmToken/update_fcm_token_cubit.dart';
import 'package:sehetne_provider/fetures/auth/manager/uploadDecuments/upload_documents_cubit.dart';
import 'package:sehetne_provider/fetures/home/manager/RequestDetails/request_details_cubit.dart';
import 'package:sehetne_provider/fetures/home/manager/ongoingRequests/ongoing_requests_cubit.dart';
import 'package:sehetne_provider/fetures/profile/manager/getComplaints/get_complaints_cubit.dart';
import 'package:sehetne_provider/fetures/profile/manager/getFeedbacks/get_feedbacks_cubit.dart';
import 'package:sehetne_provider/fetures/profile/manager/getRequests/get_requests_cubit.dart';
import 'package:sehetne_provider/fetures/profile/manager/language/change_language_cubit.dart';
import 'package:sehetne_provider/fetures/profile/manager/services/email_luancher.dart';
import 'package:sehetne_provider/fetures/profile/manager/userAnalytics/user_analytics_cubit.dart';
import 'package:sehetne_provider/fetures/splash/view/splash_view.dart';
import 'package:sehetne_provider/firebase_options.dart';
import 'package:sehetne_provider/generated/l10n.dart';
import 'package:sehetne_provider/push_notification_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences pref;

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  pref = await SharedPreferences.getInstance();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await PushNotificationServices.init();
  final initialLanguage = pref.getString('language') ?? 'en';

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RequiredDocumentsCubit()),
        BlocProvider(create: (context) => UploadDocumentsCubit()),
        BlocProvider(create: (context) => DocumentsStatusCubit()),
        BlocProvider(create: (context) => RequestDetailsCubit()),
        BlocProvider(create: (context) => GetFeedbacksCubit()),
        BlocProvider(create: (context) => UserAnalyticsCubit()),
        BlocProvider(create: (context) => OngoingRequestsCubit()),
        BlocProvider(create: (context) => GetComplaintsCubit()),
        BlocProvider(create: (context) => GetRequestsCubit()),
        BlocProvider(create: (context) => UpdateFcmTokenCubit()),
        BlocProvider(
          create:
              (context) =>
                  ChangeLanguageCubit()
                    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                    ..emit(ChangeLanguageInitial(initialLanguage)),
        ),
      ],
      child: const SehetnaApp(),
    ),
  );
}

class SehetnaApp extends StatelessWidget {
  const SehetnaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeLanguageCubit, ChangeLanguageState>(
      builder: (context, state) {
        String languageCode;
        if (state is ChangeLanguageInitial) {
          languageCode = state.currentLanguage;
        } else if (state is ChangeLanguageSuccess) {
          languageCode = state.languageCode;
        } else {
          languageCode = pref.getString('language') ?? 'en';
        }

        return MaterialApp(
          navigatorKey: navigatorKey,
          locale: Locale(languageCode),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          theme: ThemeData(fontFamily: "UltimaPro"),
          home: const SplashView(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
