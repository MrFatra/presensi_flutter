import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class FormPermission extends StatefulWidget {
  const FormPermission({super.key});

  @override
  State<FormPermission> createState() => _FormPermissionState();
}

class _FormPermissionState extends State<FormPermission> {
  final TextEditingController _keterangan1 = TextEditingController();
  final TextEditingController _keterangan2 = TextEditingController();

  String hari = '';
  String tanggal = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLocaleData();
  }

  Future<void> _loadLocaleData() async {
    await initializeDateFormatting('id_ID', null);
    final now = DateTime.now();

    setState(() {
      hari = DateFormat('EEEE', 'id_ID').format(now); // Kamis
      tanggal = DateFormat('d', 'id_ID').format(now); // 15
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                const Text('ABSENSI HARI INI', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                const Text(
                  'IZIN',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.amber),
                ),
                const Divider(),
                const SizedBox(height: 4),
                Text('$hari, $tanggal', style: const TextStyle(fontSize: 16)),
                const Text(
                  'SILAHKAN MENGISI DATA DIBAWAH INI',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildTextField(_keterangan1, 'Silahkan Isi Keterangan'),
          const SizedBox(height: 12),
          _buildTextField(_keterangan2, 'Silahkan Isi Keterangan'),
          const SizedBox(height: 12),
          const Text('Upload Gambar'),
          const SizedBox(height: 6),
          ElevatedButton(
            onPressed: () {
              // TODO: File picker logic
            },
            child: const Text('Choose File'),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
              onPressed: () {
                // TODO: Submit form logic
              },
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
