import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';

import 'package:photo/photo.dart';

class Bloc {
  StreamController<List<Photo>> _controller = StreamController<List<Photo>>();

  Stream<List<Photo>> get stream => _controller.stream;

  void loadData() async {
    final List<Photo> photos = [];
    var response = await get(Uri.parse(
        'https://api.unsplash.com/photos/?client_id=ab3411e4ac868c2646c0ed488dfd919ef612b04c264f3374c97fff98ed253dc9'));
    if (response.statusCode == 200) {
      List list = jsonDecode(response.body);
      for (int i = 0; i < list.length; i++) {
        Map<String, dynamic> element = list[i];
        Map<String, dynamic> user = element['user'];
        Map<String, dynamic> url = element['urls'];
        photos.add(Photo(
            name: user['name'],
            altDescription: element['alt_description'] ?? 'unknown',
            url: url['small'],
            urlFull: url['full']));
      }
      _controller.add(photos);
    } else {
      print('failed');
    }
  }

  void dispose() {
    _controller.close();
  }
}
