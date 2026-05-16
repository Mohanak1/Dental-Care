const List<String> _weekdays = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday',
];

const List<String> _shortWeekdays = [
  'Mon',
  'Tue',
  'Wed',
  'Thu',
  'Fri',
  'Sat',
  'Sun',
];

const List<String> _months = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];

const List<String> _shortMonths = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

String weekdayName(DateTime date) {
  return _weekdays[date.weekday - 1];
}

String shortWeekdayName(DateTime date) {
  return _shortWeekdays[date.weekday - 1];
}

String monthName(DateTime date) {
  return _months[date.month - 1];
}

String compactDate(DateTime date) {
  return '${shortWeekdayName(date)}, ${_shortMonths[date.month - 1]} ${date.day}';
}

String fullDate(DateTime date) {
  return '${weekdayName(date)}, ${monthName(date)} ${date.day}, ${date.year}';
}

String createdDate(DateTime date) {
  return '${_shortMonths[date.month - 1]} ${date.day}, ${date.year}';
}
