import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookHistoryCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const BookHistoryCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 4),
          Text(
            data['book'],
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            'Pinjam: ${DateFormat.yMMMMd('id-ID').format(DateTime.parse(data['loan_date']))}',
            style: const TextStyle(fontSize: 12),
          ),
          Text(
            'Kembali: ${data['return_date'] != null ? DateFormat.yMMMMd('id').format(DateTime.parse(data['return_date'])) : 'Belum'}',
            style: const TextStyle(fontSize: 12),
          ),
          Text(
            'Status: ${data['status']}',
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
