// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:netflix/config/app_local_assets.dart';
import 'package:netflix/cubit/theme_cubit_cubit.dart';

import '../../routes/app_route_constant.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme myTextTheme = Theme.of(context).textTheme;
    Size mySize = MediaQuery.sizeOf(context);
    return ListView(
      padding: const EdgeInsets.symmetric(
        vertical: 40,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Row(
            children: [
              Image.asset(
                AppAssets.appLogo,
                height: mySize.height / 24,
              ),
              SizedBox(
                width: mySize.width / 32,
              ),
              Text(
                "Setting",
                style: myTextTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: mySize.height / 32,
        ),
        SettingsSection(
          title: 'General',
          items: [
            SettingsItem(
              icon: Icons.person,
              text: 'Personal Info',
              onTap: () {},
            ),
            SettingsItem(
              icon: Icons.language,
              text: 'Language',
              onTap: () {},
            ),
            SettingsItem(
              icon: Icons.color_lens,
              text: 'Themes',
              onTap: () {
                GoRouter.of(context).pushNamed(
                  MyAppRouteConstants.themesPage,
                );
              },
            ),
            SettingsItem(
              icon: Icons.dark_mode,
              text: 'Dark Mode',
              isSwitch: true,
              onTap: () {},
            ),
          ],
        ),
        SizedBox(
          height: mySize.height / 32,
        ),
        SettingsSection(
          title: 'About',
          items: [
            SettingsItem(
              icon: Icons.help,
              text: 'Help Center',
              onTap: () {},
            ),
            SettingsItem(
              icon: Icons.privacy_tip,
              text: 'Privacy Policy',
              onTap: () {},
            ),
            SettingsItem(
              icon: Icons.info,
              text: 'About us',
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}

class SettingsSection extends StatelessWidget {
  final String title;
  final List<SettingsItem> items;

  const SettingsSection({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    TextTheme myTextTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Text(
            title,
            style: myTextTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Divider(
          indent: 60,
          thickness: 1,
        ),
        ...items,
      ],
    );
  }
}

class SettingsItem extends StatefulWidget {
  final IconData icon;
  final String text;
  final bool isSwitch;
  final VoidCallback onTap;

  const SettingsItem({
    Key? key,
    required this.icon,
    required this.text,
    this.isSwitch = false,
    required this.onTap,
  }) : super(key: key);

  @override
  State<SettingsItem> createState() => _SettingsItemState();
}

class _SettingsItemState extends State<SettingsItem> {
  @override
  Widget build(BuildContext context) {
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    TextTheme myTextTheme = Theme.of(context).textTheme;
    final themeCubit = context.read<ThemeCubit>();
    return ListTile(
      leading: Icon(
        widget.icon,
        color: Colors.black,
      ),
      title: Text(
        widget.text,
        style: myTextTheme.bodyLarge!.copyWith(
          color: Colors.black,
        ),
      ),
      trailing: widget.isSwitch
          ? CupertinoSwitch(
              activeColor: myColorScheme.onTertiary,
              value: themeCubit.state.themeData.brightness == Brightness.dark,
              onChanged: (val) {
                themeCubit.toggleTheme(
                  color: myColorScheme.primary,
                  changeMode: true,
                );
              })
          : const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: widget.onTap,
    );
  }
}
