import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sehetne_provider/fetures/auth/manager/updateFcmToken/update_fcm_token_cubit.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sehetne_provider/core/Colors.dart';
import 'package:sehetne_provider/core/Custom_Button.dart';
import 'package:sehetne_provider/core/authPassField.dart';
import 'package:sehetne_provider/core/authTextField.dart';

import 'package:sehetne_provider/core/custom_text.dart';
import 'package:sehetne_provider/core/nav_view.dart';
import 'package:sehetne_provider/fetures/auth/manager/login/login_cubit.dart';
import 'package:sehetne_provider/fetures/auth/view/documents_status_view.dart';
import 'package:sehetne_provider/fetures/auth/view/forget_password_view.dart';
import 'package:sehetne_provider/fetures/auth/view/register_documents_view.dart';
import 'package:sehetne_provider/fetures/auth/view/register_view.dart';
import 'package:sehetne_provider/generated/l10n.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const NavView()),
              (route) => false,
            );
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Login Failed pls try again")),
            );
          } else if (state is LoginWrongUserType) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("you can't login with this account"),
              ),
            );
          } else if (state is LoginFailurePendingAccount) {
            if (BlocProvider.of<LoginCubit>(context).missingList.isEmpty) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder:
                      (context) =>
                          DocumentsStatusView(email: emailController.text),
                ),
                (route) => false,
              );
            } else {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder:
                      (context) =>
                          RegisterDocumentsView(email: emailController.text),
                ),
                (route) => false,
              );
            }
          } else if (state is LoginWrongAccount) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Invalid Email Or Password")),
            );
          }
        },
        builder: (context, state) {
          return BlocBuilder<UpdateFcmTokenCubit, UpdateFcmTokenState>(
            builder: (context, state) {
              return SafeArea(
                child: Scaffold(
                  body: SingleChildScrollView(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: RadialGradient(
                          center: Alignment.center,
                          colors: bgColorList,
                          stops: [0.05, 0.6, 3],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: screenHeight,
                          child: Column(
                            children: [
                              Gap(screenHeight * 0.03),
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
                              Center(
                                child: ClipRect(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 6,
                                      sigmaY: 6,
                                    ),
                                    child: Container(
                                      width: screenWidth * 0.88,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Form(
                                          key: _formKey,
                                          child: SizedBox(
                                            height: screenHeight * 0.685,
                                            child:
                                                state is LoginLoading
                                                    ? _buildShimmerLoading(
                                                      screenHeight,
                                                    )
                                                    : ListView(
                                                      children: [
                                                        const Gap(10),
                                                        Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: CustomText(
                                                            txt:
                                                                S
                                                                    .of(context)
                                                                    .loginTitle,
                                                            size: 24,
                                                          ),
                                                        ),
                                                        Gap(
                                                          screenHeight * 0.04,
                                                        ),
                                                        CustomText(
                                                          txt:
                                                              S
                                                                  .of(context)
                                                                  .email,
                                                          size: 16,
                                                        ),
                                                        const Gap(12),
                                                        AuthTextField(
                                                          controller:
                                                              emailController,
                                                          hint:
                                                              S
                                                                  .of(context)
                                                                  .email,
                                                          type:
                                                              TextInputType
                                                                  .emailAddress,
                                                          validator: (value) {
                                                            if (value == null ||
                                                                value.isEmpty) {
                                                              return S
                                                                  .of(context)
                                                                  .embtyEmailWarning;
                                                            }
                                                            if (!RegExp(
                                                              r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}',
                                                            ).hasMatch(value)) {
                                                              return S
                                                                  .of(context)
                                                                  .inValidMailWarning;
                                                            }
                                                            return null;
                                                          },
                                                          backColor:
                                                              Colors.white,
                                                        ),
                                                        const Gap(25),
                                                        CustomText(
                                                          txt:
                                                              S
                                                                  .of(context)
                                                                  .Password,
                                                          size: 16,
                                                        ),
                                                        const Gap(12),
                                                        AuthPassField(
                                                          controller:
                                                              passwordController,
                                                          hint:
                                                              S
                                                                  .of(context)
                                                                  .Password,
                                                          type:
                                                              TextInputType
                                                                  .emailAddress,
                                                          validator: (value) {
                                                            if (value == null ||
                                                                value.isEmpty) {
                                                              return S
                                                                  .of(context)
                                                                  .embtyPasswordWarning;
                                                            }
                                                            if (value.length <
                                                                6) {
                                                              return S
                                                                  .of(context)
                                                                  .shortPasswordWarning;
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                        const Gap(12),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (
                                                                          context,
                                                                        ) =>
                                                                            const ForgetPasswordView(),
                                                                  ),
                                                                );
                                                              },
                                                              child: Text(
                                                                S
                                                                    .of(context)
                                                                    .ForgetPassword,
                                                                style: const TextStyle(
                                                                  color:
                                                                      Colors
                                                                          .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .underline,
                                                                  decorationColor:
                                                                      Colors
                                                                          .white,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const Gap(30),
                                                        GestureDetector(
                                                          onTap: () {
                                                            if (_formKey
                                                                .currentState!
                                                                .validate()) {
                                                              BlocProvider.of<
                                                                UpdateFcmTokenCubit
                                                              >(
                                                                context,
                                                              ).updateFcmToken(
                                                                email:
                                                                    emailController
                                                                        .text,
                                                              );
                                                              BlocProvider.of<
                                                                LoginCubit
                                                              >(context).login(
                                                                emailController
                                                                    .text,
                                                                passwordController
                                                                    .text,
                                                              );
                                                            }
                                                          },
                                                          child: CustomButton(
                                                            title:
                                                                S
                                                                    .of(context)
                                                                    .login,
                                                          ),
                                                        ),
                                                        const Gap(100),
                                                        // Align(
                                                        //   alignment:
                                                        //       Alignment.center,
                                                        //   child: CustomText(
                                                        //     txt:
                                                        //         S
                                                        //             .of(context)
                                                        //             .orLoginWith,
                                                        //     size: 16,
                                                        //   ),
                                                        // ),
                                                        // const Gap(20),
                                                        // const Row(
                                                        //   mainAxisAlignment:
                                                        //       MainAxisAlignment
                                                        //           .spaceEvenly,
                                                        //   children: [
                                                        //     CustomIcon(
                                                        //       image:
                                                        //           "assets/images/akar-icons_google-contained-fill.svg",
                                                        //     ),
                                                        //     CustomIcon(
                                                        //       image:
                                                        //           "assets/images/appleLogo.svg",
                                                        //     ),
                                                        //     CustomIcon(
                                                        //       image:
                                                        //           "assets/images/faceBookLogo.svg",
                                                        //     ),
                                                        //   ],
                                                        // ),
                                                        // const Gap(30),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              S
                                                                  .of(context)
                                                                  .dontHaveAccount,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white
                                                                    .withOpacity(
                                                                      0.3,
                                                                    ),
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (
                                                                          context,
                                                                        ) =>
                                                                            const RegisterView(),
                                                                  ),
                                                                );
                                                              },
                                                              child: CustomText(
                                                                txt:
                                                                    S
                                                                        .of(
                                                                          context,
                                                                        )
                                                                        .signUp,
                                                                size: 16,
                                                              ),
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

  Widget _buildShimmerLoading(double screenHeight) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView(
        children: [
          const Gap(10),
          Container(width: 200, height: 30, color: Colors.white),
          Gap(screenHeight * 0.04),
          Container(width: 100, height: 20, color: Colors.white),
          const Gap(12),
          Container(width: double.infinity, height: 50, color: Colors.white),
          const Gap(25),
          Container(width: 100, height: 20, color: Colors.white),
          const Gap(12),
          Container(width: double.infinity, height: 50, color: Colors.white),
          const Gap(12),
          Align(
            alignment: Alignment.centerRight,
            child: Container(width: 150, height: 20, color: Colors.white),
          ),
          const Gap(30),
          Container(width: double.infinity, height: 50, color: Colors.white),
          const Gap(50),
          Container(
            width: 150,
            height: 20,
            color: Colors.white,
            margin: const EdgeInsets.symmetric(horizontal: 100),
          ),
          const Gap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              3,
              (index) => Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          const Gap(30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Container(width: 200, height: 20, color: Colors.white)],
          ),
        ],
      ),
    );
  }
}
