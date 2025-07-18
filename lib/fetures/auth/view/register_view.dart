import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:sehetne_provider/core/Colors.dart';
import 'package:sehetne_provider/core/Custom_Button.dart';

import 'package:sehetne_provider/core/custom_text.dart';
import 'package:sehetne_provider/fetures/auth/view/register_second_level.dart';
import 'package:sehetne_provider/fetures/auth/view/widgets/register_fields_list.dart';
import 'package:sehetne_provider/generated/l10n.dart';
import 'package:sehetne_provider/main.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Container(
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
                  child: ListView(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Gap(screenHeight * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/images/Logo.svg",
                            height: 65,
                          ),
                        ],
                      ),
                      Gap(screenHeight * 0.03),
                      // Blurred Container
                      Center(
                        child: ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 6,
                              sigmaY: 6,
                            ), // Adjust blur intensity
                            child: Container(
                              width: screenWidth * 0.88,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.2),
                                // Semi-transparent background
                                borderRadius: BorderRadius.circular(
                                  8,
                                ), // Rounded corners
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Form(
                                  key: _formKey,
                                  child: SizedBox(
                                    height: screenHeight * 0.75,
                                    child: ListView(
                                      children: [
                                        const Gap(10),
                                        Align(
                                          alignment: Alignment.center,
                                          child: CustomText(
                                            txt: S.of(context).joinUs,
                                            size: 24,
                                          ),
                                        ),
                                        Gap(screenHeight * 0.02),
                                        SizedBox(
                                          height: screenHeight * 0.4,
                                          child: RegisterFieldsList(
                                            controllers: {
                                              "firstNameController":
                                                  firstNameController,
                                              "lastNameController":
                                                  lastNameController,
                                              "passwordController":
                                                  passwordController,
                                              "confirmPasswordController":
                                                  confirmPasswordController,
                                              "emailController":
                                                  emailController,
                                            },
                                          ),
                                        ),
                                        const Gap(50),
                                        GestureDetector(
                                          onTap: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              pref.setString(
                                                "email",
                                                emailController.text,
                                              );
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (
                                                        context,
                                                      ) => RegisterSecondLevel(
                                                        data: {
                                                          "first_name":
                                                              firstNameController
                                                                  .text,
                                                          "last_name":
                                                              lastNameController
                                                                  .text,
                                                          "password":
                                                              passwordController
                                                                  .text,
                                                          "email":
                                                              emailController
                                                                  .text,
                                                          "password_confirmation":
                                                              confirmPasswordController
                                                                  .text,
                                                        },
                                                      ),
                                                ),
                                              );
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                color: Colors.white,
                                              ),
                                            ),
                                            child: CustomButton(
                                              title: S.of(context).conttinue,
                                            ),
                                          ),
                                        ),
                                        const Gap(50),
                                        // Align(
                                        //   alignment: Alignment.center,
                                        //   child: CustomText(
                                        //     txt: S.of(context).signUpWith,
                                        //     size: 16,
                                        //   ),
                                        // ),
                                        // const Gap(20),
                                        // const Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.spaceEvenly,
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
                                        const Gap(30),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              S.of(context).haveAccount,
                                              style: TextStyle(
                                                color: Colors.white.withOpacity(
                                                  0.3,
                                                ),
                                                fontSize: 16,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: CustomText(
                                                txt: S.of(context).login,
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
          ],
        ),
      ),
    );
  }
}
