import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:presensi_flutter_test/services/attendance/submit_attendance.dart';
import 'package:presensi_flutter_test/views/home_page.dart';

class FormPermission extends StatefulWidget {
  const FormPermission({super.key});

  @override
  State<FormPermission> createState() => _FormPermissionState();
}

class _FormPermissionState extends State<FormPermission> {
  final TextEditingController _keterangan = TextEditingController();
  bool isLoading = true;
  File? selectedFile;

  Future<void> pickFile() async {
    final picker = ImagePicker();
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        selectedFile = File(pickedFile.path);
      });
    }
  }

  void handlePermission() async {
    try {
      if (selectedFile != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Harap tunggu...')),
        );
        final response = await permissionAttendance(selectedFile!);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response)),
        );
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tidak ada file yang dipilih')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                const Text('ABSENSI HARI INI',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                const Text(
                  'IZIN',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber),
                ),
                const Divider(),
                const SizedBox(height: 4),
                Text(DateFormat('EEEE, dd MMMM yyyy', 'id_ID')
                    .format(DateTime.now())),
                const Text(
                  'SILAHKAN MENGISI DATA DIBAWAH INI',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildTextField(_keterangan, 'Silahkan Isi Keterangan'),
          const SizedBox(height: 12),
          const Text('Upload Gambar'),
          const SizedBox(height: 6),
          ElevatedButton(
            onPressed: pickFile,
            child: const Text('Choose File'),
          ),
          const Spacer(),
          if (selectedFile != null)
            Text(
              'File dipilih: ${selectedFile!.path.split('/').last}',
              style: TextStyle(fontSize: 12, color: Colors.green),
            ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14)),
              onPressed: handlePermission,
              child: const Text('Kirim'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
