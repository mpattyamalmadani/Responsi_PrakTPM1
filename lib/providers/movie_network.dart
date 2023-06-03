import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:responsi_praktpm/models/detail_model.dart';
import 'package:responsi_praktpm/models/home_data_model.dart';
import 'package:responsi_praktpm/models/search_result_model.dart';

const String apiKey = 'https://www.omdbapi.com/?apikey=46539e83';
const String baseUrl = 'https://www.omdbapi.com/';

Future<HomeDataModel> getHomeData({String category = "movie"}) async {
  final String fullUrl = '$baseUrl?apikey=$apiKey&type=$category';
  final response = await http.get(Uri.parse(fullUrl));
  debugPrint("BaseNetwork - response : ${response.body}");
  return homeDataModelFromJson(response.body);
}

Future<SearchResultModel> getSearchResultData(String query) async {
  final String fullUrl = '$baseUrl?apikey=$apiKey&s=$query';
  final response = await http.get(Uri.parse(fullUrl));
  debugPrint("BaseNetwork - response : ${response.body}");
  return searchResultModelFromJson(response.body);
}

Future<DetailModel> getDetail(String id) async {
  final String fullUrl = '$baseUrl?apikey=$apiKey&i=$id';
  final response = await http.get(Uri.parse(fullUrl));
  return detailModelFromJson(response.body);
}
