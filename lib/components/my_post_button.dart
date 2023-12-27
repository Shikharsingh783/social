import 'package:flutter/material.dart';

class PostButton extends StatelessWidget {
  const PostButton({super.key, this.ontap});
  final void Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12)
        ),
        padding:const EdgeInsets.all(20),
        margin: const EdgeInsets.only(left:10),
        child: Center(child: Icon(Icons.done,color: Theme.of(context).colorScheme.primary,)),
      ),    );
  }
}