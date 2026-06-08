import 'package:flutter/material.dart';

import 'app_items.dart';

import '../screens/business/business_screen.dart';
import '../screens/business/beauty/clients/client_list_screen.dart';
import '../screens/calendar/calendar_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/documents/document_ai_processing_screen.dart';
import '../screens/documents/document_import_sources_screen.dart';
import '../screens/documents/document_scanning_screen.dart';
import '../screens/finances/finances_screen.dart';
import '../screens/goals/goals_screen.dart';
import '../screens/habits/habits_screen.dart';
import '../screens/health/period_screen.dart';
import '../screens/journal/journal_screen.dart';
import '../screens/notes/notes_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/pulse/pulse_screen.dart';
import '../screens/self_care/self_care_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/shared/coming_soon_screen.dart';
import '../screens/spaces/spaces_screen.dart';
import '../screens/subscriptions/subscription_screen.dart';

final List<AppItem> ciantisApps = [
  const AppItem(
    title: 'Today',
    icon: Icons.home_outlined,
    screen: DashboardScreen(),
  ),

  const AppItem(
    title: 'Pulse',
    icon: Icons.insights_outlined,
    screen: PulseScreen(),
  ),

  const AppItem(
    title: 'Client Book',
    icon: Icons.contacts_outlined,
    screen: ClientListScreen(),
  ),

  const AppItem(
    title: 'Spaces',
    icon: Icons.grid_view_rounded,
    screen: SpacesScreen(),
  ),

  const AppItem(
    title: 'Horizons',
    icon: Icons.favorite_border,
    screen: GoalsScreen(),
  ),

  const AppItem(
    title: 'Habits',
    icon: Icons.check_circle_outline,
    screen: HabitsScreen(),
  ),

  const AppItem(
    title: 'Journal',
    icon: Icons.menu_book_outlined,
    screen: JournalScreen(),
  ),

  const AppItem(
    title: 'Restore',
    icon: Icons.spa_outlined,
    screen: SelfCareScreen(),
  ),

  const AppItem(
    title: 'Cycle',
    icon: Icons.water_drop_outlined,
    screen: PeriodScreen(),
  ),

  const AppItem(
    title: 'Finances',
    icon: Icons.account_balance_wallet_outlined,
    screen: FinancesScreen(),
  ),

  const AppItem(
    title: 'Subscriptions',
    icon: Icons.subscriptions_outlined,
    screen: SubscriptionScreen(),
  ),

  const AppItem(
    title: 'Business',
    icon: Icons.business_center_outlined,
    screen: BusinessScreen(),
  ),

  const AppItem(
    title: 'Calendar',
    icon: Icons.calendar_month_outlined,
    screen: CalendarScreen(),
  ),

  const AppItem(
    title: 'Settings',
    icon: Icons.settings_outlined,
    screen: SettingsScreen(),
  ),

  const AppItem(
    title: 'Profile',
    icon: Icons.person_outline,
    screen: ProfileScreen(),
  ),

  const AppItem(
    title: 'Academy',
    icon: Icons.school_outlined,
    screen: ComingSoonScreen(
      title: 'Academy',
      subtitle:
          'School, learning, assignments, and study tools will connect here.',
      icon: Icons.school_outlined,
    ),
  ),

  const AppItem(
    title: 'Wellness',
    icon: Icons.monitor_heart_outlined,
    screen: ComingSoonScreen(
      title: 'Wellness',
      subtitle:
          'Health, food logs, workouts, and wellness tracking will connect here.',
      icon: Icons.monitor_heart_outlined,
    ),
  ),

  const AppItem(
    title: 'Projects',
    icon: Icons.folder_outlined,
    screen: ComingSoonScreen(
      title: 'Projects',
      subtitle:
          'Projects, plans, ideas, and active builds will connect here.',
      icon: Icons.folder_outlined,
    ),
  ),

  const AppItem(
    title: 'Notes',
    icon: Icons.edit_note_outlined,
    screen: NotesScreen(
      spaceId: 'universal',
      spaceName: 'Universal Notes',
    ),
  ),

  const AppItem(
    title: 'Resources',
    icon: Icons.widgets_outlined,
    screen: ComingSoonScreen(
      title: 'Resources',
      subtitle:
          'Saved tools, references, and resource libraries will connect here.',
      icon: Icons.widgets_outlined,
    ),
  ),

  const AppItem(
    title: 'Scanner',
    icon: Icons.document_scanner_outlined,
    screen: DocumentScanningScreen(),
  ),

  const AppItem(
    title: 'Import',
    icon: Icons.cloud_upload_outlined,
    screen: DocumentImportSourcesScreen(),
  ),

  const AppItem(
    title: 'AI Sort',
    icon: Icons.auto_awesome_outlined,
    screen: DocumentAiProcessingScreen(),
  ),
];
