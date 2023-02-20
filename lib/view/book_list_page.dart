import 'dart:convert';
import 'package:book_app/models/booklistResponse.dart';
import 'package:book_app/view/detail_book_page.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class booklistpage extends StatefulWidget {
  const booklistpage({super.key});

  @override
  State<booklistpage> createState() => _booklistpageState();
}

class _booklistpageState extends State<booklistpage> {
  booklistResponse? booklist;
  fetchbookapi() async {
    var url = Uri.https('https://api.itbook.store/1.0/new');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    // print(await http.read(Uri.https('example.com', 'foobar.txt')));
    if (response.statusCode == 200) {
      final jsonbooklist = jsonDecode(response.body);
      booklist = booklistResponse.fromJson(jsonbooklist);
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchbookapi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Catalogue"),
      ),
      body: Container(
        child: booklist == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
              itemCount: booklist!.books!.length,
              itemBuilder: (context, index) {
                final currentbook = booklist!.books![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder:(context) =>detailbookpage(
                      isbn: currentbook.isbn13! ),),);
                  },
                  child: Row(
                    children: [
                      Image.network(
                        currentbook.image!,
                        height: 100,
                      ),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(currentbook.title!),
                            Text(currentbook.subtitle!),
                            Align(
                              alignment: Alignment.topRight,
                              child: Text(currentbook.price!),
                            )
                          ],
                        ),
                      ))
                    ],
                  ),
                );
              }),
      ),
    );
  }
}
