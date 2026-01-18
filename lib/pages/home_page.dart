import 'package:flutter/material.dart';
import 'package:mosque/pages/prayer_page.dart';
import 'package:mosque/pages/qibla_page.dart';
import 'package:mosque/pages/settings_page.dart';
import 'package:mosque/widgets/header_widget.dart';

import '../l10n/app_localizations.dart';
import 'counter_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final PageController _pageController = PageController();
  int _currentIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onNavTapped(int index) {
    _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/images/header_bg.png'),
                fit: BoxFit.cover,
              ),
              color: Colors.black.withOpacity(0.25),
            ),
          ),
        ),

        Scaffold(
          backgroundColor: Colors.transparent, // IMPORTANT
          body: Column(
            children: [
              // HEADER (transparent now)
              SizedBox(
                height: 250,
                child: HeaderWidget(),
              ),

              // CONTENT AREA
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 16,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                    child: Material(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      elevation: 8,
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: _onPageChanged,
                        children: const [
                          PrayerPage(),
                          QiblaPage(),
                          CounterPage(),
                          SettingsPage(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // BOTTOM NAV
          bottomNavigationBar: _buildBottomNav(),
        ),
      ],
    );

  }
  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        // borderRadius: const BorderRadius.only(
        //   topLeft: Radius.circular(24),
        //   topRight: Radius.circular(24),
        // ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: _onNavTapped,
          selectedItemColor: Colors.green[900],
          // selectedItemColor: Color(0xFFC8A951),
          unselectedItemColor: Colors.black,
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/icons/prayer.png'),
              ),
              activeIcon: ImageIcon(
                AssetImage('assets/icons/prayer_active.png'),
              ),
              label: AppLocalizations.of(context)!.navPrayer,
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/icons/compass.png'),
              ),
              activeIcon: ImageIcon(
                AssetImage('assets/icons/compass_active.png'),
              ),
              label: AppLocalizations.of(context)!.navQibla,
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/icons/zikr.png'),
              ),
              activeIcon: ImageIcon(
                AssetImage('assets/icons/zikr_active.png'),
              ),
              label: AppLocalizations.of(context)!.navZikr,
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/icons/books.png'),
              ),
              activeIcon: ImageIcon(
                AssetImage('assets/icons/books_active.png'),
              ),
              label: AppLocalizations.of(context)!.navMore,
            ),
          ],
        ),
      ),
    );
  }
  Widget navIcon(String asset, bool active) {
    return AnimatedScale(
      scale: active ? 1.2 : 1.0,
      duration: const Duration(milliseconds: 200),
      child: ImageIcon(
        AssetImage(asset),
        color: active
            ? const Color(0xFFC8A951)
            : Colors.black45,
      ),
    );
  }
}
