import 'package:flutter/material.dart';
import 'package:presensi_flutter_test/services/books/get_books.dart';
import 'package:presensi_flutter_test/widgets/books/books_history.dart';
import 'package:presensi_flutter_test/widgets/books/search_bar.dart';
import 'package:presensi_flutter_test/widgets/bottom_navbar.dart';
import 'package:presensi_flutter_test/widgets/header_card.dart';
import 'package:presensi_flutter_test/widgets/profil_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RiwayatPeminjamanBukuPage extends StatefulWidget {
  const RiwayatPeminjamanBukuPage({super.key});

  @override
  State<RiwayatPeminjamanBukuPage> createState() => _RiwayatPeminjamanBukuPageState();
}

class _RiwayatPeminjamanBukuPageState extends State<RiwayatPeminjamanBukuPage> {
  List<dynamic> riwayatBuku = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token != null) {
      try {
        final books = await getBooks(token);
        setState(() {
          riwayatBuku = books;
          isLoading = false;
        });
      } catch (_) {
        setState(() => isLoading = false);
      }
    } else {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavbar(currentIndex: 0),
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
                const ProfileHeader(),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        const HeaderCard(title: "Riwayat Peminjaman Buku"),
                        const BookSearchBar(),
                        const SizedBox(height: 10),
                        Expanded(
                          child: BookHistoryGrid(
                            books: riwayatBuku,
                            isLoading: isLoading,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
