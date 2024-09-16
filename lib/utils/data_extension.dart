extension DateEx on double? {
  int get second {
    if (this == null) {
      return 0;
    }
    return (this! * 60).round();
  }
}

extension StringEx on String? {
  String get baseImageUrl {
    if (this?.isNotEmpty == true) {
      return 'https://www.themoviedb.org/t/p/w220_and_h330_face$this';
    }
    return '';
  }
}