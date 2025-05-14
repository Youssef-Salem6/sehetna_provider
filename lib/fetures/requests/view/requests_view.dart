import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehetne_provider/fetures/requests/manager/changeStatus/change_status_cubit.dart';
import 'package:sehetne_provider/fetures/requests/manager/getLocation/get_location_cubit.dart';
import 'package:sehetne_provider/main.dart';

class RequestsView extends StatefulWidget {
  const RequestsView({super.key});

  @override
  State<RequestsView> createState() => _RequestsViewState();
}

class _RequestsViewState extends State<RequestsView> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? providerId;

  @override
  void initState() {
    super.initState();
    // Get the provider ID from shared preferences
    providerId = pref.getString("id");
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ChangeStatusCubit()),
        BlocProvider(create: (context) => GetLocationCubit()),
      ],
      child: BlocConsumer<ChangeStatusCubit, ChangeStatusState>(
        listener: (context, state) {
          if (state is ChangeStatusSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is ChangeStatusFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
        },
        builder: (context, changeStatusState) {
          var changeStatusCubit = BlocProvider.of<ChangeStatusCubit>(context);
          return BlocConsumer<GetLocationCubit, GetLocationState>(
            listener: (context, locationState) {
              if (locationState is GetLocationFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(locationState.errorMessage)),
                );
              } else if (locationState is GetLocationLoaded &&
                  changeStatusState is! ChangeStatusLoading) {
                double latitude = double.tryParse(locationState.latitude) ?? 0;
                double longitude =
                    double.tryParse(locationState.longitude) ?? 0;
                changeStatusCubit.changeStatus(lati: latitude, long: longitude);
              }
            },
            builder: (context, locationState) {
              return Scaffold(
                appBar: AppBar(title: const Text('Service Requests')),
                body: SafeArea(
                  child: Column(
                    children: [
                      Expanded(
                        child:
                            providerId != null
                                ? _buildRequestsStream(providerId!)
                                : const Center(
                                  child: Text('Provider ID not available'),
                                ),
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (changeStatusState is! ChangeStatusLoading) {
                              BlocProvider.of<GetLocationCubit>(
                                context,
                              ).getLocation();
                            }
                          },
                          child: _buildButtonText(
                            changeStatusCubit,
                            changeStatusState,
                            locationState,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
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

  Widget _buildRequestsStream(String providerId) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          _firestore
              .collection('provider_requests')
              .doc("3")
              .collection('notifications')
              .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No requests available'));
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var request = snapshot.data!.docs[index];
            return _buildRequestCard(request, context);
          },
        );
      },
    );
  }

  Widget _buildRequestCard(DocumentSnapshot request, BuildContext context) {
    Map<String, dynamic> data = request.data() as Map<String, dynamic>;
    String? imageUrl = data['customer_image'];
    String status = data['status'] ?? 'pending';

    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(color: _getStatusColor(status), width: 2.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // CircleAvatar(
                //   radius: 30,
                //   backgroundColor: Colors.grey.shade200,
                //   backgroundImage:
                //       imageUrl != null && imageUrl.isNotEmpty
                //           ? NetworkImage("$imagesBaseUrl/$imageUrl")
                //           : null,
                //   child:
                //       imageUrl == null || imageUrl.isEmpty
                //           ? const Icon(
                //             Icons.person,
                //             size: 30,
                //             color: Colors.grey,
                //           )
                //           : null,
                //   onBackgroundImageError: (exception, stackTrace) {
                //     // This will be called if the network image fails to load
                //     setState(() {
                //       imageUrl = null; // Fall back to placeholder
                //     });
                //   },
                // ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['customer_name'] ?? 'Unknown Customer',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        data['service_names'] ?? 'No services specified',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Distance: ${data['distance'] ?? 'N/A'}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(status).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              _capitalizeFirstLetter(status),
                              style: TextStyle(
                                color: _getStatusColor(status),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (data['timestamp'] != null) ...[
                            const SizedBox(width: 8),
                            Text(
                              _formatTimestamp(data['timestamp']),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: \$${data['total_price']?.toString() ?? '0.00'}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    TextButton(onPressed: () {}, child: const Text('Details')),
                    const SizedBox(width: 8),
                    status == 'pending'
                        ? ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Accept'),
                        )
                        : Container(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'accepted':
        return Colors.green;
      case 'completed':
        return Colors.blue;
      case 'cancelled':
        return Colors.red;
      case 'pending':
      default:
        return Colors.orange;
    }
  }

  String _capitalizeFirstLetter(String text) {
    if (text.isEmpty) return '';
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  String _formatTimestamp(dynamic timestamp) {
    if (timestamp is Timestamp) {
      DateTime dateTime = timestamp.toDate();
      return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else if (timestamp is String) {
      // Try to parse the string if it's in a known format
      try {
        DateTime dateTime = DateTime.parse(timestamp);
        return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
      } catch (e) {
        return timestamp;
      }
    }
    return 'Unknown time';
  }

  Widget _buildButtonText(
    ChangeStatusCubit cubit,
    ChangeStatusState changeStatusState,
    GetLocationState locationState,
  ) {
    if (changeStatusState is ChangeStatusLoading) {
      return const CircularProgressIndicator(color: Colors.white);
    }

    if (locationState is GetLocationLoading) {
      return const Text("Getting location...");
    }

    return Text(cubit.isActive ? "Deactivate" : "Activate");
  }
}
