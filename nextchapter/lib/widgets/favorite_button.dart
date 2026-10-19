import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Кнопка-сердечко «в любимое».
/// Хранит своё состояние и обновляет его через setState().
class FavoriteButton extends StatefulWidget {
  const FavoriteButton({
    super.key,
    this.initialValue = false,
    this.onChanged,
    this.size = 22,
  });

  final bool initialValue;
  final ValueChanged<bool>? onChanged;
  final double size;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  late bool _isFavorite = widget.initialValue;

  void _toggle() {
    setState(() => _isFavorite = !_isFavorite);
    widget.onChanged?.call(_isFavorite);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 2,
      shadowColor: AppColors.shadow,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: _toggle,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (child, animation) =>
                ScaleTransition(scale: animation, child: child),
            child: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              key: ValueKey(_isFavorite),
              size: widget.size,
              color: _isFavorite ? AppColors.heart : AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}
