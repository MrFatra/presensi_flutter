import 'package:flutter/material.dart';
import 'package:presensi_flutter_test/services/rapor/get_rapor.dart';
import 'package:presensi_flutter_test/utils/constant.dart';
import 'package:presensi_flutter_test/widgets/bottom_navbar.dart';
import 'package:presensi_flutter_test/widgets/header_card.dart';
import 'package:presensi_flutter_test/widgets/profil_widget.dart';
import 'package:presensi_flutter_test/widgets/rapor/prestasi_list.dart';
import 'package:presensi_flutter_test/widgets/rapor/rapor_list.dart';
import 'package:presensi_flutter_test/widgets/rapor/rapor_toglge.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RaporPage extends StatefulWidget {
  const RaporPage({super.key});

  @override
  _RaporPageState createState() => _RaporPageState();
}

class _RaporPageState extends State<RaporPage> {
  String selectedData = 'Data Rapor';
  bool isLoading = true;
  List<dynamic> dataRapor = [];
  List<dynamic> dataPrestasi = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if (token != null) {
        setState(() => isLoading = true);
        if (selectedData == 'Data Rapor') {
          dataRapor = await getRapor(token, 'rapor');
        } else {
          dataPrestasi = await getRapor(token, 'acchievement');
        }
      }
    } catch (_) {}
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavbar(currentIndex: 3),
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
                  ProfileHeader(),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          HeaderCard(title: 'Data Rapor Dan Prestasi'),
                          RaporToggle(
                            selectedData: selectedData,
                            onTap: (val) {
                              setState(() => selectedData = val);
                              fetchData();
                            },
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child: isLoading
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : selectedData == 'Data Rapor'
                                    ? RaporList(dataRapor)
                                    : PrestasiList(dataPrestasi),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
