import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RaporList extends StatelessWidget {
  final List<dynamic> data;

  const RaporList(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty || data[0]['academic_year'] == null) {
      return const Center(child: Text('Tidak ada data', style: TextStyle(fontSize: 16)));
    }

    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        return Card(
          color: Colors.blue.shade50,
          margin: const EdgeInsets.only(bottom: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            title: Text(
              '${item['academic_year']} - ${item['semester']}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Kelas : ${item['class']}'),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: () => showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Detail Rapor'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('NIS : ${item['student_id']}'),
                    Text('Nama Siswa : ${item['student_name']}'),
                    Text('Tahun Angkatan : ${item['academic_year']}'),
                    Text('Kelas : ${item['class']}'),
                    Text('Raport Ajaran Tahun : ${item['report_date']}'),
                    GestureDetector(
                      onTap: () async {
                        final url = 'http://10.0.2.2:8000/public${item['file_path']}';
                        if (url != null && url.isNotEmpty) {
                          final uri = Uri.parse(url);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri, mode: LaunchMode.externalApplication);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Tidak dapat membuka file')),
                            );
                          }
                        }
                      },
                      child: const Text(
                        'Unduh File Tahun : Klik Disini',
                        style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                      ),
                    ),
                    Text('Deskripsi : ${item['description']}'),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Tutup'),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
