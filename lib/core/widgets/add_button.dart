import 'package:flutter/material.dart';

class ShakeButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final Color color;
  final bool isAnimating;

  const ShakeButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.color,
    this.isAnimating = false,
  });

  @override
  _ShakeButtonState createState() => _ShakeButtonState();
}

class _ShakeButtonState extends State<ShakeButton>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> shakeAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    shakeAnimation = Tween<double>(begin: 0.0, end: 16).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.bounceInOut,
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          animationController.stop();
          setState(() {});
        }
      });

    if (widget.isAnimating) {
      animationController.forward();
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([animationController]),
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
              shakeAnimation.value *
                  (animationController.value <= 0.5 ? -1 : 1),
              0),
          child: child,
        );
      },
      child: InkWell(
        radius: 40,
        onTap: () {
          widget.onPressed();
          if (!widget.isAnimating) {
            animationController.forward();
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          decoration: BoxDecoration(
            color: animationController.isAnimating ? Colors.red : widget.color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.text,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const Icon(Icons.add, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
