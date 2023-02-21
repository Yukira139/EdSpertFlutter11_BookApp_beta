import 'package:book_app/controllers/book_controller.dart';

import 'package:book_app/view/detail_book_page.dart';


import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class booklistpage extends StatefulWidget {
  const booklistpage({super.key});

  @override
  State<booklistpage> createState() => _booklistpageState();
}

class _booklistpageState extends State<booklistpage> {
  BookController? bookController;
  @override
  void initState() {

    super.initState();
    bookController = Provider.of<BookController>(context, listen: false);
    bookController!.fetchbookapi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Catalogue"),
      ),
      body: Consumer<BookController>(
        child: const Center(child: CircularProgressIndicator(),
                ),
        builder: (context, controller, child)=> Container(
          child: bookController!.booklist == null
              ? child
              : ListView.builder(
                itemCount: bookController!.booklist!.books!.length,
                itemBuilder: (context, index) {
                  final currentbook = bookController!.booklist!.books![index];
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
      ),
    );
  }
}
