import 'package:flutter/material.dart';

aboutUs(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor:  const Color.fromARGB(255, 210, 209, 209),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Text(
              'About Us',
              style: TextStyle(fontSize: 22),
            ),
            content: const Text(
              "CookBook is a recipe app designed to help users discover new and delicious recipes to cook at home. Our mission is to make cooking easy and accessible for everyone, whether you're an experienced chef or just starting out in the kitchen.",
              style: TextStyle(fontSize: 16),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Close',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black
                    ),
                  ))
            ],
          ));
}
