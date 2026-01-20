import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/audio_service.dart';
import '../../l10n/app_localizations.dart';
import '../../data/allah_names.dart';
import '../../providers/daily_card_provider.dart';
import '../../widgets/allah_name_card.dart';
import '../../models/allah_name.dart';

class NinetyNineNames extends StatefulWidget {
  const NinetyNineNames({super.key});

  @override
  State<NinetyNineNames> createState() => _NinetyNineNamesState();
}

class _NinetyNineNamesState extends State<NinetyNineNames> {
  String query = "";
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    final filtered = allahNames.where((n) {
      final q = query.toLowerCase();
      return n.arabic.contains(query) ||
          n.transliteration.toLowerCase().contains(q) ||
          n.meaning.toLowerCase().contains(q);
    }).toList();

    final daily = context.watch<DailyCardProvider>();
    final today = daily.todayName;

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(t.namesOfAllah),
      ),
        body: CustomScrollView(
          slivers: [
            // 🔍 Search
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: t.search,
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() => query = value);
                  },
                ),
              ),
            ),

            // 🌙 Daily Name Card (NOT FIXED ANYMORE)
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.green[100]?.withOpacity(0.3),
                  border: Border.all(
                    color: Color.fromRGBO(0, 100, 0, 0.5),
                    width: 2
                  )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Daily Random Name to learn',
                      style: TextStyle(
                          fontFamily: 'Amiri',
                          fontSize: 12,
                          color: Colors.grey[700]
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12),
                    Text(
                      today.arabic,
                      style: TextStyle(
                        fontFamily: 'Amiri',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[900]
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      today.transliteration,
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.green[900]
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      today.meaning,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.green[900]
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.volume_up_outlined),
                      onPressed: () => AudioService.play(today.audioAsset),
                    ),
                  ],
                ),
              ),
            ),

            // 📦 Grid
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                      (_, index) {
                    final name = filtered[index];
                    return AllahNameCard(
                      name: name,
                      onTap: () => _openDetails(context, name),
                    );
                  },
                  childCount: filtered.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.85,
                ),
              ),
            ),
          ],
        ),
    );
  }

  void _openDetails(BuildContext context, AllahName name) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              name.arabic,
              style: const TextStyle(
                fontFamily: 'Amiri',
                fontSize: 36,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              name.transliteration,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              name.meaning,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
