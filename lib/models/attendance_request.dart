class AttendanceRequest {
  final int? attendanceId;
  final double? latitude;
  final double? longitude;
  final int? statusId;

  AttendanceRequest({
    this.attendanceId,
    this.latitude,
    this.longitude,
    this.statusId,
  });

  Map<String, dynamic> toJson() => {
        'attendance_id': attendanceId,
        'status_id': statusId,
        'latitude': latitude,
        'longitude': longitude,
      };
}
