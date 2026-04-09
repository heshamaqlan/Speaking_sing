import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speaking_sign/controller/favorite/favoritewordscontroller.dart';
import 'package:speaking_sign/presentation/widgets/favorite_word_card.dart';

class FavoriteWordsListView extends StatelessWidget {
  const FavoriteWordsListView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FavoriteWordsController>();

    return Obx(
      () => ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: controller.favoriteWords.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final word = controller.favoriteWords[index];

          return GestureDetector(
            onTap: () => controller.selectWord(index, word, context),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              child: FavoriteWordCard(
                isSelected: controller.currentItemIndex.value == index,
                text: word,
                gradientColors: const [
                  Color(0xFFDA22FF),
                  Color(0xFF9733EE),
                  Color(0xFF667EEA),
                ],
                glowIntensity: 0.3,
              ),
            ),
          );
        },
      ),
    );
  }
}
