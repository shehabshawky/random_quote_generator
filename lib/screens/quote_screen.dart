import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../data/quote_repository.dart';
import '../models/quote_model.dart';
import '../theme/app_theme.dart';
import '../widgets/favorites_sheet.dart';
import '../widgets/quote_card.dart';

class QuoteScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final bool isDarkMode;

  const QuoteScreen({
    super.key,
    required this.onToggleTheme,
    required this.isDarkMode,
  });

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> with SingleTickerProviderStateMixin {
  late Quote _currentQuote;
  String _selectedCategory = 'All';
  final List<Quote> _favorites = [];
  int _quotesSeenCount = 1;
  late AnimationController _buttonAnimController;

  @override
  void initState() {
    super.initState();
    _buttonAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    // Display a random quote every time the app opens
    _currentQuote = QuoteRepository.getRandomQuote();
  }

  @override
  void dispose() {
    _buttonAnimController.dispose();
    super.dispose();
  }

  void _getNewQuote() {
    HapticFeedback.mediumImpact();
    _buttonAnimController.forward(from: 0.0);

    setState(() {
      _currentQuote = QuoteRepository.getRandomQuote(
        category: _selectedCategory,
        currentQuote: _currentQuote,
      );
      _quotesSeenCount++;
    });
  }

  void _onCategoryChanged(String category) {
    if (_selectedCategory == category) return;
    HapticFeedback.selectionClick();
    setState(() {
      _selectedCategory = category;
      _currentQuote = QuoteRepository.getRandomQuote(
        category: _selectedCategory,
        currentQuote: _currentQuote,
      );
      _quotesSeenCount++;
    });
  }

  void _toggleFavorite() {
    HapticFeedback.lightImpact();
    setState(() {
      final exists = _favorites.any((q) => q.id == _currentQuote.id);
      if (exists) {
        _favorites.removeWhere((q) => q.id == _currentQuote.id);
      } else {
        _favorites.add(_currentQuote);
      }
    });
  }

  void _openFavoritesSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setSheetState) {
          return FavoritesSheet(
            favorites: _favorites,
            onRemoveFavorite: (quote) {
              setState(() {
                _favorites.removeWhere((q) => q.id == quote.id);
              });
              setSheetState(() {});
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDarkMode;
    final textPrimary = isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary;
    final textSecondary = isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary;
    final isFavorite = _favorites.any((q) => q.id == _currentQuote.id);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.format_quote_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Daily Quotes',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: textPrimary,
                              letterSpacing: -0.3,
                            ),
                          ),
                          Text(
                            'Find your spark',
                            style: TextStyle(
                              fontSize: 12,
                              color: textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      // Favorites sheet button with badge
                      Stack(
                        children: [
                          IconButton(
                            onPressed: _openFavoritesSheet,
                            icon: const Icon(Icons.bookmark_outline_rounded),
                            color: textSecondary,
                            tooltip: 'Saved Quotes',
                          ),
                          if (_favorites.isNotEmpty)
                            Positioned(
                              top: 6,
                              right: 6,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: AppTheme.accentColor,
                                  shape: BoxShape.circle,
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 16,
                                  minHeight: 16,
                                ),
                                child: Text(
                                  '${_favorites.length}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      // Theme Switcher button
                      IconButton(
                        onPressed: widget.onToggleTheme,
                        icon: Icon(
                          isDark
                              ? Icons.wb_sunny_outlined
                              : Icons.dark_mode_outlined,
                        ),
                        color: textSecondary,
                        tooltip: isDark ? 'Light Mode' : 'Dark Mode',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 6),

            // Horizontal Category Selector
            SizedBox(
              height: 38,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: QuoteRepository.categories.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final cat = QuoteRepository.categories[index];
                  final isSelected = _selectedCategory == cat;
                  return GestureDetector(
                    onTap: () => _onCategoryChanged(cat),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppTheme.primaryColor
                            : (isDark
                                ? AppTheme.darkSurface
                                : AppTheme.lightBorder.withValues(alpha: 0.5)),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? AppTheme.primaryColor
                              : (isDark ? AppTheme.darkBorder : Colors.transparent),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          cat,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                            color: isSelected
                                ? Colors.white
                                : (isDark
                                    ? AppTheme.darkTextSecondary
                                    : AppTheme.lightTextSecondary),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Main Quote Display Area (Scrollable to prevent overflow on small screens)
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Swipeable & Animated Quote Card
                      GestureDetector(
                        onHorizontalDragEnd: (details) {
                          if (details.primaryVelocity != null &&
                              details.primaryVelocity!.abs() > 200) {
                            _getNewQuote();
                          }
                        },
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 350),
                          switchInCurve: Curves.easeOutCubic,
                          switchOutCurve: Curves.easeInCubic,
                          transitionBuilder: (child, animation) {
                            return FadeTransition(
                              opacity: animation,
                              child: SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(0.0, 0.05),
                                  end: Offset.zero,
                                ).animate(animation),
                                child: child,
                              ),
                            );
                          },
                          child: QuoteCard(
                            key: ValueKey<String>(_currentQuote.id),
                            quote: _currentQuote,
                            isFavorite: isFavorite,
                            onToggleFavorite: _toggleFavorite,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // UX micro-interactions hint
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.swipe_rounded,
                            size: 14,
                            color: textSecondary.withValues(alpha: 0.6),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Swipe or double-tap card to like',
                            style: TextStyle(
                              fontSize: 12,
                              color: textSecondary.withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Bottom Action Area
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
              child: Column(
                children: [
                  // Prominent New Quote Button
                  Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryColor.withValues(alpha: 0.35),
                          blurRadius: 18,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      key: const Key('new_quote_button'),
                      onPressed: _getNewQuote,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RotationTransition(
                            turns: _buttonAnimController,
                            child: const Icon(
                              Icons.refresh_rounded,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'New Quote',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Subtle session stats info
                  Text(
                    '$_quotesSeenCount quotes explored this session',
                    style: TextStyle(
                      fontSize: 12,
                      color: textSecondary.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
