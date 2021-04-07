class Holiday {
  String today;

  Holiday(this.today);

  Map<String, dynamic> toJSon() => {
        'today': today,
      };
}
