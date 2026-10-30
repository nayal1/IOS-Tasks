
import 'package:flutter/material.dart';

import '../models/product.dart';
import '../widgets/product_list_item.dart';
import '../widgets/product_grid_item.dart';
import '../widgets/empty_state.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  // Current catalog
  List<Product> _products = List.from(initialProducts);

  // Controls List or Grid view
  bool _isGridView = false;

  // ID for newly generated products
  int _nextId = 9;

  // Pull-to-refresh logic
  Future<void> _refreshProducts() async {
    // Simulates a network request
    await Future.delayed(
      const Duration(milliseconds: 1500),
    );

    final newProduct = Product(
      id: _nextId,
      title: 'New Arrival #$_nextId',
      category: 'New Books',
      rating: 4.8,
      price: 5500,
      icon: Icons.auto_stories,
    );

    _nextId++;

    setState(() {
      // Adds the new product to the beginning
      _products.insert(0, newProduct);
    });
  }

  // Swipe-to-delete and Undo logic
  void _deleteProduct(Product product, int index) {
    setState(() {
      _products.removeWhere(
        (item) => item.id == product.id,
      );
    });

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.title} deleted'),
        duration: const Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'UNDO',
          textColor: Colors.amber,
          onPressed: () {
            setState(() {
              // Restores the product to its original position
              final restoreIndex = index.clamp(
                0,
                _products.length,
              );

              _products.insert(restoreIndex, product);
            });
          },
        ),
      ),
    );
  }

  // Restores the original catalog
  void _resetCatalog() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    setState(() {
      _products = List.from(initialProducts);
      _nextId = 9;
    });
  }

  // Creates a Dismissible item for List view
  
Widget _buildListItem(Product product, int index) {
  return Dismissible(
    key: ValueKey(product.id),
    direction: DismissDirection.endToStart,

    background: Container(
      color: Colors.red,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 24),
      child: const Icon(
        Icons.delete,
        color: Colors.white,
        size: 30,
      ),
    ),

    secondaryBackground: Container(
      color: Colors.red,
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 24),
      child: const Icon(
        Icons.delete,
        color: Colors.white,
        size: 30,
      ),
    ),

    onDismissed: (direction) {
      _deleteProduct(product, index);
    },

    child: ProductListItem(product: product),
  );
}


  // Creates a Dismissible item for Grid view
  Widget _buildGridItem(Product product, int index) {
    return Dismissible(
      key: ValueKey(product.id),
      direction: DismissDirection.endToStart,

      background: Container(
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(14),
      ),
    ),

      secondaryBackground: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(14),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 30,
        ),
      ),

      onDismissed: (direction) {
        _deleteProduct(product, index);
      },

      child: ProductGridItem(product: product),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Smart Book Catalog',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF4E342E),
          ),
        ),

        actions: [
          IconButton(
            tooltip: _isGridView ? 'List view' : 'Grid view',
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
            icon: Icon(
              _isGridView
                  ? Icons.view_list
                  : Icons.grid_view,
              color: const Color(0xFF795548),
            ),
          ),
        ],
      ),

      body: _products.isEmpty
          ? EmptyState(onReset: _resetCatalog)
          : RefreshIndicator(
              color: const Color(0xFF795548),
              onRefresh: _refreshProducts,

              child: _isGridView
                  ? GridView.builder(
                      physics:
                          const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(12),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.72,
                      ),
                      itemCount: _products.length,
                      itemBuilder: (context, index) {
                        final product = _products[index];

                        return _buildGridItem(product, index);
                      },
                    )
                  : ListView.separated(
                      physics:
                          const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                      ),
                      itemCount: _products.length,
                      separatorBuilder: (context, index) {
                        return const Divider(
                          height: 1,
                          thickness: 1,
                          color: Color(0xFFE5D8CC),
                        );
                      },
                      itemBuilder: (context, index) {
                        final product = _products[index];

                        return _buildListItem(product, index);
                      },
                    ),
            ),
    );
  }
}
