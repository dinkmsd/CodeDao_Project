import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget(
      {super.key,
      required this.imagePath,
      required this.onClicked,
      required this.icon});
  final String imagePath;
  final IconData icon;
  final VoidCallback onClicked;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(
      children: [
        ClipOval(
          child: Material(
            color: Colors.transparent,
            child: Ink.image(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
              width: 130,
              height: 130,
            ),
          ),
        ),
        Positioned(
            bottom: 0,
            right: 4,
            child: ClipOval(
              child: Container(
                padding: const EdgeInsets.all(3),
                color: Colors.white,
                child: ClipOval(
                  child: Container(
                      padding: const EdgeInsets.all(6),
                      color: Colors.black,
                      child: InkWell(
                          onTap: onClicked,
                          child: Icon(
                            icon,
                            size: 20,
                            color: Colors.white,
                          ))),
                ),
              ),
            ))
      ],
    ));
  }
}
