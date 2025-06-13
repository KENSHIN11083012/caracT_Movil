import 'package:flutter/material.dart';

class LocationSelector extends StatefulWidget {
  final String label;
  final String? value;
  final String? placeholder;
  final List<String> items;
  final Function(String?) onChanged;
  final String? Function(String?)? validator;
  final IconData? prefixIcon;
  final bool enabled;
  final String? parentSelection;

  const LocationSelector({
    super.key,
    required this.label,
    this.value,
    this.placeholder,
    required this.items,
    required this.onChanged,
    this.validator,
    this.prefixIcon,
    this.enabled = true,
    this.parentSelection,
  });

  @override
  State<LocationSelector> createState() => _LocationSelectorState();
}

class _LocationSelectorState extends State<LocationSelector>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _borderColorAnimation;
  late Animation<Color?> _backgroundColorAnimation;
  late Animation<double> _shadowAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.98,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _borderColorAnimation = ColorTween(
      begin: Colors.grey.shade300,
      end: const Color(0xFF4CAF50),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _backgroundColorAnimation = ColorTween(
      begin: Colors.grey.shade50,
      end: Colors.white,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _shadowAnimation = Tween<double>(
      begin: 0.04,
      end: 0.12,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _showLocationPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => LocationPickerModal(
        title: 'Seleccionar ${widget.label}',
        items: widget.items,
        selectedValue: widget.value,
        onSelected: widget.onChanged,
        parentSelection: widget.parentSelection,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              widget.label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF424242),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: widget.enabled ? () => _showLocationPicker(context) : null,
                    onTapDown: (_) {
                      setState(() => _isPressed = true);
                      _animationController.forward();
                    },
                    onTapUp: (_) {
                      setState(() => _isPressed = false);
                      _animationController.reverse();
                    },
                    onTapCancel: () {
                      setState(() => _isPressed = false);
                      _animationController.reverse();
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: _borderColorAnimation.value ?? Colors.grey.shade300,
                          width: _isPressed ? 2.0 : 1.5,
                        ),
                        color: _backgroundColorAnimation.value ?? Colors.grey.shade50,
                        boxShadow: widget.enabled ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: _shadowAnimation.value),
                            offset: const Offset(0, 2),
                            blurRadius: _isPressed ? 12 : 8,
                            spreadRadius: 0,
                          ),
                        ] : [],
                      ),
                      child: Row(
                        children: [
                          if (widget.prefixIcon != null) ...[
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: widget.enabled 
                                    ? const Color(0xFF4CAF50).withValues(alpha: _isPressed ? 0.15 : 0.1)
                                    : Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                widget.prefixIcon,
                                color: widget.enabled 
                                    ? const Color(0xFF4CAF50) 
                                    : Colors.grey.shade400,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 16),
                          ],
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.value ?? widget.placeholder ?? 'Seleccionar ${widget.label}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: widget.value != null 
                                        ? const Color(0xFF2C3E50)
                                        : Colors.grey.shade600,
                                  ),
                                ),
                                if (widget.parentSelection != null) ...[
                                  const SizedBox(height: 4),
                                  Text(
                                    widget.parentSelection!,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade500,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(4),
                            child: AnimatedRotation(
                              turns: _isPressed ? 0.5 : 0.0,
                              duration: const Duration(milliseconds: 200),
                              child: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: widget.enabled 
                                    ? const Color(0xFF4CAF50)
                                    : Colors.grey.shade400,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class LocationPickerModal extends StatefulWidget {
  final String title;
  final List<String> items;
  final String? selectedValue;
  final Function(String?) onSelected;
  final String? parentSelection;

  const LocationPickerModal({
    super.key,
    required this.title,
    required this.items,
    this.selectedValue,
    required this.onSelected,
    this.parentSelection,
  });

  @override
  State<LocationPickerModal> createState() => _LocationPickerModalState();
}

class _LocationPickerModalState extends State<LocationPickerModal> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<String> _filteredItems = [];
  final Map<String, GlobalKey> _alphabetKeys = {};

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
    _createAlphabetKeys();
  }

  void _createAlphabetKeys() {
    final alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');
    for (String letter in alphabet) {
      _alphabetKeys[letter] = GlobalKey();
    }
  }

  void _filterItems(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredItems = widget.items;
      } else {
        _filteredItems = widget.items
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _scrollToLetter(String letter) {
    final key = _alphabetKeys[letter];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Handle indicator
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(top: 8, bottom: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  offset: const Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.grey.shade100,
                        foregroundColor: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Breadcrumb
                if (widget.parentSelection != null) ...[
                  Row(
                    children: [
                      Text(
                        widget.parentSelection!,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.grey.shade600,
                        size: 16,
                      ),
                      Text(
                        widget.selectedValue ?? 'Seleccionar',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
                // Search Field
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Buscar ${widget.title.toLowerCase()}',
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey.shade600,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    onChanged: _filterItems,
                  ),
                ),
              ],
            ),
          ),
          // Content
          Expanded(
            child: Row(
              children: [
                // Main List
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: _filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = _filteredItems[index];
                      final isSelected = item == widget.selectedValue;
                      final firstLetter = item[0].toUpperCase();
                      
                      // Check if this is the first item with this letter
                      final isFirstWithLetter = index == 0 || 
                          _filteredItems[index - 1][0].toUpperCase() != firstLetter;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Letter Header
                          if (isFirstWithLetter) ...[
                            Container(
                              key: _alphabetKeys[firstLetter],
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 8,
                              ),
                              child: Text(
                                firstLetter,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                          ],
                          // Item
                          InkWell(
                            onTap: () {
                              widget.onSelected(item);
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 16,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected 
                                    ? const Color(0xFF4CAF50).withValues(alpha: 0.1)
                                    : null,
                                border: isSelected 
                                    ? const Border(
                                        left: BorderSide(
                                          color: Color(0xFF4CAF50),
                                          width: 3,
                                        ),
                                      )
                                    : null,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: isSelected 
                                            ? FontWeight.w500 
                                            : FontWeight.normal,
                                        color: isSelected 
                                            ? const Color(0xFF4CAF50) 
                                            : Colors.black87,
                                      ),
                                    ),
                                  ),
                                  if (isSelected)
                                    const Icon(
                                      Icons.check_circle,
                                      color: Color(0xFF4CAF50),
                                      size: 20,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                // Alphabet Index
                Container(
                  width: 30,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
                        .split('')
                        .map((letter) {
                          final hasItems = _filteredItems.any(
                            (item) => item[0].toUpperCase() == letter
                          );
                          
                          return Expanded(
                            child: GestureDetector(
                              onTap: hasItems ? () => _scrollToLetter(letter) : null,
                              child: Container(
                                alignment: Alignment.center,
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: hasItems 
                                        ? Colors.transparent
                                        : null,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    letter,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: hasItems 
                                          ? FontWeight.w600 
                                          : FontWeight.normal,
                                      color: hasItems 
                                          ? const Color(0xFF4CAF50)
                                          : Colors.grey.shade400,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        })
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
