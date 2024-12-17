import 'dart:io';
import '../core.dart';

class ListBookScreen extends StatefulWidget {
  const ListBookScreen({super.key});

  @override
  State<ListBookScreen> createState() => _ListBookScreenState();
}

class _ListBookScreenState extends State<ListBookScreen> {
  final BookController controller = Get.put(BookController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Library App'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Get.to(() => AddBookScreen()),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Cari Buku...",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: controller.updateSearchQuery,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Obx(() {
              return DropdownButton<String>(
                isExpanded: true,
                hint: Text("Filter Tahun"),
                value: controller.selectYear.value.isEmpty
                    ? null
                    : controller.selectYear.value,
                items: [
                  DropdownMenuItem(value: "", child: Text("Semua Tahun")),
                  DropdownMenuItem(value: "2021", child: Text("2021")),
                  DropdownMenuItem(value: "2022", child: Text("2022")),
                  DropdownMenuItem(value: "2023", child: Text("2023")),
                ],
                onChanged: (value) {
                  controller.updateSelectedYear(value ?? "");
                },
              );
            }),
          ),
          Expanded(
            child: Obx(
              () {
                if (controller.filterBook.isEmpty) {
                  return Center(child: Text('No Data...'));
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.filterBook.length,
                    itemBuilder: (context, index) {
                      final book = controller.filterBook[index];
                      return Padding(
                        padding: EdgeInsets.all(10),
                        child: InkWell(
                          onTap: () {
                            Get.to(() =>
                                DetailBookScreen(book: book, index: index));
                          },
                          child: Container(
                            width: Get.width,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: Colors.grey, width: 1)),
                            child: Row(
                              children: [
                                Image.file(
                                  File(book.cover),
                                  height: 50,
                                ),
                                wbox(8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(book.title),
                                    Text(book.year.toString()),
                                    Text(book.author)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
