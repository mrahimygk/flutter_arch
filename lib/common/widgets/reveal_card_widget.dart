import 'package:flutter/material.dart';

class RevealAnimatedCardWidget extends StatefulWidget {
  final Widget innerWidget;
  final Widget outerWidget;

  final VoidCallback? onReveal;
  final VoidCallback? onHide;

  const RevealAnimatedCardWidget(
      {Key? key,
      required this.innerWidget,
      required this.outerWidget,
      this.onReveal,
      this.onHide})
      : super(key: key);

  @override
  State<RevealAnimatedCardWidget> createState() => RevealAnimatedCardState();
}

class RevealAnimatedCardState extends State<RevealAnimatedCardWidget> {
  double height = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Column(
            children: [
              AnimatedContainer(
                curve: Curves.fastOutSlowIn,
                duration: Duration(milliseconds: 313),
                height: height,
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Card(
                  child: isRevealed() ? widget.innerWidget : Container(),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTapUp: (d) {
              toggleReveal();
            },
            child: Card(
              child: widget.outerWidget,
            ),
          ),
        ],
      ),
    );
  }

  void toggleReveal() {
    setState(() {
      final isRevealCommand = height == 0;
      height = isRevealCommand ? 100 : 0;
      if (isRevealCommand) {
        widget.onReveal?.call();
      } else {
        widget.onHide?.call();
      }
    });
  }

  bool isRevealed() => height != 0;
}
