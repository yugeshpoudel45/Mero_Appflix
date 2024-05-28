import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:netflix/cubit/theme_cubit_cubit.dart';

class ThemesPage extends StatefulWidget {
  const ThemesPage({super.key});

  @override
  State<ThemesPage> createState() => _ThemesPageState();
}

class _ThemesPageState extends State<ThemesPage> {
  final List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.pink,
  ];

  @override
  Widget build(BuildContext context) {
    TextTheme myTextTheme = Theme.of(context).textTheme;
    Color pickerColor = Colors.red;
    void changeColor(Color color) {
      setState(() => pickerColor = color);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Themes Page',
          style: myTextTheme.headlineSmall!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Text(
              "*Customize the app's theme as your wish*",
              textAlign: TextAlign.center,
              style: myTextTheme.labelMedium!.copyWith(
                color: Colors.green,
              ),
            ),
          ),
          Wrap(
            children: [
              ...colors.map(
                (color) {
                  return InkWell(
                    onTap: () {
                      context.read<ThemeCubit>().toggleTheme(
                            color: color,
                            changeMode: false,
                          );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: color,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          const Divider(),
          ElevatedButton.icon(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Pick a color!'),
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor: pickerColor,
                          onColorChanged: changeColor,
                          pickerAreaHeightPercent: 0.8,
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Got it'),
                          onPressed: () {
                            context.read<ThemeCubit>().toggleTheme(
                                  color: pickerColor,
                                  changeMode: false,
                                );
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
            },
            icon: const Icon(
              Icons.color_lens,
            ),
            label: const Text(
              "Other Themes",
            ),
          ),
        ],
      ),
    );
  }
}
