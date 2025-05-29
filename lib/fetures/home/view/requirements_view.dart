import 'package:flutter/material.dart';
import 'package:sehetne_provider/core/Colors.dart';
import 'package:sehetne_provider/fetures/home/models/requirement_model.dart';
import 'package:sehetne_provider/fetures/home/view/image_view.dart';

class RequirementsView extends StatelessWidget {
  final List requirements;

  const RequirementsView({super.key, required this.requirements});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Requirements',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: kPrimaryColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [kPrimaryColor, kSecondaryColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body:
          requirements.isEmpty
              ? _buildEmptyState()
              : Column(
                children: [
                  _buildHeader(),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: requirements.length,
                      itemBuilder: (context, index) {
                        return _buildRequirementCard(
                          RequirementModel.fromjson(
                            json: requirements[index],
                            languageCode:
                                Localizations.localeOf(context).languageCode,
                          ),
                          context,
                          index,
                        );
                      },
                    ),
                  ),
                ],
              ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [kPrimaryColor.withOpacity(0.1), Colors.transparent],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: kPrimaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.assignment_outlined,
              color: kPrimaryColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Total Requirements',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${requirements.length} items',
                style: TextStyle(
                  fontSize: 16,
                  color: kSecondaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: kPrimaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.description_outlined,
              size: 64,
              color: kPrimaryColor,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No Requirements Found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: kSecondaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'There are no requirements to display\nat the moment.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () {
              // Add refresh functionality here
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Refresh'),
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequirementCard(
    RequirementModel requirement,
    BuildContext context,
    int index,
  ) {
    final isFileType = requirement.requirementType == 'file';

    return AnimatedContainer(
      duration: Duration(milliseconds: 300 + (index * 100)),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => _handleRequirementTap(requirement, context),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCardHeader(requirement, isFileType),
                  const SizedBox(height: 16),
                  _buildCardContent(requirement, isFileType),
                  if (isFileType && requirement.fileUrl != null)
                    _buildFileActions(requirement, context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardHeader(RequirementModel requirement, bool isFileType) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color:
                isFileType
                    ? kPrimaryColor.withOpacity(0.1)
                    : kSecondaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            isFileType ? Icons.attach_file : Icons.edit_note,
            color: isFileType ? kPrimaryColor : kSecondaryColor,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                requirement.requirementName ?? 'Unnamed Requirement',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 2),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color:
                      isFileType
                          ? kPrimaryColor.withOpacity(0.1)
                          : kSecondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  isFileType ? 'FILE' : 'INPUT',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: isFileType ? kPrimaryColor : kSecondaryColor,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        Icon(Icons.chevron_right, color: Colors.grey[400], size: 20),
      ],
    );
  }

  Widget _buildCardContent(RequirementModel requirement, bool isFileType) {
    if (isFileType) {
      return _buildFileContent(requirement);
    } else {
      return _buildInputContent(requirement);
    }
  }

  Widget _buildFileContent(RequirementModel requirement) {
    final hasFile =
        requirement.fileUrl != null && requirement.fileUrl!.isNotEmpty;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: hasFile ? kPrimaryColor.withOpacity(0.3) : Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            hasFile ? Icons.check_circle : Icons.cloud_upload_outlined,
            color: hasFile ? kPrimaryColor : Colors.grey[500],
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hasFile ? 'File Uploaded' : 'No File Uploaded',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: hasFile ? kPrimaryColor : Colors.grey[600],
                  ),
                ),
                if (hasFile) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Tap to view or download',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputContent(RequirementModel requirement) {
    final hasValue =
        requirement.stringValue != null && requirement.stringValue!.isNotEmpty;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                hasValue ? Icons.check_circle : Icons.edit,
                color: hasValue ? kSecondaryColor : Colors.grey[500],
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                hasValue ? 'Response Provided' : 'No Response Yet',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: hasValue ? kSecondaryColor : Colors.grey[600],
                ),
              ),
            ],
          ),
          if (hasValue) ...[
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[200]!, width: 1),
              ),
              child: Text(
                requirement.stringValue!,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFileActions(RequirementModel requirement, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => _viewFile(requirement, context),
              icon: const Icon(Icons.visibility, size: 18),
              label: const Text('View'),
              style: OutlinedButton.styleFrom(
                foregroundColor: kPrimaryColor,
                side: BorderSide(color: kPrimaryColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleRequirementTap(
    RequirementModel requirement,
    BuildContext context,
  ) {
    // Handle requirement tap - show details or edit
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildRequirementDetails(requirement, context),
    );
  }

  Widget _buildRequirementDetails(
    RequirementModel requirement,
    BuildContext context,
  ) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Requirement Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kSecondaryColor,
              ),
            ),
            const SizedBox(height: 16),
            _buildDetailRow('Name', requirement.requirementName ?? 'N/A'),
            _buildDetailRow(
              'Type',
              requirement.requirementType?.toUpperCase() ?? 'N/A',
            ),
            _buildDetailRow('ID', requirement.id ?? 'N/A'),
            if (requirement.requirementType == 'input')
              _buildDetailRow(
                'Value',
                requirement.stringValue ?? 'No response provided',
              ),
            if (requirement.requirementType == 'file')
              _buildDetailRow(
                'File Status',
                requirement.fileUrl != null ? 'Uploaded' : 'Not uploaded',
              ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  void _viewFile(RequirementModel requirement, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageView(imageUrl: requirement.fileUrl!),
      ),
    );
  }
}
