import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/note_viewmodel.dart';
import '../../models/note.dart';

class NoteScreen extends StatelessWidget {
  const NoteScreen({super.key});
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

          return Card(
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
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          vm.addNote(Note(title: "Title", content: "Content"));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
