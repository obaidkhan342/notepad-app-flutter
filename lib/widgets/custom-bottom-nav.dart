import 'package:flutter/material.dart';


class CustomBottomNavBar extends StatelessWidget {
  final VoidCallback onFabPressed;
  final VoidCallback onMenuPressed;
  final VoidCallback onSearchPressed;

  const CustomBottomNavBar({
    super.key,
    required this.onFabPressed,
    required this.onMenuPressed,
    required this.onSearchPressed,
  });

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 80,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 60,
            decoration: const BoxDecoration(
              color: Color(0xFF2C2C2C),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white70),
                  onPressed: onMenuPressed,
                ),
                const SizedBox(width: 40),
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.white70),
                  onPressed: onSearchPressed,
                ),
              ],
            ),
          ),
          Positioned(
            top: -20,
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.add, color: Colors.orange),
                onPressed: onFabPressed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
