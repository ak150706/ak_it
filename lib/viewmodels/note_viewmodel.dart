import 'package:flutter/material.dart';
import '../models/note.dart';

class NoteViewModel extends ChangeNotifier {
  final List<Note> _notes = [];

  List<Note> get notes => _notes;

  void addNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  void deleteNote(int index) {
    _notes.removeAt(index);
    notifyListeners();
  }

  void updateNote(int index, Note note) {
    _notes[index] = note;
    notifyListeners();
  }
}
