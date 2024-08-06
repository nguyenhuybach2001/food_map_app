import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  Note({
    this.id,
    this.title,
    this.content,
    this.dateCreated,
    this.dateModified,
    this.imageUrl, // Thêm trường imageUrl
  });
  
  String? id;
  String? title;
  String? content;
  Timestamp? dateCreated;
  Timestamp? dateModified;
  String? imageUrl; // Thêm trường imageUrl

  Note.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    dateCreated = json['dateCreated'];
    dateModified = json['dateModified'];
    imageUrl = json['imageUrl']; // Thêm trường imageUrl
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'dateCreated': dateCreated,
      'dateModified': dateModified,
      'imageUrl': imageUrl, // Thêm trường imageUrl
    };
  }
}
