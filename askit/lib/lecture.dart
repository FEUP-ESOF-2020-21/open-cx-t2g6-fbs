import 'dart:core';

class Lecture {
  int id;
  String title;
  String date;
  String description;
  int maxCapacity;
  int attendance;
  String fileName;

  Lecture(id, title, description, date, capacity, attendance, fileName) {
    this.id = id;
    this.title = title;
    this.description = description;
    this.date = date;
    this.maxCapacity = capacity;
    this.attendance = attendance;
    this.fileName = fileName;
  }

  int getId() {
    return this.id;
  }

  String getFileName() {
    return this.fileName;
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

  String printDateAndCapacity() {
    return "Date: " +
        this.date +
        "\nCapacity: " +
        this.attendance.toString() +
        "/" +
        this.maxCapacity.toString();
  }
}
