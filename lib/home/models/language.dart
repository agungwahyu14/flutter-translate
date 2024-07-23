class Language {
  final String name;
  final String code;

  Language(this.name, this.code);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Language && other.code == code;
  }

  @override
  int get hashCode => code.hashCode;
}
