import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../providers/counter_provider.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = context.watch<CounterProvider>();
    final t = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),

          // 🔹 HEADER
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left: Reset icon
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: counter.reset,
                  tooltip: t.reset,
                ),

                // Center: Count / Limit
                Text(
                  "${counter.count} / ${counter.limit}",
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Right: Dropdown with presets
                _presetDropdown(context, counter, t),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // 🔹 TAP AREA
          GestureDetector(
            onTap: counter.increment,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green[900],
              ),
              child: Center(
                child: Text(
                  t.tap,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Dropdown for presets
  Widget _presetDropdown(BuildContext context, CounterProvider counter, AppLocalizations t) {
    final items = [33, 99, -1]; // -1 for custom
    return DropdownButton<int>(
      value: counter.limit > 0 && (counter.limit == 33 || counter.limit == 99)
          ? counter.limit
          : -1,
      items: items.map((value) {
        String text;
        if (value == -1) text = t.custom;
        else text = "$value";
        return DropdownMenuItem<int>(
          value: value,
          child: Text(text),
        );
      }).toList(),
      onChanged: (value) async {
        if (value == null) return;

        if (value == -1) {
          // Custom value dialog
          final controller = TextEditingController();
          final result = await showDialog<int>(
            context: context,
            builder: (_) => AlertDialog(
              title: Text(t.setCustomZikr),
              content: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration:
                InputDecoration(hintText: t.enterNumber),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(t.cancel),
                ),
                TextButton(
                  onPressed: () {
                    final val = int.tryParse(controller.text);
                    if (val != null && val > 0) {
                      Navigator.pop(context, val);
                    }
                  },
                  child: Text(t.ok),
                ),
              ],
            ),
          );
          if (result != null) counter.setLimit(result);
        } else {
          counter.setLimit(value);
        }
      },
    );
  }
}
