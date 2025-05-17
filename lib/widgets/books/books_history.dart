import 'package:flutter/material.dart';
import 'book_history_card.dart';

class BookHistoryGrid extends StatelessWidget {
  final List<dynamic> books;
  final bool isLoading;

  const BookHistoryGrid({super.key, required this.books, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (books.isEmpty) {
      return const Center(child: Text('Belum ada riwayat peminjaman.'));
    }

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        childAspectRatio: 3 / 2,
      ),
      itemCount: books.length,
      itemBuilder: (context, index) {
        return BookHistoryCard(data: books[index]);
      },
    );
  }
}
