import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:newzbuzz/services/auth_service.dart';
import 'package:newzbuzz/services/remote_config_service.dart';
import 'package:newzbuzz/utils/routes/routes.dart';
import 'package:newzbuzz/utils/shared_preferance/token_storage.dart';
import 'package:newzbuzz/viewModel/auth_view_model.dart';
import 'package:newzbuzz/viewModel/home_view_model.dart';
import 'package:provider/provider.dart';

import '../utils/theme/app_pallete.dart';
import 'components/news_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Provider.of<HomeViewModel>(context, listen: false).loadNewsPageData();
    super.initState();
  }

  Future<void> logout() async {
    bool res = await AuthService.logout();
    if (res && mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil(Routes.loginScreen, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppPallete.primaryColor,
        title: Text(
          'MyNews',
          style:
              GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 16),
        ),
        actions: [
          IconButton(
            icon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Iconsax.send_2,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Consumer<HomeViewModel>(
                    builder: (context, provider, child) {
                      return Text(
                        provider.countryCode,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 16,
                            height: 0),
                      );
                    },
                  )
                ],
              ),
            ),
            onPressed: logout,
            color: Colors.white,
          ),
        ],
      ),
      body: Consumer<HomeViewModel>(
        builder: (context, provider, child) {
          return provider.error
              ? RefreshIndicator(
                  onRefresh: () async => await provider.loadNewsPageData(),
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .4),
                          child: Text(
                            "Something went wrong!",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600, color: Colors.black, fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : provider.isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppPallete.primaryColor,
                      ),
                    )
                  : Container(
                      color: Color(0xffced3dc).withOpacity(.4),
                      child: RefreshIndicator(
                        onRefresh: () async => await provider.loadNewsPageData(),
                        child: SingleChildScrollView(
                          physics: ScrollPhysics(),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                                child: Text(
                                  'Top Headlines',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 16),
                                ),
                              ),
                              NewsList(newsList: provider.newsList),
                            ],
                          ),
                        ),
                      ),
                    );
        },
      ),
    );
  }
}
