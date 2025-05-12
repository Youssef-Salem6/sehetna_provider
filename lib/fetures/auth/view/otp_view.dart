import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
import 'package:sehetne_provider/core/Colors.dart';
import 'package:sehetne_provider/core/Custom_Button.dart';
import 'package:sehetne_provider/core/custom_text.dart';
import 'package:sehetne_provider/fetures/auth/manager/checkOtp/check_otp_cubit.dart';
import 'package:sehetne_provider/fetures/auth/manager/forgetPassword/forget_password_cubit.dart';
import 'package:sehetne_provider/fetures/auth/view/new_password_View.dart';
import 'package:sehetne_provider/generated/l10n.dart';


class OtpView extends StatefulWidget {
  final String email;
  const OtpView({super.key, required this.email});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  TextEditingController otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CheckOtpCubit(),
        ),
        BlocProvider(
          create: (context) => ForgetPasswordCubit(),
        ),
      ],
      child: BlocConsumer<CheckOtpCubit, CheckOtpState>(
        listener: (context, state) {
          if (state is CheckOtpSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Color.fromARGB(255, 111, 187, 113),
                content: Text(
                  'Code Verified , Enter New Password',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewPasswordView(
                  email: widget.email,
                ),
              ),
            );
          } else if (state is CheckOtpFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Color.fromARGB(255, 248, 117, 107),
                content: Text(
                  'Wrong Code',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
            listener: (context, state) {
              if (state is ForgetPasswordSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Color.fromARGB(255, 111, 187, 113),
                    content: Text(
                      'Reset code sent to your email.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                );
              } else if (state is ForgetPasswordFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Color.fromARGB(255, 248, 117, 107),
                    content: Text(
                      'Some Thing Wrong , please try again',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                );
              }
            },
            builder: (context, state) {
              return SafeArea(
                child: Scaffold(
                  body: SingleChildScrollView(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: RadialGradient(
                          center: Alignment.center, // Center the gradient
                          colors: bgColorList,
                          stops: [
                            0.1,
                            0.4,
                            0.8,
                          ], // Adjust the stops for smooth transitions
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: screenHeight,
                          child: Column(
                            children: [
                              Gap(screenHeight * 0.05),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/images/Logo.svg",
                                    height: 65,
                                  ),
                                ],
                              ),
                              Gap(screenHeight * 0.06),
                              // Blurred Container
                              Center(
                                child: ClipRect(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 6,
                                        sigmaY: 6), // Adjust blur intensity
                                    child: Container(
                                      width: screenWidth * 0.88,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.2),
                                        // Semi-transparent background
                                        borderRadius: BorderRadius.circular(
                                            8), // Rounded corners
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Form(
                                          key: _formKey,
                                          child: SizedBox(
                                            height: screenHeight * 0.63,
                                            child: ListView(
                                              children: [
                                                Gap(screenHeight * 0.03),
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: CustomText(
                                                      txt: S
                                                          .of(context)
                                                          .ForgetPassword,
                                                      size: 24),
                                                ),
                                                Gap(screenHeight * 0.03),
                                                SvgPicture.asset(
                                                  "assets/images/amico.svg",
                                                  width: 182,
                                                ),
                                                Gap(screenHeight * 0.03),
                                                Text(
                                                  S.of(context).otpInfo,
                                                  style: TextStyle(
                                                      color: Colors.white
                                                          .withOpacity(0.5),
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Gap(screenHeight * 0.03),
                                                Pinput(
                                                  length: 6,
                                                  controller: otpController,
                                                  defaultPinTheme: PinTheme(
                                                    width: 50,
                                                    height: 50,
                                                    textStyle: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.black
                                                          .withOpacity(0.25),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                  focusedPinTheme: PinTheme(
                                                    width: 50,
                                                    height: 50,
                                                    textStyle: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade200,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                          color: Colors.blue),
                                                    ),
                                                  ),
                                                  submittedPinTheme: PinTheme(
                                                    width: 50,
                                                    height: 50,
                                                    textStyle: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white
                                                          .withOpacity(0.1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                                Gap(screenHeight * 0.05),
                                                GestureDetector(
                                                  onTap: () {
                                                    BlocProvider.of<
                                                                CheckOtpCubit>(
                                                            context)
                                                        .checkCode(
                                                            email: widget.email,
                                                            code: otpController
                                                                .text);
                                                  },
                                                  child: CustomButton(
                                                      title: S
                                                          .of(context)
                                                          .conttinue),
                                                ),
                                                Gap(screenHeight * 0.03),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      S
                                                          .of(context)
                                                          .didnotReciveEmail,
                                                      style: TextStyle(
                                                        color: Colors.white
                                                            .withOpacity(0.3),
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        BlocProvider.of<
                                                                    ForgetPasswordCubit>(
                                                                context)
                                                            .forgetPassword(
                                                                email: widget
                                                                    .email);
                                                      },
                                                      child: CustomText(
                                                          txt: S
                                                              .of(context)
                                                              .resendCode,
                                                          size: 16),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
