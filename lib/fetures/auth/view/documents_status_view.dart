import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:sehetne_provider/core/Colors.dart';
import 'package:sehetne_provider/core/custom_text.dart';
import 'package:sehetne_provider/fetures/auth/manager/documentsStatus/documents_status_cubit.dart';
import 'package:sehetne_provider/fetures/auth/models/document_status_model.dart';
import 'package:sehetne_provider/fetures/auth/view/login_view.dart';
import 'package:sehetne_provider/fetures/auth/view/register_documents_view.dart';
import 'package:sehetne_provider/fetures/auth/view/widgets/document_status_card.dart';
import 'package:sehetne_provider/fetures/auth/view/widgets/loading_view.dart';
import 'package:sehetne_provider/generated/l10n.dart';
import 'package:sehetne_provider/main.dart';

class DocumentsStatusView extends StatefulWidget {
  final String email;
  const DocumentsStatusView({super.key, required this.email});

  @override
  State<DocumentsStatusView> createState() => _DocumentsStatusViewState();
}

class _DocumentsStatusViewState extends State<DocumentsStatusView> {
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    BlocProvider.of<DocumentsStatusCubit>(context)
        .getDocumentsStatus(email: widget.email);
    super.initState();
  }

  String getStatus() {
    if (BlocProvider.of<DocumentsStatusCubit>(context).accountStatus ==
        "approved") {
      return "continue";
    } else {
      return "Re-upload";
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocBuilder<DocumentsStatusCubit, DocumentsStatusState>(
      builder: (context, state) {
        return state is DocumentsStatusLoading
            ? const LoadingView()
            : SafeArea(
                child: Scaffold(
                  body: SingleChildScrollView(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: RadialGradient(
                          center: Alignment.center, // Center the gradient
                          colors: bgColorList,
                          stops: [
                            0.1,
                            0.6,
                            1,
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
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginView()));
                                    },
                                    child: SvgPicture.asset(
                                      "assets/images/Logo.svg",
                                      height: 65,
                                    ),
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
                                                SvgPicture.asset(
                                                  "assets/images/Mobile note list-amico 1.svg",
                                                  width: screenWidth * 0.7,
                                                ),
                                                CustomText(
                                                    txt: S
                                                        .of(context)
                                                        .documentsReviewDescription,
                                                    size: 20),
                                                Gap(screenHeight * 0.02),
                                                CustomText(
                                                    txt:
                                                        S.of(context).documents,
                                                    size: 16),
                                                const Gap(10),
                                                SizedBox(
                                                  height: screenHeight * 0.15,
                                                  child: ListView.builder(
                                                    itemCount: BlocProvider.of<
                                                                DocumentsStatusCubit>(
                                                            context)
                                                        .documents
                                                        .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      DocumentStatusModel
                                                          documentStatusModel =
                                                          DocumentStatusModel
                                                              .fromJson(BlocProvider
                                                                      .of<DocumentsStatusCubit>(
                                                                          context)
                                                                  .documents[index]);
                                                      return DocumentStatusCard(
                                                        documentStatusModel:
                                                            documentStatusModel,
                                                      );
                                                    },
                                                  ),
                                                ),
                                                const Gap(10),
                                                GestureDetector(
                                                  onTap: () async {
                                                    if (getStatus() ==
                                                        "continue") {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const LoginView(),
                                                        ),
                                                      );
                                                    } else {
                                                      await pref.setString(
                                                          "location",
                                                          "uploadDocuments");
                                                      Navigator
                                                          .pushAndRemoveUntil(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              RegisterDocumentsView(
                                                            email: widget.email,
                                                          ),
                                                        ),
                                                        (route) => false,
                                                      );
                                                    }
                                                  },
                                                  child: Visibility(
                                                    visible: BlocProvider.of<
                                                                    DocumentsStatusCubit>(
                                                                context)
                                                            .accountStatus !=
                                                        "pending",
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        border: Border.all(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: CustomText(
                                                              txt: getStatus(),
                                                              size: 18),
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
  }
}
