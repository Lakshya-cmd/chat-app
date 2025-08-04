import 'dart:developer';

import 'package:flutter/material.dart';

class ContactSearch extends StatelessWidget {
  const ContactSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            textInputAction: TextInputAction.search,
            onSubmitted: (value) => {
              log(value),
            },
            decoration: InputDecoration(
              filled: false,
              hintText: "Search contact",
              hintStyle: Theme.of(context).textTheme.labelLarge,
              prefixIcon: const Icon(Icons.search),
            ),
          ))
        ],
      ),
    );
  }
}
