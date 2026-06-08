import 'package:flutter/material.dart';

import '../../models/space_model.dart';
import '../../services/spaces_service.dart';
import '../../services/tutorial_service.dart';

import '../../widgets/space_selection_card.dart';

import 'space_tutorial_screen.dart';
import 'spaces_screen.dart';

class SelectSpacesScreen extends StatefulWidget {
  const SelectSpacesScreen({
    super.key,
  });

  @override
  State<SelectSpacesScreen> createState() =>
      _SelectSpacesScreenState();
}

class _SelectSpacesScreenState
    extends State<SelectSpacesScreen> {
  final spacesService = SpacesService.instance;

  final tutorialService = TutorialService.instance;

  bool launchedTutorial = false;
  bool loading = true;

  String selectedCategory = 'All';
  String searchText = '';

  final Map<String, List<String>> categories = {
    'All': [],
    'Core': [
      'documents',
      'health',
      'beauty',
      'spiritual',
      'home',
      'family',
      'library',
      'reserve',
    ],
    'Work & Money': [
      'business',
      'money',
      'work',
    ],
    'Growth': [
      'school',
    ],
    'Lifestyle': [
      'travel',
      'custom',
    ],
  };

  @override
  void initState() {
    super.initState();

    _initialize();
  }

  Future<void> _initialize() async {
    await tutorialService.loadTutorials();

    await spacesService.loadSavedSpaces();

    if (!mounted) return;

    setState(() {
      loading = false;
    });
  }

  List<SpaceModel> _filteredSpaces() {
    final allSpaces = spacesService.spaces;

    final byCategory = selectedCategory == 'All'
        ? allSpaces
        : allSpaces.where((space) {
            return categories[selectedCategory]
                    ?.contains(space.id) ??
                false;
          }).toList();

    if (searchText.trim().isEmpty) {
      return byCategory;
    }

    final query = searchText.toLowerCase().trim();

    return byCategory.where((space) {
      return space.title.toLowerCase().contains(query) ||
          space.name.toLowerCase().contains(query) ||
          space.description.toLowerCase().contains(query);
    }).toList();
  }

  int _selectedCount() {
    return spacesService.activeSpaces.length;
  }

  Future<void> _continueToSpaces() async {
    if (_selectedCount() == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color(0xFF241D18),
          content: Text(
            'Choose at least one space to continue.',
          ),
        ),
      );
      return;
    }

    await spacesService.saveSelectedSpaces();

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const SpacesScreen(),
      ),
    );
  }

  void _openTutorial() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const SpaceTutorialScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final spaces = _filteredSpaces();

    if (!loading &&
        !launchedTutorial &&
        !tutorialService.hasSeenSpacesTutorial) {
      launchedTutorial = true;

      WidgetsBinding.instance.addPostFrameCallback(
        (_) async {
          if (!mounted) return;

          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const SpaceTutorialScreen(),
            ),
          );

          await tutorialService
              .completeSpacesTutorial();
        },
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF6F1EA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            22,
            20,
            22,
            20,
          ),
          child: loading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF241D18),
                  ),
                )
              : Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 44,
                          width: 44,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFBF8F4),
                            borderRadius:
                                BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0xFFE1D6CA),
                              width: .7,
                            ),
                          ),
                          child: const Icon(
                            Icons.auto_awesome,
                            color: Color(0xFF8E6F55),
                            size: 21,
                          ),
                        ),
                        const SizedBox(width: 14),
                        const Expanded(
                          child: Text(
                            'Choose Your Spaces',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight:
                                  FontWeight.w300,
                              color: Color(0xFF241D18),
                              height: 1.1,
                              letterSpacing: -.8,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: _openTutorial,
                          child: Container(
                            height: 42,
                            width: 42,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFBF8F4),
                              borderRadius:
                                  BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color(0xFFE1D6CA),
                                width: .7,
                              ),
                            ),
                            child: const Icon(
                              Icons.question_mark,
                              color: Color(0xFF8E6F55),
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    const Text(
                      'All spaces show first now. Categories only help you organize — they do not mean spaces are missing.',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Color(0xFF6F6258),
                        height: 1.6,
                      ),
                    ),

                    const SizedBox(height: 18),

                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFBF8F4),
                        borderRadius:
                            BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xFFE1D6CA),
                          width: .7,
                        ),
                      ),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            searchText = value;
                          });
                        },
                        style: const TextStyle(
                          color: Color(0xFF241D18),
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Search all spaces',
                          hintStyle: TextStyle(
                            color: Color(0xFF9A8D83),
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                          ),
                          prefixIcon: Icon(
                            Icons.search_rounded,
                            color: Color(0xFF8E6F55),
                            size: 21,
                          ),
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 14,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    SizedBox(
                      height: 42,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        physics:
                            const BouncingScrollPhysics(),
                        children:
                            categories.keys.map((category) {
                          final selected =
                              selectedCategory == category;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCategory = category;
                              });
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.only(
                                right: 10,
                              ),
                              padding:
                                  const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 11,
                              ),
                              decoration: BoxDecoration(
                                color: selected
                                    ? const Color(0xFF241D18)
                                    : const Color(0xFFFBF8F4),
                                borderRadius:
                                    BorderRadius.circular(10),
                                border: Border.all(
                                  color: selected
                                      ? const Color(0xFF241D18)
                                      : const Color(0xFFE1D6CA),
                                  width: .7,
                                ),
                              ),
                              child: Text(
                                category,
                                style: TextStyle(
                                  color: selected
                                      ? const Color(0xFFFBF8F4)
                                      : const Color(
                                          0xFF6F6258,
                                        ),
                                  fontSize: 13,
                                  fontWeight:
                                      FontWeight.w300,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    const SizedBox(height: 14),

                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${_selectedCount()} selected',
                            style: const TextStyle(
                              color: Color(0xFF6F6258),
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await SpacesService.resetSpaces();

                            if (!mounted) return;

                            setState(() {});
                          },
                          child: const Text(
                            'Reset Defaults',
                            style: TextStyle(
                              color: Color(0xFF8E6F55),
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        const SizedBox(width: 18),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              for (final space
                                  in spacesService.spaces) {
                                space.selected = false;
                              }
                            });
                          },
                          child: const Text(
                            'Clear All',
                            style: TextStyle(
                              color: Color(0xFF8E6F55),
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    Expanded(
                      child: spaces.isEmpty
                          ? const Center(
                              child: Text(
                                'No spaces found.',
                                style: TextStyle(
                                  color: Color(0xFF6F6258),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            )
                          : GridView.builder(
                              physics:
                                  const BouncingScrollPhysics(),
                              itemCount: spaces.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                mainAxisSpacing: 18,
                                childAspectRatio: .88,
                              ),
                              itemBuilder: (context, index) {
                                final space = spaces[index];

                                return SpaceSelectionCard(
                                  space: space,
                                  onTap: () {
                                    setState(() {
                                      spacesService
                                          .toggleSpace(
                                        space.id,
                                      );
                                    });
                                  },
                                );
                              },
                            ),
                    ),

                    const SizedBox(height: 18),

                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: _continueToSpaces,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF241D18),
                          foregroundColor:
                              const Color(0xFFFBF8F4),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          _selectedCount() == 0
                              ? 'Choose at Least One Space'
                              : 'Save ${_selectedCount()} Spaces',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}