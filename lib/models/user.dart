class User {
  String name, email, faculty, phone, year, roll, image;

  User(this.name, this.email, this.faculty, this.phone, this.year, this.roll, this.image);

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'phone': phone,
        'faculty': faculty,
        'year': year,
        'roll': roll,
        'image': image,
      };
}
