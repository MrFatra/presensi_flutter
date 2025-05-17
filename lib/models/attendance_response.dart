class AttendanceResponse {
  final String message;
  final String? distance;
  final AttendanceData? data;

  AttendanceResponse({
    required this.message,
    this.distance,
    this.data,
  });

  factory AttendanceResponse.fromJson(Map<String, dynamic> json) {
    return AttendanceResponse(
      message: json['message'],
      distance: json['distance_m'],
      data: json['data'] != null ? AttendanceData.fromJson(json['data']) : null,
    );
  }
}

class AttendanceData {
  final int id;
  final String idStudent;
  final int classId;
  final String attendanceDate;
  final String attendanceTime;
  final String? checkInTime;
  final String? checkOutTime;
  final int statusId;
  final double? latitude;
  final double? longitude;
  final int academicYearId;
  final int semesterId;
  final String? document;
  final String createdAt;
  final String updatedAt;

  AttendanceData({
    required this.id,
    required this.idStudent,
    required this.classId,
    required this.attendanceDate,
    required this.attendanceTime,
    this.checkInTime,
    this.checkOutTime,
    required this.statusId,
    this.latitude,
    this.longitude,
    required this.academicYearId,
    required this.semesterId,
    this.document,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AttendanceData.fromJson(Map<String, dynamic> json) {
    return AttendanceData(
      id: json['id'],
      idStudent: json['id_student'],
      classId: json['class_id'],
      attendanceDate: json['attendance_date'],
      attendanceTime: json['attendance_time'],
      checkInTime: json['check_in_time'],
      checkOutTime: json['check_out_time'],
      statusId: json['status_id'],
      latitude: json['latitude'] is String
          ? double.tryParse(json['latitude'])
          : json['latitude'] as double,
      longitude: json['longitude'] is String
          ? double.tryParse(json['longitude'])
          : json['longitude'] as double,
      academicYearId: json['academic_year_id'],
      semesterId: json['semester_id'],
      document: json['document'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
