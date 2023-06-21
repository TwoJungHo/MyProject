import 'package:bottonmenuex/dataSource/dataSource.dart';
import 'package:bottonmenuex/model/album.dart';

class AlbumRepository{
  final DataSource _dataSource = DataSource();

  Future<List<Album>> getAlbumList(){
    return _dataSource.getAlbumList();
  }
}