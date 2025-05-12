import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sehetne_provider/fetures/auth/manager/logout/log_out_cubit.dart';
import 'package:sehetne_provider/fetures/auth/view/login_view.dart';
import 'package:sehetne_provider/fetures/profile/manager/services/email_luancher.dart';
import 'package:sehetne_provider/fetures/profile/view/analytics_view.dart';
import 'package:sehetne_provider/fetures/profile/view/change_paswword_view.dart';
import 'package:sehetne_provider/fetures/profile/view/complaint_view.dart';
import 'package:sehetne_provider/fetures/profile/view/edit_profile_view.dart';
import 'package:sehetne_provider/fetures/profile/view/feedBasks_view.dart';
import 'package:sehetne_provider/fetures/profile/view/history_view.dart';
import 'package:sehetne_provider/fetures/profile/view/profile_view.dart';
import 'package:sehetne_provider/fetures/profile/view/widgets/bloc_list.dart';
import 'package:sehetne_provider/fetures/profile/view/widgets/language_bottom_sheet.dart';
import 'package:sehetne_provider/fetures/profile/view/widgets/log_out_dialog.dart';
import 'package:sehetne_provider/generated/l10n.dart';


class ProfileBodyView extends StatefulWidget {
  const ProfileBodyView({super.key});

  @override
  State<ProfileBodyView> createState() => _ProfileBodyViewState();
}

class _ProfileBodyViewState extends State<ProfileBodyView> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return BlocProvider(
      create: (context) => LogOutCubit(),
      child: BlocConsumer<LogOutCubit, LogOutState>(
        listener: (context, state) {
          if (state is LogOutSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginView(),
              ),
              (route) => false,
            );
          } else if (state is LogOutFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Gap(screenSize.height * 0.02),
              BlocList(
                title: S.of(context).general,
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditProfileView(),
                        ),
                      );
                    },
                    leading: SvgPicture.asset(
                        "assets/images/Icons/basil_edit-solid.svg"),
                    title: CustomTxt(txt: S.of(context).editProfile, size: 16),
                    trailing: SvgPicture.asset(
                        "assets/images/Icons/ic_round-arrow-left.svg"),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChangePaswwordView(),
                        ),
                      );
                    },
                    leading: SvgPicture.asset(
                      "assets/images/Icons/ic_twotone-security.svg",
                    ),
                    title: CustomTxt(txt: S.of(context).Password, size: 16),
                    trailing: SvgPicture.asset(
                        "assets/images/Icons/ic_round-arrow-left.svg"),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AnalyticsView(),
                          ));
                    },
                    leading: SvgPicture.asset(
                      "assets/images/Icons/majesticons_analytics.svg",
                    ),
                    title: CustomTxt(txt: S.of(context).analytics, size: 16),
                    trailing: SvgPicture.asset(
                        "assets/images/Icons/ic_round-arrow-left.svg"),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FeedbasksView(),
                          ));
                    },
                    leading: SvgPicture.asset(
                      "assets/images/Icons/material-symbols_feedback-rounded.svg",
                    ),
                    title: CustomTxt(txt: S.of(context).feedback, size: 16),
                    trailing: SvgPicture.asset(
                        "assets/images/Icons/ic_round-arrow-left.svg"),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ComplaintView(),
                          ));
                    },
                    leading: SvgPicture.asset(
                      "assets/images/Icons/material-symbols_rate-review.svg",
                    ),
                    title: CustomTxt(txt: S.of(context).complaints, size: 16),
                    trailing: SvgPicture.asset(
                        "assets/images/Icons/ic_round-arrow-left.svg"),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HistoryView(),
                          ));
                    },
                    leading: SvgPicture.asset(
                      "assets/images/Icons/fluent_clock-bill-16-filled.svg",
                    ),
                    title: CustomTxt(txt: S.of(context).history, size: 16),
                    trailing: SvgPicture.asset(
                        "assets/images/Icons/ic_round-arrow-left.svg"),
                  ),
                ],
              ),
              Gap(screenSize.height * 0.03),
              BlocList(
                title: S.of(context).helpAndSupport,
                children: [
                  ListTile(
                    onTap: () {
                      EmailLauncher().launchEmail(
                        email: 's7tnaapp@gmail.com',
                        subject: 'welcome to Sehetna',
                        body: 'sehetna team always here to help you',
                        context: context,
                      );
                    },
                    leading: SvgPicture.asset(
                        "assets/images/Icons/eva_email-fill.svg"),
                    title: CustomTxt(txt: S.of(context).emailUs, size: 16),
                    trailing: SvgPicture.asset(
                        "assets/images/Icons/ic_round-arrow-left.svg"),
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                        "assets/images/Icons/fluent_call-12-filled.svg"),
                    title: CustomTxt(txt: S.of(context).contactUs, size: 16),
                    trailing: SvgPicture.asset(
                        "assets/images/Icons/ic_round-arrow-left.svg"),
                  ),
                ],
              ),
              Gap(screenSize.height * 0.03),
              BlocList(
                title: S.of(context).additionalSettings,
                children: [
                  ListTile(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return const LanguageBottomSheet();
                        },
                      );
                    },
                    leading: Image.asset("assets/images/Icons/translate.png"),
                    title: CustomTxt(txt: S.of(context).language, size: 16),
                    trailing: SvgPicture.asset(
                        "assets/images/Icons/ic_round-arrow-left.svg"),
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                        "assets/images/Icons/flowbite_star-solid.svg"),
                    title: CustomTxt(txt: S.of(context).rateUs, size: 16),
                    trailing: SvgPicture.asset(
                        "assets/images/Icons/ic_round-arrow-left.svg"),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => const LogoutDialog(),
                      );
                    },
                    child: ListTile(
                      leading: SvgPicture.asset(
                          "assets/images/Icons/solar_logout-3-bold.svg"),
                      title: CustomTxt(txt: S.of(context).logout, size: 16),
                      trailing: SvgPicture.asset(
                          "assets/images/Icons/ic_round-arrow-left.svg"),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
