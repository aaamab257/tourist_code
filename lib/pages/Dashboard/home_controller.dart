

import 'package:get/get.dart';


class HomeController extends GetxController {
  int index = 1;
  bool isSearchOpened = false;
  bool isKeyBoardOpen = false;
  // List<LandmarksModel> landmarks = [];

  // Future<List<LandmarksModel>> getLandMarks() async {
  //   try {
  //     const url = 'http://10.0.2.2:8000/api/landmarks';
  //     final uri = Uri.parse(url);
  //     final response = await http.get(uri);

  //     if (response.statusCode == 200) {
  //       print("Done its 200 ");
  //       final json = jsonDecode(response.body) as List;
  //       final list = json.map((e) {
  //         return LandmarksModel(
  //             id: e['id'],
  //             name: e['name'],
  //             description: e['description'],
  //             location: e['location']);
  //       }).toList();
  //       landmarks = list;
  //       print("Data========= > ${landmarks[2].id} ");
  //       return list;
  //     } else {
  //       print("failed");
  //       return [];
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //     return [];
  //   }
  // }
}
