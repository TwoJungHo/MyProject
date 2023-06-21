import 'package:bottonmenuex/viewModel/AlbumViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/album.dart';

class AlbumView extends StatefulWidget {
  const AlbumView({Key? key}) : super(key: key);

  @override
  State<AlbumView> createState() => _AlbumViewState();
}

class _AlbumViewState extends State<AlbumView> {
  late List<Album> albumList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MVVN ex"),
      ),
      body: Consumer<AlbumViewModel>(
        builder: (context, provider, child) {
          albumList = provider.albumList;
          return ListView.builder(
            itemCount: albumList.length,
            itemBuilder: (context, index) {
              return Container(
                child:
                    Text("${albumList[index].id}: ${albumList[index].title}"),
              );
            },
          );
        },
      ),
    );
  }
}
