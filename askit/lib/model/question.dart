import 'dart:core';

class Question {
  int id;
  String question;
  int rating;
  int slide;

  Question(id, question, rating, slide) {
    this.id = id;
    this.question = question;
    this.rating = rating;
    this.slide = slide;
  }

  int getId() {
    return this.id;
  }

  String getQuestion() {
    return this.question;
  }

  int getRating() {
    return this.rating;
  }

  int getSlide() {
    return this.slide;
  }

  String printIdAndQuestion() {
    return "Question ID #" +
        this.getId().toString() +
        "\n" +
        "> " +
        this.getQuestion();
  }
}
