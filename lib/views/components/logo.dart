import 'package:flutter/cupertino.dart';

class XLogo extends StatelessWidget{
  const XLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200,
        child: Center(
          child: Container(
            width: 100,
            height: 100,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                      color: Color(0x40000000), offset: Offset(10, 10))
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/onboarding/logo.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
        ));
  }

}