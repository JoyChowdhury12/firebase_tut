import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'book.dart';

class BookListScreen extends StatefulWidget {
  const BookListScreen({super.key});

  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final List<Book> bookList = [];
  @override
  void initState() {
    super.initState();
    _getBooks();
  }

  void _getBooks() async {
    await _firebaseFirestore.collection("books").get().then((snapshot) {
      bookList.clear();
      for (QueryDocumentSnapshot doc in snapshot.docs) {
        bookList.add(Book.fromJson(doc.id, doc.data() as Map<String, dynamic>));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Books"),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => ListTile(
                title: Text("Book Name"),
                subtitle: Text("Author Name"),
                leading: Text("Language"),
                trailing: Text("Trailing"),
              ),
          separatorBuilder: (_, __) => Divider(),
          itemCount: bookList.length),
    );
  }
}
