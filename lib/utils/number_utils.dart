class NumberUtils {

  static double formatStringToDouble(String? value) {
    if (value?.isNotEmpty == true) {
      return double.tryParse(value!) ?? 0.0;
    }
    return 0.0;
  }

  static int formatStringToInt(String? value) {
    if (value?.isNotEmpty == true) {
      return int.tryParse(value!) ?? 0;
    }
    return 0;
  }

  static String minus(String val1, String val2) {
    int value1 = formatStringToInt(val1);
    int value2 = formatStringToInt(val2);
    int calculated = value1 - value2;
    return calculated.toString();
  }

  static String add(String val1, String val2) {
    int value1 = formatStringToInt(val1);
    int value2 = formatStringToInt(val2);
    int calculated = value1 + value2;
    return calculated.toString();
  }

  static bool isLesserThan(String val1, String val2) {
    int value1 = formatStringToInt(val1);
    int value2 = formatStringToInt(val2);
    return value1 < value2;
  }

  static bool isLargerThan(String val1, String val2) {
    int value1 = formatStringToInt(val1);
    int value2 = formatStringToInt(val2);
    return value1 > value2;
  }
}