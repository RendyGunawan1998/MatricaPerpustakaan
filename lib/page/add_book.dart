import 'dart:io';

import '../core.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final BookController controller = Get.find();

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _isbnController = TextEditingController();
  final _yearController = TextEditingController();
  final _publisherController = TextEditingController();
  final _authorController = TextEditingController();
  final _synopsisController = TextEditingController();
  File? _coverFile;

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

  void _saveBook(BuildContext context) {
    if (_formKey.currentState!.validate() && _coverFile != null) {
      final newBook = Book(
        title: _titleController.text,
        isbn: _isbnController.text,
        year: int.parse(_yearController.text),
        publisher: _publisherController.text,
        author: _authorController.text,
        cover: _coverFile!.path,
        synopsis: _synopsisController.text,
      );

      controller.addBook(newBook);
      Get.back();
    } else {
      Get.snackbar(
          'Error', 'Please complete all fields and select a cover image.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Book')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                tff('Title', _titleController),
                hbox(4),
                tff('ISBN', _isbnController),
                hbox(4),
                tff('Publisher', _publisherController),
                hbox(4),
                tffNumber('Year', _yearController),
                hbox(4),
                tff('Author', _authorController),
                hbox(4),
                tffSynopsis(_synopsisController),
                hbox(10),
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
                        onPressed: () => _saveBook(context),
                        child: Text('Save Book'),
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
