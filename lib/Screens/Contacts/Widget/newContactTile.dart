import 'package:flutter/material.dart';

class NewContactTile extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final IconData icon;
  const NewContactTile(
      {super.key, required this.text, required this.onTap, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.primaryContainer),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Center(
              child: Icon(icon,
                  size: 25, color: Theme.of(context).colorScheme.onBackground)),
        ),
        title: Text(
          "New  $text",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
