import 'dart:io';

import '../core.dart';

class DetailBookScreen extends StatefulWidget {
  final Book book;
  final int index;
  const DetailBookScreen({super.key, required this.book, required this.index});

  @override
  State<DetailBookScreen> createState() => _DetailBookScreenState();
}

class _DetailBookScreenState extends State<DetailBookScreen> {
  final BookController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.title),
        leading: BackButton(
          onPressed: () {
            Get.to(() => ListBookScreen());
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.file(File(widget.book.cover)),
              hbox(12),
              Text('Title: ${widget.book.title}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              hbox(4),
              Text('Author: ${widget.book.author}'),
              hbox(4),
              Text('Publisher: ${widget.book.publisher}'),
              hbox(4),
              Text('Year: ${widget.book.year}'),
              hbox(4),
              Text('ISBN: ${widget.book.isbn}'),
              hbox(4),
              Text('Synopsis:', style: TextStyle(fontWeight: FontWeight.bold)),
              hbox(4),
              Text(widget.book.synopsis),
              hbox(12),
              buttonBlue(() {
                controller.deleteBook(widget.book);
                setState(() {});
                Get.to(() => ListBookScreen());
              }, Icons.delete, 'Delete'),
              hbox(8),
              buttonBlue(() {
                Get.to(() =>
                    EditBookScreen(book: widget.book, index: widget.index));
              }, Icons.edit, 'Edit'),
              hbox(40),
            ],
          ),
        ),
      ),
    );
  }
}
