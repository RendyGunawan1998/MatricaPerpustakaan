import 'dart:io';

import '../core.dart';

class EditBookScreen extends StatefulWidget {
  final Book book;
  final int index;
  const EditBookScreen({super.key, required this.book, required this.index});

  @override
  State<EditBookScreen> createState() => _EditBookScreenState();
}

class _EditBookScreenState extends State<EditBookScreen> {
  final BookController controller = Get.find();

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _isbnController;
  late final TextEditingController _yearController;
  late final TextEditingController _publisherController;
  late final TextEditingController _authorController;
  late final TextEditingController _synopsisController;
  File? _coverFile;

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.book.title);
    _isbnController = TextEditingController(text: widget.book.isbn);
    _yearController = TextEditingController(text: widget.book.year.toString());
    _publisherController = TextEditingController(text: widget.book.publisher);
    _authorController = TextEditingController(text: widget.book.author);
    _synopsisController = TextEditingController(text: widget.book.synopsis);
    _coverFile = File(widget.book.cover);
    super.initState();
  }

  Future<void> _pickCoverImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _coverFile = File(pickedFile.path);
      });
    }
  }

  void _updateBook() {
    if (_formKey.currentState!.validate() && _coverFile != null) {
      final updatedBook = Book(
        title: _titleController.text,
        isbn: _isbnController.text,
        year: int.parse(_yearController.text),
        publisher: _publisherController.text,
        author: _authorController.text,
        cover: _coverFile!.path,
        synopsis: _synopsisController.text,
      );

      setState(() {
        controller.updateBook(widget.index, updatedBook);
      });
      Get.offAll(() => ListBookScreen());
    } else {
      Get.snackbar(
          'Error', 'Please complete all fields and select a cover image.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Book')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                tff('Title', _titleController),
                hbox(10),
                tff('ISBN', _isbnController),
                hbox(10),
                tff('Publisher', _publisherController),
                hbox(10),
                tffNumber('Year', _yearController),
                hbox(10),
                tff('Author', _authorController),
                hbox(10),
                tffSynopsis(_synopsisController),
                hbox(18),
                _coverFile == null
                    ? Text('No cover selected')
                    : Image.file(
                        _coverFile!,
                        height: 200,
                      ),
                hbox(10),
                ElevatedButton(
                  onPressed: _pickCoverImage,
                  child: Text('Pick Cover Image'),
                ),
                hbox(20),
                _coverFile != null
                    ? ElevatedButton(
                        onPressed: _updateBook,
                        child: Text('Update Book'),
                      )
                    : hbox(0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
