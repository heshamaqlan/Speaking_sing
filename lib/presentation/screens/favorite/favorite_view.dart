// no controller
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:speaking_sign/config/theme/app_colors.dart';
import 'package:speaking_sign/controller/favorite/favoritewordscontroller.dart';
import 'package:speaking_sign/presentation/screens/favorite/favorite_words_list_view.dart';
import 'package:speaking_sign/presentation/widgets/custom_top_header.dart';

class FavoriteView extends StatelessWidget {
  FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    Get.put(FavoriteWordsController());
    return Scaffold(
      backgroundColor: colors.scaffoldBackground,
      body: Column(
        children: [
          CustomTopHeader(text: 'المفضلة'),
          SizedBox(height: 0),
          Expanded(child: FavoriteWordsListView()),
        ],
      ),
    );
  }
}
