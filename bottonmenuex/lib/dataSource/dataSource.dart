import 'dart:convert';

import 'package:bottonmenuex/model/album.dart';
import 'package:http/http.dart' as http;

class DataSource{
  Future<List<Album>> getAlbumList() async{
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/albums/"));

    List<Album> list = jsonDecode(utf8.decode(response.bodyBytes)).map<Album>((json)=> Album.fromJson(json)).toList();
    print(list);
    return list;
  }
}