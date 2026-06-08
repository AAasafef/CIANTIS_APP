import 'package:flutter/material.dart';

import 'ciantis_text_side_menu.dart';

class CiantisSideDrawer extends StatefulWidget {
  const CiantisSideDrawer({
    super.key,
  });

  @override
  State<CiantisSideDrawer> createState() => _CiantisSideDrawerState();
}

class _CiantisSideDrawerState extends State<CiantisSideDrawer> {
  String selectedCategory = 'Journal';
  String selectedSubCategory = 'All Entries';

  final Map<String, List<String>> drawerTabs = {
    'Journal': [
      'All Entries',
      'New Entry',
      'Calendar View',
      'Search Entries',
    ],
    'Saved': [
      'Favorites',
      'Private Entries',
      'Archive',
      'Recently Deleted',
    ],
    'Organize': [
      'Categories',
      'Moods',
      'Tags',
      'Spaces',
    ],
    'Writing': [
      'Prompts',
      'Templates',
      'Drafts',
      'Ideas',
    ],
    'Insights': [
      'AI Summary',
      'Reflections',
      'Patterns',
      'Highlights',
    ],
    'Export': [
      'Export PDF',
      'Export TXT',
      'Export Markdown',
      'Backup Journal',
    ],
    'Journal Settings': [
      'Default Font',
      'Default Mood',
      'Default Category',
      'Paper Style',
      'Privacy',
    ],
  };

  @override
  Widget build(BuildContext context) {
    return CiantisTextSideMenu(
      title: 'Ciantis',
      subtitle: 'JOURNAL',
      drawerTabs: drawerTabs,
      selectedCategory: selectedCategory,
      selectedSubCategory: selectedSubCategory,
      showHomeShortcut: false,
      onMainTabSelected: (category) {
        setState(() {
          selectedCategory = category;
          selectedSubCategory = drawerTabs[category]?.isNotEmpty == true
              ? drawerTabs[category]!.first
              : 'All Entries';
        });
      },
      onSubTabSelected: (category, subCategory) {
        setState(() {
          selectedCategory = category;
          selectedSubCategory = subCategory;
        });

        Navigator.pop(context);
      },
    );
  }
}
