import 'package:flutter/material.dart';

import '../controllers/audio_controller.dart';

class VolumeBar extends StatelessWidget {
  final AudioController controller;
  const VolumeBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, widget) {
        return Container(
          width: 120,
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: const BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                  child: LinearProgressIndicator(
                    value: controller.volumePercent,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color.fromARGB(82, 1, 255, 13),
                    ),
                    backgroundColor: const Color.fromARGB(34, 214, 214, 214),
                  ),
                ),
              ),
              Positioned.fill(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () => controller.volume(false),
                      child: const Icon(
                        Icons.remove,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => controller.mute(),
                      child: Icon(
                        controller.volumeIcon,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => controller.volume(true),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
