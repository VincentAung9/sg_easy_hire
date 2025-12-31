import 'dart:io';
import 'package:amplify_api/amplify_api.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:sg_easy_hire/core/repository/storage_repository.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';
import 'package:sg_easy_hire/features/helper_core/domain/helper_core_bloc.dart';
import 'package:sg_easy_hire/models/User.dart';
import 'package:shimmer/shimmer.dart';

class HelperProfileUpdate extends StatefulWidget {
  const HelperProfileUpdate({super.key});

  @override
  State<HelperProfileUpdate> createState() => _HelperProfileUpdateState();
}

class _HelperProfileUpdateState extends State<HelperProfileUpdate>
    with SingleTickerProviderStateMixin {
  bool _isLoading = true;
  bool _isUploading = false;
  User? user;
  late AnimationController _animationController;

  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _profileController;

  PlatformFile? _selectedImageFile;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _profileController = TextEditingController();
    final info = context.read<HelperCoreBloc>().state.currentUser;
    if (!mounted) return;
    setState(() {
      _isLoading = false;
      user = info;
      _nameController.text = info?.fullName ?? "";
      _phoneController.text = info?.phone ?? "";
      _profileController.text = info?.avatarURL ?? "";
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _profileController.dispose();
    super.dispose();
  }

  Future<void> _updateUserProfile() async {
    if (user == null) return;

    setState(() => _isLoading = true);

    try {
      String? updatedProfileUrl = user?.avatarURL;

      if (_selectedImageFile != null) {
        setState(() => _isUploading = true);
        updatedProfileUrl = await StorageRepository.uploadFile(
          _selectedImageFile!,
          "public/users/${user?.id}",
          (_) => {},
          (_) => {},
        );
        setState(() => _isUploading = false);
      }

      final newUser = user?.copyWith(
        fullName: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
        avatarURL: updatedProfileUrl ?? _profileController.text.trim(),
      );

      final request = ModelMutations.update(newUser!);
      final response = await Amplify.API.mutate(request: request).response;

      final updatedData = response.data;
      if (!mounted) return;
      setState(() {
        user = updatedData;
        _isLoading = false;
        _selectedImageFile = null;
        _profileController.text = updatedData?.avatarURL ?? "";
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );
    } catch (e) {
      safePrint('Error updating profile: $e');
      setState(() {
        _isLoading = false;
        _isUploading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Profile update failed: $e')));
    }
  }

  /* Future<String?> _uploadProfileImage(File imageFile, String email) async {
    try {
      final fileName = '$email-${DateTime.now().millisecondsSinceEpoch}.jpg';
      final path = StoragePath.fromString('public/profile_images/$fileName');

      final result = await Amplify.Storage.uploadFile(
        localFile: AWSFile.fromPath(imageFile.path),
        path: path,
        onProgress: (progress) {
          final percent =
              (progress.transferredBytes / progress.totalBytes * 100)
                  .toStringAsFixed(1);
          safePrint('Uploading: $percent%');
        },
      ).result;

      const bucket =
          'easyhiree38c9a7bcba84015aca20479aaf1078f68a36-dev'; // your S3 bucket
      const region = 'ap-southeast-1'; // your AWS region
      final url =
          'https://$bucket.s3.$region.amazonaws.com/public/profile_images/$fileName';

      safePrint("🔥 Manual URL: $url");
      safePrint("🔥 Return URL: ${result.uploadedItem.path}");
      return url;
    } catch (e) {
      safePrint('❌ Upload failed: $e');
      return null;
    }
  }
 */
  Future<void> _pickImage() async {
    try {
      final picked = await StorageRepository.pickFile(
        allowedExtensions: ["jpg", "png", "jpeg"],
      );
      if (picked != null && picked.isNotEmpty) {
        setState(() {
          _selectedImageFile = picked.first;
          user = user?.copyWith(avatarURL: _selectedImageFile!.path);
        });
      }
    } catch (e) {
      safePrint('Error picking image: $e');
    }
  }

  Widget _buildEditableField(
    String label,
    TextEditingController controller, {
    bool readOnly = false,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          filled: readOnly,
          fillColor: readOnly ? Colors.grey[100] : null,
          suffixIcon: readOnly
              ? const Icon(Icons.lock_outline, size: 18)
              : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final profileImageUrl = _selectedImageFile != null
        ? null
        : (user?.avatarURL ?? '');

    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: _isLoading
          ? const ProfileShimmer()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey.shade300,
                            child: _isUploading
                                ? const CupertinoActivityIndicator(radius: 20)
                                : (_selectedImageFile != null
                                      ? ClipOval(
                                          child: Image.file(
                                            File(_selectedImageFile!.path!),
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : (profileImageUrl != null &&
                                                profileImageUrl.isNotEmpty
                                            ? CachedNetworkImage(
                                                imageUrl: profileImageUrl,
                                                imageBuilder:
                                                    (
                                                      context,
                                                      imageProvider,
                                                    ) => Container(
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                placeholder: (context, url) =>
                                                    const CupertinoActivityIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(
                                                          Icons.person,
                                                          size: 50,
                                                          color: Colors.grey,
                                                        ),
                                              )
                                            : const Icon(
                                                Icons.person,
                                                size: 50,
                                                color: Colors.grey,
                                              ))),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: GestureDetector(
                              onTap: _pickImage,
                              child: const CircleAvatar(
                                radius: 15,
                                backgroundColor: AppColors.primary,
                                child: Icon(
                                  Icons.edit,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _nameController.text.isNotEmpty
                                  ? _nameController.text
                                  : 'No Name Set',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),

                            Text(
                              _phoneController.text.isNotEmpty
                                  ? _phoneController.text
                                  : 'No Phone Set',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  _buildEditableField("Full Name", _nameController),

                  _buildEditableField(
                    "Phone Number",
                    _phoneController,
                    keyboardType: TextInputType.phone,
                  ),

                  _buildEditableField("Avatar", _profileController),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 15,
                        ),
                      ),

                      onPressed: _isLoading || _isUploading
                          ? null
                          : _updateUserProfile,
                      child: Text(
                        "Update",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
    );
  }
}

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: double.infinity,
                        height: 20,
                        color: Colors.white,
                        margin: const EdgeInsets.only(bottom: 10),
                      ),
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: 150,
                        height: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          // Simulate cards
          ...List.generate(
            2,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ),
          // Simulate more text fields
          ...List.generate(
            3,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: double.infinity,
                  height: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
