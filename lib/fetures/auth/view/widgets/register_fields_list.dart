import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sehetne_provider/core/authPassField.dart';
import 'package:sehetne_provider/core/authTextField.dart';
import 'package:sehetne_provider/core/custom_text.dart';
import 'package:sehetne_provider/generated/l10n.dart';

class RegisterFieldsList extends StatefulWidget {
  final Map controllers;
  const RegisterFieldsList({super.key, required this.controllers});

  @override
  State<RegisterFieldsList> createState() => _RegisterFieldsListState();
}

class _RegisterFieldsListState extends State<RegisterFieldsList> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return ListView(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(txt: S.of(context).firstName, size: 16),
                  const Gap(8),
                  AuthTextField(
                    controller: widget.controllers["firstNameController"],
                    hint: S.of(context).firstName,
                    type: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).embtyFirstnameWarning;
                      }
                      if (value.length < 3) {
                        return S.of(context).shortFirstnameWarning;
                      }
                      return null;
                    },
                    backColor: Colors.white,
                  ),
                ],
              ),
            ),
            Gap(screenWidth * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(txt: S.of(context).lastName, size: 16),
                  const Gap(8),
                  AuthTextField(
                    controller: widget.controllers["lastNameController"],
                    hint: S.of(context).lastName,
                    type: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).embtyLastnameWarning;
                      }
                      if (value.length < 3) {
                        return S.of(context).shortLastnameWarning;
                      }
                      return null;
                    },
                    backColor: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
        const Gap(12),
        CustomText(txt: S.of(context).email, size: 16),
        const Gap(8),
        AuthTextField(
          controller: widget.controllers["emailController"],
          hint: S.of(context).email,
          type: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return S.of(context).embtyEmailWarning;
            }
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}').hasMatch(value)) {
              return S.of(context).inValidMailWarning;
            }
            return null;
          },
          backColor: Colors.white,
        ),
        const Gap(20),
        // CustomText(txt: S.of(context).phone, size: 16),
        // const Gap(8),
        // AuthTextField(
        //   backColor: Colors.white,
        //   controller: widget.controllers["phoneController"],
        //   hint: S.of(context).phone,
        //   type: TextInputType.emailAddress,
        //   validator: (value) {
        //     if (value == null || value.isEmpty) {
        //       return S.of(context).embtyPhoneWarning;
        //     }
        //     if (value.length < 11) {
        //       return S.of(context).shortPhoneWarning;
        //     }
        //     return null;
        //   },
        // ),
        // const Gap(20),
        // CustomText(txt: S.of(context).address, size: 16),
        // const Gap(8),
        // AuthTextField(
        //   controller: widget.controllers["addressController"],
        //   hint: S.of(context).address,
        //   type: TextInputType.streetAddress,
        //   validator: (value) {
        //     if (value == null || value.isEmpty) {
        //       return S.of(context).embtyAddressWarning;
        //     }
        //     if (value.length < 3) {
        //       return S.of(context).shortAddressWarning;
        //     }
        //     return null;
        //   },
        //   backColor: Colors.white,
        // ),
        // const Gap(20),
        CustomText(txt: S.of(context).Password, size: 16),
        const Gap(8),
        AuthPassField(
          controller: widget.controllers["passwordController"],
          hint: S.of(context).Password,
          type: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return S.of(context).embtyPasswordWarning;
            }
            if (value.length < 6) {
              return S.of(context).shortPasswordWarning;
            }
            return null;
          },
        ),
        const Gap(20),
        CustomText(txt: S.of(context).confermationPassword, size: 16),
        const Gap(8),
        AuthPassField(
          controller: widget.controllers["confirmPasswordController"],
          hint: S.of(context).confermationPassword,
          type: TextInputType.visiblePassword,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return S.of(context).embtyPasswordWarning;
            }
            if (value.length < 6) {
              return S.of(context).shortPasswordWarning;
            }
            return null;
          },
        ),
      ],
    );
  }
}
