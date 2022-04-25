// ignore_for_file: avoid_print

import 'package:breaking_bad/constant/strings.dart';
import 'package:dio/dio.dart';

class CharacterWebServices {
  late Dio dio;

  CharacterWebServices() {
    BaseOptions options = BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: 20 * 1000,
        receiveTimeout: 20 * 1000);
    dio = Dio(options);
  }

  Future<List<dynamic>> getAllcharacters() async {
    try {
      Response response = await dio.get("characters");
      print(response.data.toString());

      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<dynamic>> getAllcharactersQuotes(String charName) async {
    try {
      Response response =
          await dio.get("quote", queryParameters: {"author": charName});
      print(response.data.toString());

      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
