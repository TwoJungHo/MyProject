import 'package:bottonmenuex/model/album.dart';
import 'package:bottonmenuex/repository/albumRepository.dart';
import 'package:flutter/cupertino.dart';

class AlbumViewModel with ChangeNotifier{
  late final AlbumRepository _albumRepository;
  List<Album> _albumList = List.empty(growable: true);

  List<Album> get albumList => _albumList;

  AlbumViewModel(){
    _albumRepository = AlbumRepository();
    _getAlbumList();
  }

  Future<void> _getAlbumList() async{
    _albumList = await _albumRepository.getAlbumList();
    notifyListeners();
  }
}
