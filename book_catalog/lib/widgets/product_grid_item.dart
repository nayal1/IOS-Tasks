
import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductGridItem extends StatelessWidget {
  final Product product;

  const ProductGridItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFEFE2D3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  product.icon,
                  size: 55,
                  color: const Color(0xFF795548),
                ),
              ),
            ),

            const SizedBox(height: 10),

            Text(
              product.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4E342E),
              ),
            ),

            const SizedBox(height: 5),

            Text(
              product.category,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 6),

            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Color(0xFFE0A43B),
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  product.rating.toString(),
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),

            const SizedBox(height: 6),

            Text(
              '${product.price.toStringAsFixed(0)} ₸',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF795548),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
