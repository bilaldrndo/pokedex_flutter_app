import 'package:flutter/material.dart';
import 'package:pokedex_app/ui/components/global_text_widget.dart';
import 'package:pokedex_app/utilities/theme.dart';

class CustomFloatingBtn extends StatefulWidget {
  final bool isSmaller;
  final Function() onTap;
  const CustomFloatingBtn({
    super.key,
    required this.isSmaller,
    required this.onTap,
  });

  @override
  State<CustomFloatingBtn> createState() => _CustomFloatingBtnState();
}

class _CustomFloatingBtnState extends State<CustomFloatingBtn> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: (widget.isSmaller) ? CustomTheme.darkBluePrimaryColor : CustomTheme.lightBlueButtonColor,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: -4,
              blurRadius: 8,
              offset: const Offset(0, 7),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              spreadRadius: 2,
              blurRadius: 17,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        height: 50,
        width: (widget.isSmaller) ? 157 : 201,
        child: Center(
          child: AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            firstCurve: Curves.easeOut,
            secondCurve: Curves.easeOut,
            crossFadeState: (widget.isSmaller) ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            firstChild: const GlobalTextWidget(
              'Mark as favourite',
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            secondChild: FittedBox(
              child: GlobalTextWidget(
                'Remove from favourites',
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: CustomTheme.darkBluePrimaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
