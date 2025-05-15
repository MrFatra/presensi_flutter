class BooksResponseModel {
  final String book;
  final DateTime loan_date;
  final DateTime due_date;
  final DateTime return_date;
  final String status;
  final String academic_year;
  final String semester_name;

  BooksResponseModel({
    required this.book,
    required this.loan_date,
    required this.due_date,
    required this.return_date,
    required this.status,
    required this.academic_year,
    required this.semester_name
  });

  factory BooksResponseModel.fromJson(Map<String, dynamic> json) => BooksResponseModel(
    book: json['book'],
    loan_date: json['loan_date'],
    due_date:  json['due_date'],
    return_date: json['return_date'],
    status: json['status'],
    academic_year: json['academic_year'],
    semester_name: json['semester'],
  );

  Map<String, dynamic> toJson() => {
    'book': book,
    'loan_date' : loan_date,
    'due_date': due_date,
    'return_date': return_date,
    'status': status,
    'academic_year': academic_year,
    'semeter_name': semester_name
  };
}