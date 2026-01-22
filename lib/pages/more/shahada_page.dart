import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ShahadaPage extends StatefulWidget {
  const ShahadaPage({super.key});

  @override
  State<ShahadaPage> createState() => _ShahadaPageState();
}

class _ShahadaPageState extends State<ShahadaPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);

    _scale = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _opacity = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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

              RepaintBoundary(
                child: SvgPicture.asset(
                  'assets/images/shahada.svg',
                  width: 250,
                  fit: BoxFit.contain,
                  allowDrawingOutsideViewBox: true,
                ),
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