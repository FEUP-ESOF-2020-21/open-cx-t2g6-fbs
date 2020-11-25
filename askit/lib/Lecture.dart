import 'dart:core';

class Lecture {
  int id;
  String title;
  String date;
  String role;

  Lecture(id, title, date, role) {
    this.id = id;
    this.title = title;
    this.date = date;
    this.role = role;
  }

  int getId() {
    return this.id;
  }

  String getTitle() {
    return this.title;
  }

  String getDate() {
    return this.date;
  }

  String getRole() {
    return this.role;
  }
}
