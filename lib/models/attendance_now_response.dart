class AttendanceNowResponse {
  final DateTime? checkInTime;
  final DateTime? checkOutTime;
  final String? status;

  AttendanceNowResponse({
    required this.checkInTime,
    required this.checkOutTime,
    required this.status,
  });

  factory AttendanceNowResponse.fromJson(Map<String, dynamic> json) {
    return AttendanceNowResponse(
      checkInTime: json['check_in_time'] != null
          ? DateTime.parse(json['check_in_time'])
          : null,
      checkOutTime: json['check_out_time'] != null
          ? DateTime.parse(json['check_out_time'])
          : null,
      status: json['status'],
    );
  }
}
