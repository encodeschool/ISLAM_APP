import 'package:flutter/material.dart';

class GenderButton extends StatelessWidget {
  final String label;                // "Male" or "Female"
  final String imagePath;            // path to your PNG e.g. 'assets/icons/male.png'
  final bool isSelected;
  final VoidCallback onTap;
  final Color selectedBgColor;
  final Color selectedIconColor;     // tint color when selected
  final Color unselectedIconColor;

  const GenderButton({
    super.key,
    required this.label,
    required this.imagePath,
    required this.isSelected,
    required this.onTap,
    this.selectedBgColor = const Color(0xFF4CAF50),      // green - change as you like
    this.selectedIconColor = Colors.white,
    this.unselectedIconColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? selectedBgColor
              : theme.cardColor,           // or Colors.grey[100]/200 in light mode
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? selectedBgColor
                : Colors.grey.shade300,
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: selectedBgColor.withOpacity(0.35),
              blurRadius: 12,
              offset: const Offset(0, 6),
            )
          ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Icon / PNG with color filter (tint)
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                isSelected ? selectedIconColor : unselectedIconColor,
                BlendMode.srcIn,   // this tints the entire PNG
              ),
              child: Image.asset(
                imagePath,
                width: 25,
              ),
            ),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? selectedIconColor        // white text on colored bg
                    : theme.textTheme.bodyMedium?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}