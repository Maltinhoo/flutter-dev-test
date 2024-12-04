import 'package:flutter/material.dart';
import 'package:flutter_dev_test/app_imports.dart';

class LoginImage extends StatelessWidget {
  const LoginImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 222,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(top: 20, child: Vector(Vectors.first_wave)),
          Positioned(top: 108, child: Vector(Vectors.second_wave)),
          CustomImage(
            imageUrl: 'assets/images/login.png',
            local: true,
          ),
        ],
      ),
    );
  }
}
