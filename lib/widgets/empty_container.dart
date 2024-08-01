import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmptyContainer extends StatelessWidget {
  const EmptyContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset('assets/illustration-empty.svg'),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            'Results shown here',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.white),
          ),
        ),
        Text(
          'Complete the form and click "calculate repayments" to see what your monthly repayments would be.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white60,
              ),
        )
      ],
    );
  }
}
