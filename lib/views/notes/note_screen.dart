import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/note_viewmodel.dart';
import '../../models/note.dart';

class NoteScreen extends StatelessWidget {
  const NoteScreen({super.key});

  void _showEditDialog(BuildContext context, NoteViewModel vm, int? index) {
    final isNew = index == null;
    final note = isNew ? Note(title: "", content: "") : vm.notes[index];
    final titleController = TextEditingController(text: note.title);
    final contentController = TextEditingController(text: note.content);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isNew ? "Add Note" : "Edit Note"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(hintText: "Note title"),
              ),
              SizedBox(height: 16),
              TextField(
                controller: contentController,
                decoration: InputDecoration(hintText: "Note content"),
                maxLines: 5,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              final newNote = Note(
                title: titleController.text.isEmpty
                    ? "Untitled"
                    : titleController.text,
                content: contentController.text,
              );
              if (isNew) {
                vm.addNote(newNote);
              } else {
                vm.updateNote(index, newNote);
              }
              Navigator.pop(context);
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<NoteViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Notes")),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: vm.notes.length,
        itemBuilder: (_, index) {
          final note = vm.notes[index];

          return GestureDetector(
            onTap: () => _showEditDialog(context, vm, index),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Text(
                      note.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(note.content),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => vm.deleteNote(index),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showEditDialog(context, vm, null),
        child: Icon(Icons.add),
      ),
    );
  }
}
