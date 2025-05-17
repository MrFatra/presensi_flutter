import 'package:flutter/material.dart';
import 'package:presensi_flutter_test/services/rapor/get_rapor.dart';
import 'package:presensi_flutter_test/utils/constant.dart';
import 'package:presensi_flutter_test/widgets/bottom_navbar.dart';
import 'package:presensi_flutter_test/widgets/header_card.dart';
import 'package:presensi_flutter_test/widgets/profil_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class RaporPage extends StatefulWidget {
  const RaporPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RaporPageState createState() => _RaporPageState();
}

class _RaporPageState extends State<RaporPage> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  String selectedData = 'Data Rapor';

  bool isLoading = true;
  List<dynamic> dataRapor = [];
  List<dynamic> dataPrestasi = [];

  Future<void> fetchData() async {
    try {
      final token = '12|lcC3ambWlVbcnJq5tEwcFiN5KEuVgbQHWH6NCUKF02294b5e';
      // ignore: unnecessary_null_comparison
      if (token != null) {
        setState(() {
          isLoading = true;
        });
        if (selectedData == 'Data Rapor') {
          final response = await getRapor(token, 'rapor');
          setState(() {
            dataRapor = response;
            isLoading = false;
          });
                } else if (selectedData == 'Data Prestasi') {
          final response = await getRapor(token, 'acchievement');
          setState(() {
            dataPrestasi = response;
            isLoading = false;
          });
                } else {
          setState(() {
            isLoading = false;
          });
        }
      } else {
        setState(() {
          isLoading = false;
        });
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
      bottomNavigationBar: BottomNavbar(currentIndex: 3),
      body: SafeArea(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                selectedData = 'Data Rapor';
                                fetchData();
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: selectedData == 'Data Rapor'
                                  ? AppColors.info
                                  : Colors.grey,
                            ),
                            child: Center(
                              child: Text('Data Rapor',
                                  style: TextStyle(color: Colors.white)),
                            )),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedData = 'Data Prestasi';
                              fetchData();
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: selectedData == 'Data Prestasi'
                                  ? AppColors.info
                                  : Colors.grey),
                          child: Center(
                            child: Text(
                              'Data Prestasi',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : selectedData == 'Data Rapor'
                              ? (dataRapor.isEmpty ||
                                      dataRapor[0]['academic_year'] == null)
                                  ? const Center(
                                      child: Text(
                                        'Tidak ada data',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    )
                                  : ListView.builder(
                                      itemCount: dataRapor.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            padding: const EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                              color: Colors.blue.shade50,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      // ignore: deprecated_member_use
                                                      .withOpacity(0.2),
                                                  spreadRadius: 1,
                                                  blurRadius: 5,
                                                  offset: const Offset(0, 3),
                                                ),
                                              ],
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        // ignore: prefer_interpolation_to_compose_strings
                                                        '${dataRapor[index]['academic_year'] + ' - ' + dataRapor[index]['semester']}',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Text(
                                                        'Kelas : ${dataRapor[index]['class']}',
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                IconButton(
                                                    icon: const Icon(Icons
                                                        .arrow_forward_ios_rounded),
                                                    onPressed: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            AlertDialog(
                                                          title: Text(
                                                              'Detail Rapor'),
                                                          content: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                  'NIS : ${dataRapor[index]['student_id']}'),
                                                              const SizedBox(
                                                                  height: 8),
                                                              Text(
                                                                  'Nama Siswa : ${dataRapor[index]['student_name']}'),
                                                              const SizedBox(
                                                                  height: 8),
                                                              Text(
                                                                  'Tahun Angkatan : ${dataRapor[index]['academic_year']}'),
                                                              const SizedBox(
                                                                  height: 8),
                                                              Text(
                                                                  'Kelas : ${dataRapor[index]['class']}'),
                                                              const SizedBox(
                                                                  height: 8),
                                                              Text(
                                                                  'Raport Ajaran Tahun : ${dataRapor[index]['report_date']}'),
                                                              const SizedBox(
                                                                  height: 8),
                                                              InkWell(
                                                                onTap:
                                                                    () async {
                                                                  final url = dataRapor[
                                                                          index]
                                                                      [
                                                                      'file_path'];
                                                                  if (url !=
                                                                          null &&
                                                                      url.isNotEmpty) {
                                                                    final uri =
                                                                        Uri.parse(
                                                                            url);
                                                                    if (await canLaunchUrl(
                                                                        uri)) {
                                                                      await launchUrl(
                                                                          uri,
                                                                          mode:
                                                                              LaunchMode.externalApplication);
                                                                    } else {
                                                                      ScaffoldMessenger.of(
                                                                              // ignore: use_build_context_synchronously
                                                                              context)
                                                                          .showSnackBar(
                                                                        SnackBar(
                                                                            content:
                                                                                Text('Tidak dapat membuka file')),
                                                                      );
                                                                    }
                                                                  }
                                                                },
                                                                child: Text(
                                                                  'Unduh File Tahun : Klik Disini}',
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .blue,
                                                                    decoration:
                                                                        TextDecoration
                                                                            .underline,
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 8),
                                                              Text(
                                                                  'Deskripsi : ${dataRapor[index]['description']}'),
                                                            ],
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              child: const Text(
                                                                  'Tutup'),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    }),
                                              ],
                                            ));
                                      },
                                    )
                              : dataPrestasi.isEmpty
                                  ? const Center(
                                      child: Text(
                                        'Tidak ada data',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    )
                                  : ListView.builder(
                                      itemCount: dataPrestasi.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            padding: const EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                              color: Colors.blue.shade50,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      // ignore: deprecated_member_use
                                                      .withOpacity(0.2),
                                                  spreadRadius: 1,
                                                  blurRadius: 5,
                                                  offset: const Offset(0, 3),
                                                ),
                                              ],
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Prestasi : ${dataPrestasi[index]['subject']}',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Text(
                                                        'Peringkat : ${dataPrestasi[index]['student_rank']}',
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                IconButton(
                                                    icon: const Icon(Icons
                                                        .arrow_forward_ios_rounded),
                                                    onPressed: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            AlertDialog(
                                                          title: Text(
                                                              'Detail Prestasi'),
                                                          content: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                  'NIS : ${dataPrestasi[index]['student_id']}'),
                                                              const SizedBox(
                                                                  height: 8),
                                                              Text(
                                                                  'Nama Siswa : ${dataPrestasi[index]['student_name']}'),
                                                              const SizedBox(
                                                                  height: 8),
                                                              Text(
                                                                  'Prestasi : ${dataPrestasi[index]['subject']}'),
                                                              const SizedBox(
                                                                  height: 8),
                                                              Text(
                                                                  'Nilai : ${dataPrestasi[index]['score']}'),
                                                              const SizedBox(
                                                                  height: 8),
                                                              Text(
                                                                  'Semester : ${dataPrestasi[index]['semester']}'),
                                                              const SizedBox(
                                                                  height: 8),
                                                              Text(
                                                                  'Rank : ${dataPrestasi[index]['student_rank']}'),
                                                              const SizedBox(
                                                                  height: 8),
                                                              Text(
                                                                  'Catatan : ${dataPrestasi[index]['remark']}'),

                                                            ]
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              child: const Text(
                                                                  'Tutup'),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    }),
                                              ],
                                            ));
                                      },
                                    ),
                    )
                  ],
                )),
          ),
        ],
      )),
    );
  }
}
