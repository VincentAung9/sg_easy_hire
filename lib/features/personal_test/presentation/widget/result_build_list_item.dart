import 'package:flutter/material.dart';

class ResultBuildListItem extends StatelessWidget {
  const ResultBuildListItem({
    super.key,
    required this.items,
    required this.iconName,
  });
  final List<dynamic> items;
  final String? iconName;
  @override
  Widget build(BuildContext context) {
    IconData icon;
    switch (iconName) {
      case 'check_circle_outline':
        icon = Icons.check_circle_outline;
        break;
      case 'error_outline':
        icon = Icons.error_outline;
        break;
      case 'work_outline':
        icon = Icons.work_outline;
        break;
      default:
        icon = Icons.info_outline; // Default icon
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...items
            .map(
              (item) => ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: Icon(icon),
                title: Text(item as String),
              ),
            )
            .toList(),
      ],
    );
  }
}
