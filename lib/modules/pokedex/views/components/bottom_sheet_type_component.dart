import 'package:flutter/material.dart';
import 'package:rama_poke_app/core/shared/models/pokemon_model.dart';
import 'package:rama_poke_app/modules/pokedex/views/components/element_chips_component.dart';

class BottomSheetTypeComponent extends StatefulWidget {
  final TypeOfPokemon? initialSelected;
  final void Function(TypeOfPokemon? selectedType)? onTypeSelected;

  const BottomSheetTypeComponent({
    super.key,
    this.initialSelected,
    this.onTypeSelected,
  });

  @override
  State<BottomSheetTypeComponent> createState() =>
      _BottomSheetTypeComponentState();
}

class _BottomSheetTypeComponentState extends State<BottomSheetTypeComponent> {
  TypeOfPokemon? _selectedType;

  @override
  void initState() {
    super.initState();
    _selectedType = widget.initialSelected;
  }

  void _onTypeSelect(TypeOfPokemon type) {
    setState(() {
      // Toggle selection - if same type is selected, deselect it
      if (_selectedType == type) {
        _selectedType = null;
      } else {
        _selectedType = type;
      }

      // Notify parent with the selected type
      widget.onTypeSelected?.call(_selectedType);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header with title and close button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Select Types",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Type selection chips
          ElementChipsComponent(
            elements: TypeOfPokemon.values,
            selectedElements:
                _selectedType != null ? {_selectedType!} : <TypeOfPokemon>{},
            onSelected: _onTypeSelect,
            allowMultipleSelection: false,
            size: ChipSize.big,
          ),

          const SizedBox(height: 16),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _selectedType = null;
                      widget.onTypeSelected?.call(null);
                    });
                  },
                  child: const Text('Clear'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
