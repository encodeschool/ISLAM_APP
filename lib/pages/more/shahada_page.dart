import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ShahadaPage extends StatelessWidget {
  const ShahadaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(t.shahadaTitle),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsetsDirectional.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SvgPicture.asset(
                'assets/images/shahada.svg',
                width: 250,
              ),

              // Text(
              //   t.shahadaArabic,
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //     fontFamily: 'Amiri',
              //     fontSize: 30,
              //     height: 1.8,
              //     color: Colors.green[900],
              //   ),
              // ),

              const SizedBox(height: 32),

              Text(
                  "Ashhadu an lā ilāha illā-llāh, wa ashhadu anna Muḥammadan rasūlu-llāh",
                  style: TextStyle(
                    color: Colors.grey
                  ),
                  textAlign: TextAlign.center,
              ),

              const SizedBox(height: 32),

              Text(
                t.shahadaTranslation,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  height: 1.6,
                  color: Colors.green[900]
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
