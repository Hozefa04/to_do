import 'package:cloud_firestore/cloud_firestore.dart';

class NotesModel {
  final int color;
  final String id;
  final String notes;
  final int timestamp;
  final String title;

  const NotesModel(this.color, this.id, this.notes, this.timestamp, this.title);

  factory NotesModel.fromFirestore(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return NotesModel(data["color"], data["id"], data["notes"], data["timestamp"], data["title"]);
  }

}