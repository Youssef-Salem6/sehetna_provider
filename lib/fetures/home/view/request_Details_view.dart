import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:sehetne_provider/constants/apis.dart';
import 'package:sehetne_provider/core/Colors.dart';
import 'package:sehetne_provider/fetures/home/manager/RequestDetails/request_details_cubit.dart';
import 'package:sehetne_provider/fetures/home/models/requestDetailsModel.dart';
import 'package:sehetne_provider/fetures/home/services/location_service.dart';
import 'package:sehetne_provider/fetures/home/view/create_complaint_view.dart';
import 'package:sehetne_provider/fetures/home/view/request_services_view.dart';
import 'package:sehetne_provider/fetures/home/view/widgets/Request_details_row.dart';
import 'package:sehetne_provider/fetures/home/view/widgets/accept_request_button.dart';
import 'package:sehetne_provider/generated/l10n.dart';
import 'package:shimmer/shimmer.dart';

class RequestDetailsView extends StatefulWidget {
  final String requestId;
  const RequestDetailsView({super.key, required this.requestId});

  @override
  State<RequestDetailsView> createState() => _RequestDetailsViewState();
}

class _RequestDetailsViewState extends State<RequestDetailsView> {
  late Requestdetailsmodel request;

  @override
  void initState() {
    BlocProvider.of<RequestDetailsCubit>(
      context,
    ).getRequestDetails(requestId: widget.requestId);
    super.initState();
  }

  Widget _buildShimmerEffect(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: kPrimaryColor,
        title: Text(
          S.of(context).requestDetails,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image placeholder
              Container(
                width: size.width * 0.94,
                height: size.height * 0.45,
                color: Colors.white,
              ),
              Gap(size.height * 0.01),
              // Name and patient text placeholder
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 150, height: 20, color: Colors.white),
                  const Gap(4),
                  Container(width: 80, height: 16, color: Colors.white),
                ],
              ),
              const Spacer(),
              // Details rows placeholder
              Column(
                children: List.generate(
                  6,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Row(
                      children: [
                        Container(width: 20, height: 20, color: Colors.white),
                        const Gap(8),
                        Container(width: 100, height: 16, color: Colors.white),
                        const Spacer(),
                        Container(
                          width: size.width * 0.6,
                          height: 16,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(),
              // Buttons placeholder
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RequestDetailsCubit, RequestDetailsState>(
      listener: (context, state) {
        if (state is RequestDetailsSuccess) {
          request = Requestdetailsmodel.fromJson(
            json: BlocProvider.of<RequestDetailsCubit>(context).request,
          );
        }
      },
      builder: (context, state) {
        var size = MediaQuery.of(context).size;

        if (state is RequestDetailsLoading) {
          return _buildShimmerEffect(context);
        }

        // Add null check and provide default fallback for when data is not loaded yet
        if (state is! RequestDetailsSuccess) {
          // Return a basic loading or error UI if neither loading nor success
          return Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: kPrimaryColor,
              title: Text(
                S.of(context).requestDetails,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            body: const Center(child: Text("Failed to load request details")),
          );
        }

        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: kPrimaryColor,
            title: Text(
              S.of(context).requestDetails,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        border: Border.all(color: kPrimaryColor, width: 4),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image(
                          image: NetworkImage(
                            "$imagesBaseUrl/${request.customerImage}",
                          ),
                          width: size.width * 0.9,
                          height: size.height * 0.4,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(size.height * 0.01),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request.customerName!,
                      style: const TextStyle(
                        fontSize: 16,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      S.of(context).patient,
                      style: TextStyle(
                        fontSize: 14,
                        color: kPrimaryColor.withOpacity(0.6),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    RequestDetailsRow(
                      image: "assets/images/Icons/Vector.svg",
                      title: S.of(context).date,
                      value: DateFormat(
                        'MMMM d, h:mm a',
                      ).format(DateTime.parse(request.createdAt!)),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (request.services!.length > 1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => RequestServicesView(
                                    services: request.services!,
                                  ),
                            ),
                          );
                        }
                      },
                      child: RequestDetailsRow(
                        image: "assets/images/Icons/doctorBag.svg",
                        title: S.of(context).serviceType,
                        value:
                            request.services!.length == 1
                                ? request
                                    .services![0]["name"][Localizations.localeOf(
                                  context,
                                ).languageCode]
                                : "${request.services![0]["name"][Localizations.localeOf(context).languageCode]} +${request.services!.length - 1}",
                      ),
                    ),
                    RequestDetailsRow(
                      image: "assets/images/Icons/fees.svg",
                      title: S.of(context).totalFees,
                      value: "${request.totalPrice} EGP",
                    ),
                    RequestDetailsRow(
                      image: "assets/images/Icons/phone.svg",
                      title: S.of(context).callPatient,
                      value: request.customerPhone!,
                    ),
                    RequestDetailsRow(
                      image: "assets/images/Icons/genderIcon.svg",
                      title: S.of(context).gender,
                      value: request.customerGender!,
                    ),
                    RequestDetailsRow(
                      image: "assets/images/Icons/ageIcon.svg",
                      title: S.of(context).age,
                      value: request.customerAge!,
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    Visibility(
                      visible: request.status! == "accepted",
                      child: Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onPressed: () {
                            LocationService.openMapWithUrl(
                              locationUrl: request.location!,
                              context: context,
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/images/Icons/whiteLocation.svg",
                              ),
                              const Gap(5),
                              Text(
                                S.of(context).location,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: Visibility(
                        visible: request.status != "pending",
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => CreateComplaintView(
                                      requestId: request.requestId!,
                                    ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kSecondaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/images/Icons/whiteComplaint.svg",
                              ),
                              const Gap(5),
                              Text(
                                S.of(context).complaint,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible:
                      request.status == "pending" ||
                      request.status == "accepted",
                  child: AcceptRequestButton(
                    status: request.status!,
                    requestId: request.requestId.toString(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
