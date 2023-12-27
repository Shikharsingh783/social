import 'package:flutter/material.dart';

 class Back extends StatelessWidget {
  const Back({super.key});

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: ()=> Navigator.pop(context),
      child: Container(
        child: Icon(Icons.arrow_back,color: Theme.of(context).colorScheme.inversePrimary,),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:Theme.of(context).colorScheme.primary,
        ),
        padding: EdgeInsets.all(10),
      ),
    );
  }
}