// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:speaking_sing_start/app/Modules/Splash/splash_controoler.dart';

// class SplashView extends GetView<SplashController> {
//   const SplashView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white, // لون خلفية بنفسجي غامق
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // الشعار مع أنيميشن بسيط
//             TweenAnimationBuilder<double>(
//               tween: Tween<double>(begin: 0.0, end: 1.0),
//               duration: const Duration(seconds: 1),
//               builder: (context, scale, child) {
//                 return Transform.scale(
//                   scale: scale,
//                   child: Image.asset(
//                     'assets/images/logo.png', // تأكد من وضع شعارك هنا
//                     width: 150,
//                     height: 150,
//                   ),
//                 );
//               },
//             ),
//             const SizedBox(height: 20),
//             // اسم التطبيق
//             const Text(
//               'SpeakingSing',
//               style: TextStyle(
//                 color: Colors.purple,
//                 fontSize: 32,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speaking_sign/controller/splash/splash_controoler.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      body: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height * 0.25,
            left: MediaQuery.of(context).size.width * 0.0,
            child: Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.width * 1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100),
                  topRight: Radius.circular(220),
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(350),
                ),

                color: Colors.deepPurple.withOpacity(0.08),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurple.withOpacity(0.05),
                    blurRadius: 0,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),
          ),
          // // الخلفية الانسيابية (Blob) الشفافة السفلية اليمنى
          // Positioned(
          //   bottom: MediaQuery.of(context).size.height * 0.1,
          //   right: MediaQuery.of(context).size.width * 0.1,
          //   child: Container(
          //     width: MediaQuery.of(context).size.width * 0.6,
          //     height: MediaQuery.of(context).size.width * 0.6,
          //     decoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       color: Colors.deepPurple.withOpacity(0.05), // بنفسجي شفاف جداً
          //       boxShadow: [
          //         BoxShadow(
          //           color: Colors.deepPurple.withOpacity(0.03),
          //           blurRadius: 40,
          //           spreadRadius: 15,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.width * 0.3,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepPurple,

                    boxShadow: [
                      BoxShadow(
                        color: Colors.deepPurple.withOpacity(0.05),
                        blurRadius: 20,
                        spreadRadius: 20,
                      ),
                    ],
                  ),
                  child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0.0, end: 1.0),
                    duration: const Duration(seconds: 2),
                    builder: (context, scale, child) {
                      return Transform.scale(
                        scale: scale,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 18),
                          child: Image.asset(
                            'assets/images/logo2.png',
                            width: 200,
                            height: 200,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),

                const Text(
                  'SpeakingSing',
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
