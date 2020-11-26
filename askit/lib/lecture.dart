import 'dart:core';

class Lecture {
  int id;
  String title;
  String date;
  String description;
  int maxCapacity;

  Lecture(id, title, description, date, capacity) {
    this.id = id;
    this.title = title;
    this.description = description;
    this.date = date;
    this.maxCapacity = capacity;
  }

  int getId() {
    return this.id;
  }

  String getTitle() {
    return this.title;
  }

  String getDescription() {
    return this.description;
  }

  String getDate() {
    return this.date;
  }

  int getCapacity() {
    return this.maxCapacity;
  }
}
