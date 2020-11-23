class Lecture {
  String title;
  String date;
  String description;
  int maxCapacity;
  int numberOfAttendees;

  Lecture(String title, String date, String description, int capacity) {
    this.title = title;
    this.date = date;
    this.description = description;
    this.maxCapacity = capacity;
    this.numberOfAttendees = 0;
  }

  String getTitle() {
    return this.title;
  }

  String getDate() {
    return this.date;
  }

  String getDescription() {
    return this.description;
  }

  int getMaxCapacity() {
    return this.maxCapacity;
  }
}
