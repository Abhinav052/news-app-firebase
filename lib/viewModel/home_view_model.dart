import 'package:flutter/cupertino.dart';
import 'package:newzbuzz/services/news.service.dart';
import 'package:newzbuzz/views/components/custom_snackbar.dart';

import '../services/remote_config_service.dart';

class HomeViewModel extends ChangeNotifier {
  bool isLoading = true;
  List<dynamic> newsList = [];
  String countryCode = '';
  bool error = false;

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  loadNewsPageData() async {
    await setCountryCode();
    getNews();
  }

  setCountryCode() async {
    await FirebaseRemoteConfigService.fetchAndActivate();
    countryCode = FirebaseRemoteConfigService.getCountryCode();
  }

  getNews() async {
    setLoading(true);
    final res = await NewsService.fetchNews(countryCode.toLowerCase());
    res.fold((l) => {error = true}, (r) {
      newsList = r;
    });
    setLoading(false);
  }
}
