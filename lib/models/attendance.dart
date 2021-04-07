class UserInfo {
  int present = 0, total = 0;

  UserInfo(this.present, this.total);
}

class AbsentPercent {
  String percent;
  AbsentPercent(this.percent);

  Map<String, dynamic> toJson() => {
        'percent': percent,
      };
}