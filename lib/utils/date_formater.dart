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
