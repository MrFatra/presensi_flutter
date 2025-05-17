import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:presensi_flutter_test/models/student_profile_request.dart';
import 'package:presensi_flutter_test/services/profile/update_profile.dart';
import 'package:presensi_flutter_test/utils/date_formater.dart';
import 'package:presensi_flutter_test/widgets/bottom_navbar.dart';
import 'package:presensi_flutter_test/widgets/header_card.dart';
import 'package:presensi_flutter_test/widgets/profil_widget.dart';

class EditProfileSiswaPage extends StatefulWidget {
  final String fullName;
  final String phoneNumber;
  final String birthPlace;
  final String birthDate;
  final String photo;

  const EditProfileSiswaPage({
    required this.fullName,
    required this.phoneNumber,
    required this.birthPlace,
    required this.birthDate,
    required this.photo,
    super.key,
  });

  @override
  State<EditProfileSiswaPage> createState() => _EditProfileSiswaPageState();
}

class _EditProfileSiswaPageState extends State<EditProfileSiswaPage> {
  TextEditingController fullnameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController birthPlaceController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  File? photo;
  bool _isLoading = false;

  Future<void> submitProfile() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final data = StudentProfileRequest(
        fullName: fullnameController.text,
        birthDate: convertDateToYMD(birthDateController.text),
        birthPlace: birthPlaceController.text,
        parentPhoneCell: phoneNumberController.text,
        password:
            passwordController.text.isNotEmpty ? passwordController.text : null,
        photo: photo,
      );

      final response = await updateProfile(data);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response)),
      );

      print('Nama: ${fullnameController.text}');
      print('Phone: ${phoneNumberController.text}');
      print('Tempat Lahir: ${birthPlaceController.text}');
      print('Tanggal Lahir: ${birthDateController.text}');
      print('Password: ${passwordController.text}');
      print('Photo: ${photo?.path}');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memperbarui profil. Coba lagi.')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      fullnameController.text = widget.fullName;
      phoneNumberController.text = widget.phoneNumber;
      birthPlaceController.text = widget.birthPlace;
      birthDateController.text = formatDateForDisplay(widget.birthDate);
    });
  }

  Future<void> pickImage({required ImageSource source}) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        photo = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavbar(currentIndex: 4),
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.30,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
              ),
            ),
            SafeArea(
                child: Column(
              children: [
                ProfileHeader(),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        HeaderCard(title: 'EDIT PROFILE'),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: ListView(
                              children: [
                                _buildLabel('Nama'),
                                _buildField(
                                  controller: fullnameController,
                                ),
                                _buildLabel('Nomor Hp Orang Tua'),
                                _buildField(
                                  controller: phoneNumberController,
                                ),
                                _buildLabel('Tempat Lahir'),
                                _buildField(
                                  controller: birthPlaceController,
                                  hintText: 'Jakarta',
                                ),
                                _buildLabel('Tanggal Lahir'),
                                _buildField(
                                  controller: birthDateController,
                                  hintText: '02-01-2004',
                                ),
                                _buildLabel('Pasword Baru'),
                                _buildField(
                                  controller: passwordController,
                                ),
                                _buildLabel('Foto Profile'),
                                _buildFilePickerButton(),
                                const SizedBox(height: 24),
                                ElevatedButton(
                                  onPressed: _isLoading ? null : submitProfile,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF4169E1),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  child: _isLoading
                                      ? const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2.5,
                                          ),
                                        )
                                      : const Text(
                                          'Simpan',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ))
          ],
        ));
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 6.0),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildField({
    String? hintText,
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey[300],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
    );
  }

  Widget _buildFilePickerButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 48,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black45),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  onPressed: () => pickImage(source: ImageSource.gallery),
                  icon: const Icon(Icons.image_outlined),
                  label: const Text("Galeri"),
                ),
              ),
              const VerticalDivider(width: 1),
              Expanded(
                child: TextButton.icon(
                  onPressed: () => pickImage(source: ImageSource.camera),
                  icon: const Icon(Icons.camera_alt_outlined),
                  label: const Text("Kamera"),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          photo != null
              ? 'File: ${photo!.path.split("/").last}'
              : 'Belum memilih gambar',
          style: const TextStyle(
              color: Colors.black54, fontStyle: FontStyle.italic),
        ),
      ],
    );
  }
}
