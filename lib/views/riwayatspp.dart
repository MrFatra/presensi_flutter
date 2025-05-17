import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:presensi_flutter_test/services/history_payment/history_payment.dart';
import 'package:presensi_flutter_test/widgets/bottom_navbar.dart';
import 'package:presensi_flutter_test/widgets/header_card.dart';
import 'package:presensi_flutter_test/widgets/payment/dropdown_section.dart';
import 'package:presensi_flutter_test/widgets/payment/riwayat_list.dart';
import 'package:presensi_flutter_test/widgets/profil_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RiwayatSPPPage extends StatefulWidget {
  const RiwayatSPPPage({super.key});

  @override
  State<RiwayatSPPPage> createState() => _RiwayatSPPPageState();
}

class _RiwayatSPPPageState extends State<RiwayatSPPPage> {
  String selectedBulan = 'Januari';
  String selectedTahun = '2025';
  bool isLoading = true;
  List<String> bulanList = [
    'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
    'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
  ];
  List<String> tahunList = ['2023', '2024', '2025'];
  List<dynamic> riwayatSPP = [];

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id', null).then((_) => fetchData());
  }

  Future<void> fetchData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if (token != null) {
        final history = await getHistoryPayment(token);
        setState(() {
          riwayatSPP = history;
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
      }
    } catch (_) {
      setState(() {
        riwayatSPP = [];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavbar(currentIndex: 1),
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
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        const HeaderCard(title: "Riwayat Pembayaran SPP"),
                        DropdownSection(
                          selectedBulan: selectedBulan,
                          selectedTahun: selectedTahun,
                          bulanList: bulanList,
                          tahunList: tahunList,
                          onBulanChanged: (val) => setState(() => selectedBulan = val),
                          onTahunChanged: (val) => setState(() => selectedTahun = val),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: RiwayatList(
                            isLoading: isLoading,
                            riwayatSPP: riwayatSPP,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}