import 'package:flutter/material.dart';

class SearchFilterModal extends StatelessWidget {
  const SearchFilterModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 496,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: ListView(
        children: const [
          Icon(
            Icons.horizontal_rule_rounded,
            size: 56,
            color: Colors.grey,
          ),
          Text(
            "Create",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Divider(),
         
          Divider(
            indent: 72,
            endIndent: 16,
          ),
          ListTile(
            dense: true,
            visualDensity: VisualDensity(
              vertical: -2,
            ),
            leading: Icon(
              Icons.grid_on_sharp,
              color: Colors.black,
              size: 28,
            ),
            title: Text(
              "Post",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Divider(
            indent: 72,
            endIndent: 16,
          ),
          ListTile(
            dense: true,
            visualDensity: VisualDensity(
              vertical: -2,
            ),
            leading: Icon(
              Icons.add_circle_outline_rounded,
              color: Colors.black,
              size: 28,
            ),
            title: Text(
              "Story",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Divider(
            indent: 72,
            endIndent: 16,
          ),
          ListTile(
            dense: true,
            visualDensity: VisualDensity(
              vertical: -2,
            ),
            leading: Icon(
              Icons.stars_outlined,
              color: Colors.black,
              size: 28,
            ),
            title: Text(
              "Story Highlight",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Divider(
            indent: 72,
            endIndent: 16,
          ),
        
          Divider(
            indent: 72,
            endIndent: 16,
          ),
          ListTile(
            dense: true,
            visualDensity: VisualDensity(
              vertical: -2,
            ),
            leading: Icon(
              Icons.menu_book_sharp,
              color: Colors.black,
              size: 28,
            ),
            title: Text(
              "Guide",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Divider(
            indent: 72,
            endIndent: 16,
          ),
        ],
      ),
    );
  }
}
