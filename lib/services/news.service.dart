import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:newzbuzz/utils/service/http_service.dart';
import '../utils/errors/failure.dart';

class NewsService {
  static Future<Either<Failure, List<dynamic>>> fetchNews(String countryCode) async {
    try {
      final response = await http.get(
        Uri.parse(
            "https://newsapi.org/v2/top-headlines?country=${countryCode}&apiKey=${dotenv.env['NEWS_API_KEY']}"),
      );
      if (response.statusCode != 200) {
        throw Exception("Something went wrong");
      }
      final data = jsonDecode(response.body);
      return right(data["articles"]);
    } catch (e) {
      return left(Failure("Something went wrong"));
    }
  }
}
