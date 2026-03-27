import 'package:flutter/material.dart';
import 'package:mosque/pages/home_page.dart';

import '../../l10n/app_localizations.dart';

class HalalThingsMenuPage extends StatefulWidget {
  const HalalThingsMenuPage({super.key});

  @override
  State<HalalThingsMenuPage> createState() => _HalalThingsMenuPageState();
}

class _HalalThingsMenuPageState extends State<HalalThingsMenuPage> {

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          t.halal
        ),
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _HalalTile(
            icon: 'assets/icons/halal.png',
            title: 't.',
            subtitle: 't.',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => HomePage()
                )
              );
            },
          )
        ],
      ),
    );
  }
}

class _HalalTile extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _HalalTile({super.key, required this.icon, required this.title, required this.subtitle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10
          )
        ]
      ),
      child: ListTile(
        leading: Image.asset(
            icon
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
        ),
        onTap: onTap,
      ),
    );
  }
}
