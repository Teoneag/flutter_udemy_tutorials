import 'package:flutter/material.dart';

class Resoult extends StatelessWidget {
  final int resoultScore;
  final VoidCallback resetHandler;

  const Resoult(this.resoultScore, this.resetHandler, {super.key});

  String? get resultPhrase {
    String resultText;
    if (resoultScore <= 8) {
      resultText = ' U\'re awesome and innocnet';
    } else if (resoultScore <= 12) {
      resultText = 'Pretty likeable!';
    } else if (resoultScore <= 16) {
      resultText = 'You are ... strange?!';
    } else {
      resultText = 'You are so bad!';
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            resultPhrase!,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          TextButton(
            onPressed: resetHandler,
            child: const Text('Restart quiz'),
          )
        ],
      ),
    );
  }
}
