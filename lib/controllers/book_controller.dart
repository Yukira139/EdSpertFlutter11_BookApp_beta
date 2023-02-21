import 'dart:convert';
import 'package:book_app/models/booklistResponse.dart';



import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:book_app/models/book_detail_response.dart';







class BookController extends ChangeNotifier {
  booklistResponse? booklist;
  fetchbookapi() async {
    var url = Uri.https('https://api.itbook.store/1.0/new');
    var response = await http.get(url);


    // print(await http.read(Uri.https('example.com', 'foobar.txt')));
    if (response.statusCode == 200) {
      final jsonbooklist = jsonDecode(response.body);
      booklist = booklistResponse.fromJson(jsonbooklist);
      notifyListeners();
    }
  }

    bookdetailresponse? detailbook;
  fetchdetailbookapi(isbn) async {
    var url = Uri.https('https://api.itbook.store/1.0/books/$isbn');
    var response = await http.get(url);


    // print(await http.read(Uri.https('example.com', 'foobar.txt')));
    if (response.statusCode == 200) {
      final jsonDetail = jsonDecode(response.body);
      detailbook = bookdetailresponse.fromJson(jsonDetail);
      notifyListeners();
      fetchsimbooksapi(detailbook!.title!);
    }
  }

  booklistResponse? simbooks;
  fetchsimbooksapi(String title) async {
    //print(widget.isbn);
    var url = Uri.https('https://api.itbook.store/1.0/search/$title');
    var response = await http.get(url);


    // print(await http.read(Uri.https('example.com', 'foobar.txt')));
    if (response.statusCode == 200) {
      final jsonDetail = jsonDecode(response.body);
      simbooks = booklistResponse.fromJson(jsonDetail);
      notifyListeners();
    }
  }
  
}