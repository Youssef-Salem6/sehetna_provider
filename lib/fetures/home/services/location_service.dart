import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationService {
  /// Launches the map application with the provided location URL
  ///
  /// This service is designed to handle map URLs provided by the backend
  /// and open them in the appropriate map application
  ///
  /// Parameters:
  /// - locationUrl: The URL string provided by the backend
  /// - context: BuildContext for showing error messages if needed
  ///
  /// Returns a Future<void>
  static Future<void> openMapWithUrl({
    required String locationUrl,
    required BuildContext context,
  }) async {
    try {
      final Uri uri = Uri.parse(locationUrl);

      final bool launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched) {
        // The URL could not be launched
        if (context.mounted) {
          _showErrorMessage(
            context,
            'Could not open the map. Please try again.',
          );
        }
      }
    } catch (e) {
      // Error parsing or launching the URL
      debugPrint('Error launching map URL: $e');
      if (context.mounted) {
        _showErrorMessage(
          context,
          'Invalid location link. Please try again later.',
        );
      }
    }
  }

  /// Shows an error message to the user
  static void _showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
