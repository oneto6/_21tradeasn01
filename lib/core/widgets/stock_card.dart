import 'package:_21tradeasn01/core/model/stock.dart';
import 'package:flutter/material.dart';

class StockCard extends StatelessWidget {
  const StockCard(this.stock, {super.key});

  final Stock stock;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorScheme = theme.colorScheme;

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 100),
      child: AspectRatio(
        aspectRatio: 21 / 4,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(
                    stock.name,
                    style: textTheme.titleLarge?.copyWith(
                      color: colorScheme.outline,
                    ),
                  ),

                  Column(
                    crossAxisAlignment: .end,
                    mainAxisAlignment: .spaceAround,
                    children: [
                      Text(
                        "₹${stock.price.toStringAsFixed(2)}",
                        style: textTheme.titleMedium,
                      ),
                      Text(
                        "${(stock.change * 100).toStringAsFixed(2)}%",
                        style: textTheme.titleMedium?.copyWith(
                          color: stock.change < 0 ? Colors.red : Colors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
