import 'dart:convert';

import 'package:book_app/models/book_detail_response.dart';
import 'package:book_app/view/image_view_screen.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class detailbookpage extends StatefulWidget {
  const detailbookpage({Key? key, required this.isbn}) : super(key: key);
  final String isbn;

  @override
  State<detailbookpage> createState() => _detailbookpageState();
}

class _detailbookpageState extends State<detailbookpage> {
  bookdetailresponse? detailbook;
  fetchdetailbookapi() async {
    print(widget.isbn);
    var url = Uri.https('https://api.itbook.store/1.0/books/${widget.isbn}');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    // print(await http.read(Uri.https('example.com', 'foobar.txt')));
    if (response.statusCode == 200) {
      final jsonDetail = jsonDecode(response.body);
      detailbook = bookdetailresponse.fromJson(jsonDetail);
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchdetailbookapi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: detailbook == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    //crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  imageviewscreen(imageurl: detailbook!.image!),
                            ),
                          );
                        },
                        child: Image.network(
                          detailbook!.image!,
                          height: 150,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(detailbook!.title!,
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold)),
                              Text(detailbook!.subtitle!,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 10),
                              Row(
                                  children: List.generate(
                                      5, (index) => Icon(Icons.star,
                                      color: index < int.parse(detailbook!.rating!)
                                      ? Colors.yellow
                                      : Colors.grey,))),
                              Text(detailbook!.price!,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            //fixedSize: Size(double.infinity, 50)
                            ),
                        onPressed: () {},
                        child: Text("Buy")),
                  ),
                  SizedBox(height: 20),
                  Text(detailbook!.desc!),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Author" + detailbook!.authors!),
                      Text("Publisher" + detailbook!.publisher!),
                      Text("Language" + detailbook!.language!),
                      Text("Year" + detailbook!.year!),
                      Text(detailbook!.pages! + "Page"),
                      Text("ISBN10" + detailbook!.isbn10!),
                      Text("ISBN13" + detailbook!.isbn13!),
                      Text(detailbook!.url!),
                      //Text(detailbook!.rating!),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
