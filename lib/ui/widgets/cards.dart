import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../utils/color_constants.dart';

class PurposeCard extends StatefulWidget {
  final String title;
  final String desc;
  final Icon icon;
  final bool isSelected;
  final VoidCallback onPressed;
  final Size size;
  const PurposeCard({
    Key? key,
    required this.title,
    required this.desc,
    required this.icon,
    required this.isSelected,
    required this.onPressed,
    required this.size,
  }) : super(key: key);

  @override
  _PurposeCardState createState() => _PurposeCardState();
}

class _PurposeCardState extends State<PurposeCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        padding: const EdgeInsets.all(10),
        height: widget.size.height * 0.21,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: widget.isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary,
          ),
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: widget.isSelected
                        ? Colors.white
                        : Theme.of(context).colorScheme.secondary,
                    radius: 30,
                    child: widget.icon,
                  ),
                ),
                SizedBox(
                  width: widget.size.width * .55,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.title,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: widget.isSelected
                                      ? Colors.white
                                      : Theme.of(context).colorScheme.secondary,
                                ),
                        maxLines: 2,
                      )),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AutoSizeText(
                widget.desc,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: widget.isSelected
                          ? Colors.white
                          : Theme.of(context).colorScheme.secondary,
                    ),
                maxLines: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
