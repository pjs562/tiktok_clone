import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../constants/sizes.dart';
import '../../dark_mode_configuration/dark_mode_config.dart';

class PostVideoButton extends StatelessWidget {
  const PostVideoButton({
    Key? key,
    required this.isHover,
    required this.inverted,
  }) : super(key: key);

  final bool isHover;
  final bool inverted;

  @override
  Widget build(BuildContext context) {
    final isDark = darkModConfig.value;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: isHover ? 0.5 : 1,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: 19,
            child: Container(
              height: 32,
              width: 25,
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size8,
              ),
              decoration: BoxDecoration(
                color: const Color(0xff61D4F0),
                borderRadius: BorderRadius.circular(
                  8.5,
                ),
              ),
            ),
          ),
          Positioned(
            left: 19,
            child: Container(
              height: 32,
              width: 25,
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size8,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(
                  8.5,
                ),
              ),
            ),
          ),
          Container(
            height: 32,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size11,
            ),
            decoration: BoxDecoration(
              color: inverted || isDark ? Colors.black : Colors.white,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Center(
              child: FaIcon(
                FontAwesomeIcons.plus,
                color: inverted || isDark ? Colors.white : Colors.black,
                size: 19.5,
              ),
            ),
          )
        ],
      ),
    );
  }
}
