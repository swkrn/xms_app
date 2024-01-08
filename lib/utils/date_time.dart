bool isToday(DateTime time) {
  final now = DateTime.now();
  return
    now.year == time.year &&
    now.month == time.month &&
    now.day == time.day;
}