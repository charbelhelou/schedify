class Utils {}

extension DurationExtension on Duration {
  String getOnlyHours({bool? padding = true}) {
    String hours = inHours.toString();
    if (padding == true) {
      hours.padLeft(2, '0');
    }
    return hours;
  }

  String getOnlyMinutes({bool? padding = true}) {
    String minutes = (inMinutes.remainder(60)).toString();
    if (padding == true) {
      minutes = minutes.padLeft(2, '0');
    }
    return minutes;
  }

  String getOnlySeconds({bool? padding = true}) {
    String seconds = (inSeconds.remainder(60)).toString();
    if (padding == true) {
      seconds = seconds.padLeft(2, '0');
    }
    return seconds;
  }
}
