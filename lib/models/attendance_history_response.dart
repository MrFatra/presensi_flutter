class AttendanceHistoryResponse {
  final bool success;
  final String message;
  final List<AttendanceData> data;

  AttendanceHistoryResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AttendanceHistoryResponse.fromJson(Map<String, dynamic> json) {
    return AttendanceHistoryResponse(
      success: json['success'],
      message: json['message'],
      data: (json['data'] as List)
          .map((item) => AttendanceData.fromJson(item))
          .toList(),
    );
  }
}

class AttendanceData {
  final int id;
  final String idStudent;
  final int classId;
  final int subjectId;
  final String attendanceDate;
  final String attendanceTime;
  final String checkInTime;
  final String? checkOutTime;
  final int statusId;
  final String latitude;
  final String longitude;
  final String createdAt;
  final String updatedAt;
  final int academicYearId;
  final int semesterId;
  final String? document;

  AttendanceData({
    required this.id,
    required this.idStudent,
    required this.classId,
    required this.subjectId,
    required this.attendanceDate,
    required this.attendanceTime,
    required this.checkInTime,
    this.checkOutTime,
    required this.statusId,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    required this.updatedAt,
    required this.academicYearId,
    required this.semesterId,
    this.document,
  });

  factory AttendanceData.fromJson(Map<String, dynamic> json) {
    return AttendanceData(
      id: json['id'],
      idStudent: json['id_student'],
      classId: json['class_id'],
      subjectId: json['subject_id'],
      attendanceDate: json['attendance_date'],
      attendanceTime: json['attendance_time'],
      checkInTime: json['check_in_time'],
      checkOutTime: json['check_out_time'],
      statusId: json['status_id'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      academicYearId: json['academic_year_id'],
      semesterId: json['semester_id'],
      document: json['document'],
    );
  }
}
