import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NoDataCard extends StatelessWidget {
  final String message;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final Color textColor;
  final double elevation;

  const NoDataCard({
    super.key,
    this.message = 'No data available.',
    this.icon = FontAwesomeIcons.boxOpen,
    this.backgroundColor = const Color(0xFFf8f9fa),
    this.iconColor = const Color(0xFF6c757d),
    this.textColor = const Color(0xFF6c757d),
    this.elevation = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 20.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              icon,
              size: 32.0,
              color: iconColor,
            ),
            SizedBox(height: 12.0),
            Text(
              message,
              style: TextStyle(
                color: textColor,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Usage examples:
/*
NoDataCard() // Basic version

NoDataCard(
  message: 'No items found.',
  icon: FontAwesomeIcons.search,
)

NoDataCard(
  message: 'No connections available',
  icon: FontAwesomeIcons.usersSlash,
  backgroundColor: Colors.blue[50]!,
  iconColor: Colors.blue,
  textColor: Colors.blue[700]!,
)
*/