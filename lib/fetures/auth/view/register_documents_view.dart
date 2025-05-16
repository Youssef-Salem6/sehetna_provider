import 'dart:io';
import 'dart:ui';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:sehetne_provider/core/Colors.dart';
import 'package:sehetne_provider/core/Custom_Button.dart';
import 'package:sehetne_provider/core/custom_text.dart';
import 'package:sehetne_provider/fetures/auth/manager/requiredDocuments/required_documents_cubit.dart';
import 'package:sehetne_provider/fetures/auth/manager/uploadDecuments/upload_documents_cubit.dart';
import 'package:sehetne_provider/fetures/auth/view/documents_status_view.dart';
import 'package:sehetne_provider/generated/l10n.dart';
import 'package:sehetne_provider/main.dart';

class RegisterDocumentsView extends StatefulWidget {
  final String email;
  const RegisterDocumentsView({super.key, required this.email});

  @override
  State<RegisterDocumentsView> createState() => _RegisterDocumentsViewState();
}

class _RegisterDocumentsViewState extends State<RegisterDocumentsView> {
  List<File?> selectedFiles = [];
  List<bool> isUploaded = [];

  @override
  void initState() {
    super.initState();
    // Initialize selectedFiles and isUploaded lists once
    BlocProvider.of<RequiredDocumentsCubit>(
      context,
    ).getRequirdesDocs(email: widget.email).then((_) {
      selectedFiles = List<File?>.filled(
        BlocProvider.of<RequiredDocumentsCubit>(context).requiredDocs.length,
        null,
      );
      isUploaded = List<bool>.filled(
        BlocProvider.of<RequiredDocumentsCubit>(context).requiredDocs.length,
        false,
      );
    });
  }

  Future<void> pickPdf(int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        selectedFiles[index] = File(result.files.single.path!);
        isUploaded[index] = true;
      });
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'File selected: ${result.files.single.path!.split('/').last}',
          ),
        ),
      );
    }
  }

  void uploadFiles() {
    var requiredDocsCubit = BlocProvider.of<RequiredDocumentsCubit>(context);
    List<Map<String, dynamic>> documentsToUpload = [];

    // Check if all documents are uploaded
    bool allDocumentsUploaded = true;
    for (int i = 0; i < requiredDocsCubit.requiredDocs.length; i++) {
      if (selectedFiles[i] == null) {
        allDocumentsUploaded = false;
        break;
      }
    }

    if (!allDocumentsUploaded) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please upload all required documents before proceeding.',
          ),
        ),
      );
      return; // Exit the function if not all documents are uploaded
    }

    // If all documents are uploaded, prepare the data for the API call
    for (int i = 0; i < requiredDocsCubit.requiredDocs.length; i++) {
      if (selectedFiles[i] != null) {
        documentsToUpload.add({
          'email': widget.email,
          'required_document_id': requiredDocsCubit.requiredDocs[i].id,
          'file': selectedFiles[i]!,
        });
      }
    }

    // Call the upload API
    BlocProvider.of<UploadDocumentsCubit>(
      context,
    ).uploadDocuments(documentsToUpload);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: BlocListener<UploadDocumentsCubit, UploadDocumentsState>(
          listener: (context, state) {
            if (state is UploadDocumentsSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Documents uploaded successfully!'),
                ),
              );
              pref.setString("location", "documentsStatus");
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => DocumentsStatusView(email: widget.email),
                ),
                (route) => false,
              );
            } else if (state is UploadDocumentsFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Failed to upload documents.')),
              );
            }
          },
          child: BlocBuilder<RequiredDocumentsCubit, RequiredDocumentsState>(
            builder: (context, state) {
              if (state is RequiredDocumentsFailure) {
                return const Center(
                  child: Text('Failed to load required documents.'),
                );
              } else if (state is RequiredDocumentsSuccess) {
                var requiredDocsCubit = BlocProvider.of<RequiredDocumentsCubit>(
                  context,
                );
                return ListView(
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
                                  SvgPicture.asset("assets/images/Logo.svg"),
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
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: SizedBox(
                                          height: screenHeight * 0.5,
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
                                              const Gap(10),
                                              CustomText(
                                                txt:
                                                    S
                                                        .of(context)
                                                        .uploadRequiredDocuments,
                                                size: 16,
                                              ),
                                              const Gap(20),
                                              for (
                                                int i = 0;
                                                i <
                                                    requiredDocsCubit
                                                        .requiredDocs
                                                        .length;
                                                i++
                                              )
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start, // Align the children to the left
                                                  children: [
                                                    // Document Name Above the Upload Field
                                                    Text(
                                                      requiredDocsCubit
                                                              .requiredDocs[i]
                                                              .name ??
                                                          'Document ${i + 1}',
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const Gap(8),
                                                    // Upload Field
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              8,
                                                            ),
                                                        border: Border.all(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.all(
                                                              8.0,
                                                            ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            // Display "Upload Here" or the uploaded file name
                                                            Text(
                                                              isUploaded[i] &&
                                                                      selectedFiles[i] !=
                                                                          null
                                                                  ? selectedFiles[i]!
                                                                      .path
                                                                      .split(
                                                                        '/',
                                                                      )
                                                                      .last
                                                                  : S
                                                                      .of(
                                                                        context,
                                                                      )
                                                                      .uploadHere,
                                                              style: TextStyle(
                                                                color:
                                                                    isUploaded[i] &&
                                                                            selectedFiles[i] !=
                                                                                null
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .white
                                                                            .withOpacity(
                                                                              0.6,
                                                                            ),
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap:
                                                                  () => pickPdf(
                                                                    i,
                                                                  ),
                                                              child: const Icon(
                                                                Icons
                                                                    .upload_file,
                                                                color:
                                                                    Colors
                                                                        .white,
                                                                size: 25,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    const Gap(16),
                                                  ],
                                                ),
                                              const Gap(50),
                                              GestureDetector(
                                                onTap: uploadFiles,
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
                                                  child: const CustomButton(
                                                    title: 'Upload Documents',
                                                  ),
                                                ),
                                              ),
                                              const Gap(50),
                                            ],
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
                );
              } else {
                return const Center(child: Text('Initializing...'));
              }
            },
          ),
        ),
      ),
    );
  }
}
