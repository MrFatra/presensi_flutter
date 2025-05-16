import 'package:flutter/material.dart';
import 'package:presensi_flutter_test/services/books/get_books.dart';
import 'package:presensi_flutter_test/utils/token.dart';
import 'package:presensi_flutter_test/widgets/bottom_navbar.dart';
import 'package:presensi_flutter_test/widgets/header_card.dart';
import 'package:presensi_flutter_test/widgets/profil_widget.dart';
import 'package:intl/intl.dart';

class RiwayatPeminjamanBukuPage extends StatefulWidget {
  const RiwayatPeminjamanBukuPage({super.key});

  @override
  State<RiwayatPeminjamanBukuPage> createState() =>
      _RiwayatPeminjamanBukuPageState();
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
    try {
      final token = '6|6PSOX2et2xixdxFSAJT72JLO0OYA4FXTJf1QHOaQ9dbaf445';
      if (token != null) {
        final books = await getBooks(token);
        setState(() {
          riwayatBuku = books;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        // Handle token null if needed
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade600,
      bottomNavigationBar: BottomNavbar(currentIndex: 0),
      body: SafeArea(
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
                    // Title
                  HeaderCard(title: "Riwayat Peminjaman Buku"),

                    // Search Bar (opsional, belum aktif)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Cari',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 0),
                        ),
                        // onChanged: (value) => filter logic if needed
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Grid View
                    Expanded(
                      child: isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : riwayatBuku.isEmpty
                              ? const Center(
                                  child: Text('Belum ada riwayat peminjaman.'),
                                )
                              : GridView.builder(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 5,
                                    childAspectRatio: 3 / 2,
                                  ),
                                  itemCount: riwayatBuku.length,
                                  itemBuilder: (context, index) {
                                    final data = riwayatBuku[index];
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2, horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.blue.shade50,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const SizedBox(height: 4),
                                              Text(
                                                data['book'],
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                'Pinjam: ${DateFormat.yMMMMd('id-ID').format(DateTime.parse(data['loan_date']))}',
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                              Text(
                                                'Kembali: ${data['return_date'] != null ? DateFormat.yMMMMd('id').format(DateTime.parse(data['return_date'])) : 'Belum'}',
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                              Text(
                                                'Status: ${data['status']}',
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
