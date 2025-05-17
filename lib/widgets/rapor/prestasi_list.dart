import 'package:flutter/material.dart';

class PrestasiList extends StatelessWidget {
  final List<dynamic> data;

  const PrestasiList(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
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
              'Prestasi : ${item['subject']}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Peringkat : ${item['student_rank']}'),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: () => showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Detail Prestasi'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('NIS : ${item['student_id']}'),
                    Text('Nama Siswa : ${item['student_name']}'),
                    Text('Prestasi : ${item['subject']}'),
                    Text('Nilai : ${item['score']}'),
                    Text('Semester : ${item['semester']}'),
                    Text('Rank : ${item['student_rank']}'),
                    Text('Catatan : ${item['remark']}'),
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
