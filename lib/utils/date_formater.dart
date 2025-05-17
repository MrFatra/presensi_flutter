import 'package:intl/intl.dart';

String formatTanggal(String? dateString) {
  if (dateString == null) return "-";
  final date = DateTime.tryParse(dateString);
  if (date == null) return "-";
  final hariList = ["Minggu", "Senin", "Selasa", "Rabu", "Kamis", "Jumat", "Sabtu"];
  final bulanList = [
    "Januari", "Februari", "Maret", "April", "Mei", "Juni",
    "Juli", "Agustus", "September", "Oktober", "November", "Desember"
  ];
  final hari = hariList[date.weekday % 7];
  final bulan = bulanList[date.month - 1];
  return "$hari, ${date.day} $bulan ${date.year}";
}

String convertDateToYMD(String dateStr) {
  final inputFormat = DateFormat('dd-MM-yyyy');
  final outputFormat = DateFormat('yyyy-MM-dd');
  final date = inputFormat.parse(dateStr);
  return outputFormat.format(date);
}

String formatDateForDisplay(String dateStr) {
  final inputFormat = DateFormat('yyyy-MM-dd');
  final outputFormat = DateFormat('dd-MM-yyyy');
  final date = inputFormat.parse(dateStr);
  return outputFormat.format(date);
}