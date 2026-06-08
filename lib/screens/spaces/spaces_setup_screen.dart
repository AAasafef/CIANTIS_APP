import 'package:flutter/material.dart';

import '../../data/available_spaces_data.dart';
import '../../data/default_active_spaces_data.dart';
import '../../services/spaces_service.dart';

import '../dashboard/dashboard_screen.dart';

class SpacesSetupScreen extends StatefulWidget {
  const SpacesSetupScreen({super.key});

  @override
  State<SpacesSetupScreen> createState() =>
      _SpacesSetupScreenState();
}

class _SpacesSetupScreenState
    extends State<SpacesSetupScreen> {
  final Set<String> selectedSpaceIds =
      defaultActiveSpaces.map((space) => space.id).toSet();

  String searchText = '';

  @override
  Widget build(BuildContext context) {
    final filteredSpaces = availableSpaces.where((space) {
      final query = searchText.toLowerCase();

      return space.title.toLowerCase().contains(query) ||
          space.description.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 22, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Choose Your Spaces',
                style: TextStyle(
                  fontSize: 40,
                  height: 1,
                  fontWeight: FontWeight.w300,
                  letterSpacing: -1.2,
                  color: Color(0xFF2D241D),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Select the spaces you want active now. You can add more later.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: Colors.black.withOpacity(.58),
                ),
              ),
              const SizedBox(height: 22),
              TextField(
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search spaces',
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: Color(0xFF8B735F),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Expanded(
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: filteredSpaces.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: .78,
                  ),
                  itemBuilder: (context, index) {
                    final space = filteredSpaces[index];
                    final selected =
                        selectedSpaceIds.contains(space.id);

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (selected) {
                            selectedSpaceIds.remove(space.id);
                          } else {
                            selectedSpaceIds.add(space.id);
                          }
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: selected
                              ? const Color(0xFF2D241D)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(28),
                        ),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 46,
                                  width: 46,
                                  decoration: BoxDecoration(
                                    color: selected
                                        ? Colors.white.withOpacity(.14)
                                        : const Color(0xFFF8F3EC),
                                    borderRadius:
                                        BorderRadius.circular(16),
                                  ),
                                  child: Icon(
                                    space.icon,
                                    color: selected
                                        ? Colors.white
                                        : const Color(0xFF8B735F),
                                  ),
                                ),
                                const Spacer(),
                                Icon(
                                  selected
                                      ? Icons.check_circle
                                      : Icons.circle_outlined,
                                  color: selected
                                      ? Colors.white
                                      : const Color(0xFFB08D6D),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              space.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: selected
                                    ? Colors.white
                                    : const Color(0xFF2D241D),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              space.description,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                height: 1.35,
                                color: selected
                                    ? Colors.white.withOpacity(.72)
                                    : Colors.black.withOpacity(.52),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 14),
              GestureDetector(
                onTap: selectedSpaceIds.isEmpty
                    ? null
                    : () async {
                        await SpacesService.saveActiveSpaces(
                          selectedSpaceIds.toList(),
                        );

                        if (!context.mounted) return;

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const DashboardScreen(),
                          ),
                        );
                      },
                child: Container(
                  height: 58,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: selectedSpaceIds.isEmpty
                        ? const Color(0xFFD7C9BC)
                        : const Color(0xFF2D241D),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    selectedSpaceIds.isEmpty
                        ? 'Select at Least One Space'
                        : 'Save My Spaces',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
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