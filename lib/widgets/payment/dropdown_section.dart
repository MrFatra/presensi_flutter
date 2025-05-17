import 'package:flutter/material.dart';

class DropdownSection extends StatelessWidget {
  final String selectedBulan;
  final String selectedTahun;
  final List<String> bulanList;
  final List<String> tahunList;
  final Function(String) onBulanChanged;
  final Function(String) onTahunChanged;

  const DropdownSection({
    super.key,
    required this.selectedBulan,
    required this.selectedTahun,
    required this.bulanList,
    required this.tahunList,
    required this.onBulanChanged,
    required this.onTahunChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<String>(
              value: selectedBulan,
              items: bulanList.map((bulan) => DropdownMenuItem(value: bulan, child: Text(bulan))).toList(),
              onChanged: (val) => onBulanChanged(val!),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: DropdownButtonFormField<String>(
              value: selectedTahun,
              items: tahunList.map((tahun) => DropdownMenuItem(value: tahun, child: Text(tahun))).toList(),
              onChanged: (val) => onTahunChanged(val!),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            ),
            child: const Icon(Icons.search, size: 20),
          ),
        ],
      ),
    );
  }
}
