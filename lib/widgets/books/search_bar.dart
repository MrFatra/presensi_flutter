import 'package:flutter/material.dart';

class BookSearchBar extends StatelessWidget {
  const BookSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Cari',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
        ),
        // Tambahkan onChanged jika ingin fungsionalitas filter
      ),
    );
  }
}
