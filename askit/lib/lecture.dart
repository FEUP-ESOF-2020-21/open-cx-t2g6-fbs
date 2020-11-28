import 'dart:core';

class Lecture {
  int id;
  String title;
  String date;
  String description;
  int maxCapacity;
  int attendance;

  Lecture(id, title, description, date, capacity, attendance) {
    this.id = id;
    this.title = title;
    this.description = description;
    this.date = date;
    this.maxCapacity = capacity;
    this.attendance = attendance;
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

  int getAttendance() {
    return this.attendance;
  }

  String printIdAndTitle() {
    return "Lecture #" + this.getId().toString() + "\nTitle: " + this.title;
  }

  String printTheRest() {
    return "Description: " +
        this.description +
        "\nDate: " +
        this.date +
        "\nCapacity: " +
        this.attendance.toString() +
        "/" +
        this.maxCapacity.toString();
  }
}
