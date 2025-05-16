import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:sehetne_provider/fetures/auth/manager/updateFcmToken/update_fcm_token_cubit.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sehetne_provider/core/Colors.dart';
import 'package:sehetne_provider/core/Custom_Button.dart';
import 'package:sehetne_provider/core/authTextField.dart';
import 'package:sehetne_provider/core/custom_text.dart';
import 'package:sehetne_provider/fetures/auth/manager/register/register_cubit.dart';
import 'package:sehetne_provider/fetures/auth/view/register_documents_view.dart';
import 'package:sehetne_provider/generated/l10n.dart';
import 'package:sehetne_provider/main.dart';

class RegisterSecondLevel extends StatefulWidget {
  final Map data;
  const RegisterSecondLevel({super.key, required this.data});

  @override
  State<RegisterSecondLevel> createState() => _RegisterSecondLevelState();
}

class _RegisterSecondLevelState extends State<RegisterSecondLevel> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController idController = TextEditingController();
  String? selectedUserType;

  final List<String> userTypes = ["Individual", "Organizational"];

  Widget _buildShimmerButton() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white),
          color: Colors.white,
        ),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              'Loading...',
              style: TextStyle(fontSize: 18, color: Colors.transparent),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder:
                    (context) =>
                        RegisterDocumentsView(email: widget.data["email"]),
              ),
            );
            pref.setString("location", "uploadDocuments");
          } else if (state is RegisterFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(backgroundColor: Colors.red, content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          bool isLoading = state is RegisterLoading;

          return BlocBuilder<UpdateFcmTokenCubit, UpdateFcmTokenState>(
            builder: (context, state) {
              return SafeArea(
                child: Scaffold(
                  body: Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          gradient: RadialGradient(
                            center: Alignment.center,
                            colors: bgColorList,
                            stops: [0.1, 0.4, 0.8],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: screenHeight,
                            child: ListView(
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
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
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
                                                  CustomText(
                                                    txt: S.of(context).phone,
                                                    size: 16,
                                                  ),
                                                  const Gap(8),
                                                  AuthTextField(
                                                    backColor: Colors.white,
                                                    controller: phoneController,
                                                    hint: S.of(context).phone,
                                                    type:
                                                        TextInputType
                                                            .emailAddress,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return S
                                                            .of(context)
                                                            .embtyPhoneWarning;
                                                      }
                                                      if (value.length < 11) {
                                                        return S
                                                            .of(context)
                                                            .shortPhoneWarning;
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  const Gap(20),
                                                  CustomText(
                                                    txt: S.of(context).address,
                                                    size: 16,
                                                  ),
                                                  const Gap(8),
                                                  AuthTextField(
                                                    controller:
                                                        addressController,
                                                    hint: S.of(context).address,
                                                    type:
                                                        TextInputType
                                                            .streetAddress,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return S
                                                            .of(context)
                                                            .embtyAddressWarning;
                                                      }
                                                      if (value.length < 3) {
                                                        return S
                                                            .of(context)
                                                            .shortAddressWarning;
                                                      }
                                                      return null;
                                                    },
                                                    backColor: Colors.white,
                                                  ),
                                                  const Gap(20),
                                                  CustomText(
                                                    txt:
                                                        S
                                                            .of(context)
                                                            .nationalId,
                                                    size: 16,
                                                  ),
                                                  const Gap(8),
                                                  AuthTextField(
                                                    controller: idController,
                                                    hint:
                                                        S
                                                            .of(context)
                                                            .nationalId,
                                                    type:
                                                        TextInputType
                                                            .streetAddress,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return S
                                                            .of(context)
                                                            .nationalIdEmbtyWarning;
                                                      }
                                                      if (value.length != 14) {
                                                        return S
                                                            .of(context)
                                                            .nationalIdShortWarning;
                                                      }
                                                      return null;
                                                    },
                                                    backColor: Colors.white,
                                                  ),
                                                  const Gap(20),
                                                  CustomText(
                                                    txt: S.of(context).userType,
                                                    size: 16,
                                                  ),
                                                  const Gap(8),
                                                  DropdownButtonFormField<
                                                    String
                                                  >(
                                                    value: selectedUserType,
                                                    decoration: InputDecoration(
                                                      fillColor: Colors.white
                                                          .withOpacity(0.2),
                                                      filled: true,
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  8,
                                                                ),
                                                            borderSide:
                                                                BorderSide.none,
                                                          ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  8,
                                                                ),
                                                            borderSide:
                                                                BorderSide.none,
                                                          ),
                                                      hintText:
                                                          S
                                                              .of(context)
                                                              .selectUserType,
                                                      hintStyle: TextStyle(
                                                        color: Colors.white
                                                            .withOpacity(0.6),
                                                      ),
                                                    ),
                                                    items:
                                                        userTypes.map((
                                                          String value,
                                                        ) {
                                                          return DropdownMenuItem<
                                                            String
                                                          >(
                                                            value: value,
                                                            child: Text(
                                                              value,
                                                              style: const TextStyle(
                                                                color:
                                                                    Colors
                                                                        .white,
                                                              ),
                                                            ),
                                                          );
                                                        }).toList(),
                                                    onChanged: (newValue) {
                                                      setState(() {
                                                        selectedUserType =
                                                            newValue;
                                                      });
                                                    },
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return S
                                                            .of(context)
                                                            .userTypeWarning;
                                                      }
                                                      return null;
                                                    },
                                                    dropdownColor:
                                                        Colors.grey[800],
                                                    icon: Icon(
                                                      Icons.arrow_drop_down,
                                                      color: Colors.white
                                                          .withOpacity(0.6),
                                                    ),
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  const Gap(30),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              pref.setString(
                                                                "gender",
                                                                "male",
                                                              );
                                                            });
                                                          },
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets.symmetric(
                                                                  vertical: 12,
                                                                ),
                                                            decoration: BoxDecoration(
                                                              color:
                                                                  pref.getString(
                                                                            "gender",
                                                                          ) ==
                                                                          'male'
                                                                      ? kPrimaryColor
                                                                      : Colors
                                                                          .white,
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    8,
                                                                  ),
                                                              border: Border.all(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                      0.5,
                                                                    ),
                                                              ),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                S
                                                                    .of(context)
                                                                    .male,
                                                                style: TextStyle(
                                                                  color:
                                                                      pref.getString(
                                                                                "gender",
                                                                              ) ==
                                                                              'male'
                                                                          ? Colors
                                                                              .white
                                                                          : Colors
                                                                              .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const Gap(8),
                                                      Expanded(
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              pref.setString(
                                                                'gender',
                                                                "female",
                                                              );
                                                            });
                                                          },
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets.symmetric(
                                                                  vertical: 12,
                                                                ),
                                                            decoration: BoxDecoration(
                                                              color:
                                                                  pref.getString(
                                                                            "gender",
                                                                          ) ==
                                                                          'female'
                                                                      ? const Color(
                                                                        0xFFFFC0CB,
                                                                      )
                                                                      : Colors
                                                                          .white,
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    8,
                                                                  ),
                                                              border: Border.all(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                      0.5,
                                                                    ),
                                                              ),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                S
                                                                    .of(context)
                                                                    .female,
                                                                style: const TextStyle(
                                                                  color:
                                                                      Colors
                                                                          .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const Gap(50),
                                                  GestureDetector(
                                                    onTap: () {
                                                      if (_formKey.currentState!
                                                          .validate()) {
                                                        BlocProvider.of<
                                                          UpdateFcmTokenCubit
                                                        >(
                                                          context,
                                                        ).updateFcmToken(
                                                          email:
                                                              widget
                                                                  .data["email"],
                                                        );
                                                        BlocProvider.of<
                                                          RegisterCubit
                                                        >(context).register(
                                                          body: {
                                                            "first_name":
                                                                widget
                                                                    .data["first_name"],
                                                            "last_name":
                                                                widget
                                                                    .data["last_name"],
                                                            "email":
                                                                widget
                                                                    .data["email"],
                                                            "phone":
                                                                phoneController
                                                                    .text,
                                                            "password":
                                                                widget
                                                                    .data["password"],
                                                            "password_confirmation":
                                                                widget
                                                                    .data["password_confirmation"],
                                                            "provider_type":
                                                                selectedUserType!
                                                                    .toLowerCase(),
                                                            "address":
                                                                addressController
                                                                    .text,
                                                            "user_type":
                                                                "provider",
                                                            "gender": pref
                                                                .getString(
                                                                  "gender",
                                                                ),
                                                            "nid":
                                                                idController
                                                                    .text,
                                                          },
                                                        );
                                                      }
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              8,
                                                            ),
                                                        border: Border.all(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      child:
                                                          isLoading
                                                              ? _buildShimmerButton()
                                                              : CustomButton(
                                                                title:
                                                                    S
                                                                        .of(
                                                                          context,
                                                                        )
                                                                        .signUp,
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
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (isLoading)
                        Container(
                          color: Colors.black.withOpacity(0.3),
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                kPrimaryColor,
                              ),
                            ),
                          ),
                        ),
                    ],
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
