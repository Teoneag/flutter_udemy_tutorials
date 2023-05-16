import 'package:flutter/material.dart';

class Text1 extends StatelessWidget {
  final _count;
  const Text1(this._count, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _count % 2 == 0 ? const Text('Yaessir') : const Text('Nosir'),
    );
  }
}
