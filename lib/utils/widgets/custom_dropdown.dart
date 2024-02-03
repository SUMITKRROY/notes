import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> options;
  final int selectedIndex;
  final Function(int) onIndexSelected;
  final bool? disabled;
  final bool? isExpanded;

  const CustomDropdown({
    Key? key,
    required this.options,
    required this.onIndexSelected,
    this.selectedIndex = -1,
    this.disabled,
    this.isExpanded,
  }) : super(key: key);

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  late int selectedOptionIndex;

  @override
  void initState() {
    super.initState();
    selectedOptionIndex = widget.selectedIndex;
  }

  void _showOptionsBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      useSafeArea: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                for (int index = 0; index < widget.options.length; index++)
                  ListTile(
                    title: Text(
                      widget.options[index],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        selectedOptionIndex = index;
                      });
                      widget.onIndexSelected(index);
                      Navigator.pop(context);
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        InkWell(
          onTap: widget.disabled ?? false ? null : _showOptionsBottomSheet,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.options.isEmpty
                  ? Text("select value")
                  : Text(
                widget.disabled ?? false || widget.options.isEmpty
                    ? "Action Denied"
                    : selectedOptionIndex != -1
                    ? widget.options[selectedOptionIndex]
                    : "Select value",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 18.0,
                ),
              ),
              Icon(
                Icons.arrow_drop_down,
                size: 18.0,
                color: Colors.grey,
              )
            ],
          ),
        ),
      ],
    );
  }
}
