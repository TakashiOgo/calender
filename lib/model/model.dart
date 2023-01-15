class Schedule {
  int? id;
  final String title;
  bool fullTime;
  DateTime? startTime;
  DateTime? finishedTime;
  final String comment;

  Schedule({
    this.id,
    required this.title,
    required this.fullTime,
    this.startTime,
    this.finishedTime,
    required this.comment,
  });
}