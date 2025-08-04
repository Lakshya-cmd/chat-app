import 'package:calling_app/Widgets/primaryButton.dart';
import 'package:flutter/material.dart';

class UserUpdateProfileScreen extends StatelessWidget {
  const UserUpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.primaryContainer),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color:
                                    Theme.of(context).colorScheme.background),
                            child: const Center(
                              child: Icon(Icons.photo),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Text(
                                "Personal Info",
                                style: Theme.of(context).textTheme.labelMedium,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                "Name",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const TextField(
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: "Name",
                              prefixIcon: Icon(Icons.person),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                "Email",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const TextField(
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: "Email",
                              prefixIcon: Icon(Icons.alternate_email_rounded),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                "Phone",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const TextField(
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: "3156456567",
                              prefixIcon: Icon(Icons.phone),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              PrimaryButton(
                                  btnName: "Save",
                                  icon: Icons.save,
                                  onTap: () {}),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
