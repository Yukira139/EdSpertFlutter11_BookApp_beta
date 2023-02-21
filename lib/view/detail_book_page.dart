

import 'package:book_app/controllers/book_controller.dart';
import 'package:book_app/models/book_detail_response.dart';
import 'package:book_app/models/booklistResponse.dart';
import 'package:book_app/view/image_view_screen.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class detailbookpage extends StatefulWidget {
  const detailbookpage({Key? key, required this.isbn}) : super(key: key);
  final String isbn;

  @override
  State<detailbookpage> createState() => _detailbookpageState();
}

class _detailbookpageState extends State<detailbookpage> {
  BookController? controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Provider.of<BookController>(context, listen: false);
    controller!.fetchdetailbookapi(widget.isbn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body:  Consumer<BookController>(
            builder: (context, controller, child) {
              return controller.detailbook == null
          ? Center(child: CircularProgressIndicator())
          :Padding(
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
                                      imageviewscreen(imageurl: controller.detailbook!.image!),
                                ),
                              );
                            },
                            child: Image.network(
                              controller.detailbook!.image!,
                              height: 150,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(controller.detailbook!.title!,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  Text(controller.detailbook!.subtitle!,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 10),
                                  Row(
                                      children: List.generate(
                                          5,
                                          (index) => Icon(
                                                Icons.star,
                                                color: index <
                                                        int.parse(
                                                            controller.detailbook!.rating!)
                                                    ? Colors.yellow
                                                    : Colors.grey,
                                              ))),
                                  Text(controller.detailbook!.price!,
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
                            onPressed: () async {
                              print("url");
                              Uri uri = Uri.parse(controller.detailbook!.url!);
                              try {
                                (await canLaunchUrl(uri))
                                ? launchUrl(uri)
                                : print ("link error");
                              } catch (e) {
                                print("error");
                                print(e);
                              }
                            },
                            child: Text("Buy")),
                      ),
                      SizedBox(height: 20),
                      Text(controller.detailbook!.desc!),
                      SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Author" + controller.detailbook!.authors!),
                          Text("Publisher" + controller.detailbook!.publisher!),
                          Text("Language" + controller.detailbook!.language!),
                          Text("Year" + controller.detailbook!.year!),
                          Text(controller.detailbook!.pages! + "Page"),
                          Text("ISBN10" + controller.detailbook!.isbn10!),
                          Text("ISBN13" + controller.detailbook!.isbn13!),
                          Text(controller.detailbook!.url!),
                          //Text(detailbook!.rating!),
                        ],
                      ),
                      Divider(),
                      controller.simbooks == null
                          ? CircularProgressIndicator()
                          : Container(
                              height: 180,
                              child: ListView.builder(
                                  //shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 20,
                                  //physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final current = controller.simbooks!.books![index];
                                    return Container(
                                      width: 100,
                                      child: Column(children: [
                                        Image.network(current.image!),
                                        Text(
                                          current.title!,
                                          maxLines: 3,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 12),
                                        )
                                      ]),
                                    );
                                  }),
                            )
                    ],
                  ),
                );
            }
          ),
    );
  }
}
