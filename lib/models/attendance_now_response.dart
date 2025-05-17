class AttendanceNowResponse {
  final int? attendanceId;
  final String? checkInTime;
  final String? checkOutTime;
  final String? status;

  AttendanceNowResponse({
    required this.attendanceId,
    required this.checkInTime,
    required this.checkOutTime,
    required this.status,
  });

  factory AttendanceNowResponse.fromJson(Map<String, dynamic> json) {
    return AttendanceNowResponse(
      attendanceId: json['attendance_id'],
      checkInTime: json['check_in_time'],
      checkOutTime: json['check_out_time'],
      status: json['status'],
    );
  }
}
