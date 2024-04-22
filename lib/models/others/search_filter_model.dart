import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:netflix/components/buttons/other_buttons/bottom_sheet_buttons.dart';
import 'package:netflix/components/buttons/other_buttons/choosing_button.dart';

class SearchFilterModal extends StatefulWidget {
  const SearchFilterModal({super.key});

  @override
  State<SearchFilterModal> createState() => _SearchFilterModalState();
}

class _SearchFilterModalState extends State<SearchFilterModal> {
  final TextEditingController _releaseYear = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _releaseYear.dispose();
  }

  int _selectCategory = 0;
  int _selectAdult = 0;
  int releaseYear = 0;
  bool errorArise = false;

  void _selectCategoryPressed(int value) {
    setState(() {
      _selectCategory = value;
    });
  }

  void _selectAdultPresssed(int value) {
    setState(() {
      _selectAdult = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    Size mySize = MediaQuery.sizeOf(context);
    TextTheme myTextTheme = Theme.of(context).textTheme;
    return Container(
      height: mySize.height * 0.7,
      decoration: BoxDecoration(
        color: myColorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: ListView(
        children: [
          Icon(
            Icons.horizontal_rule_rounded,
            size: 56,
            color: Colors.grey.shade400,
          ),
          Text(
            "Sort & Filter",
            textAlign: TextAlign.center,
            style: myTextTheme.headlineSmall!.copyWith(
              color: myColorScheme.onTertiary,
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _Topics(title: "Categories"),
                SizedBox(height: mySize.height / 88),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ChoosingItemButton(
                      text: "Movie",
                      isFilled: _selectCategory == 1 ? true : false,
                      buttonPressed: () {
                        _selectCategoryPressed(1);
                        setState(() {
                          errorArise = false;
                        });
                      },
                    ),
                    SizedBox(width: mySize.width / 20),
                    ChoosingItemButton(
                      text: "TV Show",
                      isFilled: _selectCategory == 2 ? true : false,
                      buttonPressed: () {
                        _selectCategoryPressed(2);
                        setState(() {
                          errorArise = false;
                        });
                      },
                    ),
                    SizedBox(width: mySize.width / 20),
                    ChoosingItemButton(
                      text: "People",
                      isFilled: _selectCategory == 3 ? true : false,
                      buttonPressed: () {
                        _selectCategoryPressed(3);
                        setState(() {
                          errorArise = false;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: mySize.height / 64),
                const _Topics(title: "Content Type"),
                SizedBox(height: mySize.height / 88),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ChoosingItemButton(
                      text: "18+",
                      isFilled: _selectAdult == 1 ? true : false,
                      buttonPressed: () {
                        _selectCategory == 0
                            ? errorArise = true
                            : errorArise = false;
                        errorArise == true
                            ? _selectAdultPresssed(0)
                            : _selectAdult == 1
                                ? _selectAdultPresssed(0)
                                : _selectAdultPresssed(1);
                      },
                    ),
                    SizedBox(width: mySize.width / 20),
                    ChoosingItemButton(
                      text: "18-",
                      isFilled: _selectAdult == 2 ? true : false,
                      buttonPressed: () {
                        _selectCategory == 0
                            ? errorArise = true
                            : errorArise = false;
                        errorArise == true
                            ? _selectAdultPresssed(0)
                            : _selectAdult == 2
                                ? _selectAdultPresssed(0)
                                : _selectAdultPresssed(2);
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: mySize.height / 40,
                  child: errorArise == true
                      ? const Text(
                          "Select the Category First",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ), 
                        )
                      : const SizedBox(),
                ),
                SizedBox(
                  height: mySize.height / 20,
                  child: _selectCategory == 1 || _selectCategory == 2
                      ? const _Topics(title: "Release Year")
                      : const SizedBox(),
                ),
                SizedBox(
                  height: mySize.height / 12,
                  width: mySize.width / 5,
                  child: _selectCategory != 1 && _selectCategory != 2
                      ? const SizedBox()
                      : TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(4),
                          ],
                          controller: _releaseYear,
                          decoration: InputDecoration(
                            isDense: true,
                            filled: true,
                            fillColor: myColorScheme.onInverseSurface,
                            hintText: "Year",
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade400,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
          SizedBox(height: mySize.height / 80),
          const Divider(),
          BottomSheetButtons(
            buttonText1: "Reset",
            buttonText2: "Apply",
            func1: () {
              _selectCategory = 0;
              _selectAdult = 0;
              _releaseYear.clear();
              setState(() {
                errorArise = false;
              });
              Navigator.of(context).pop();
            },
            func2: () {
              (_selectCategory == 1 && _releaseYear.text.isNotEmpty) ||
                      (_selectCategory == 2 && _releaseYear.text.isNotEmpty)
                  ? releaseYear = int.parse(_releaseYear.text)
                  : releaseYear = 0;
              Navigator.of(context).pop(
                [
                  _selectCategory,
                  _selectAdult,
                  releaseYear,
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _Topics extends StatelessWidget {
  final String title;
  const _Topics({required this.title});

  @override
  Widget build(BuildContext context) {
    TextTheme myTextTheme = Theme.of(context).textTheme;
    return Text(
      title,
      style: myTextTheme.titleLarge!.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
