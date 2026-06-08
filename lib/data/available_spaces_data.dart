import 'package:flutter/material.dart';

import '../models/space_model.dart';

final List<SpaceModel> availableSpaces = <SpaceModel>[
  SpaceModel(
    id: 'documents',
    name: 'Documents',
    title: 'Documents',
    description:
        'Important files, scans, receipts, records, identity papers, legal documents, and secure storage.',
    imagePath: 'assets/images/spaces/documents.jpg',
    icon: Icons.folder_copy_outlined,
    color: const Color(0xFFB08D6D),
  ),

  SpaceModel(
    id: 'health',
    name: 'Health',
    title: 'Health',
    description:
        'Wellness, food, water, movement, symptoms, medications, appointments, cycle tracking, and health notes.',
    imagePath: 'assets/images/spaces/health.jpg',
    icon: Icons.favorite_outline,
    color: const Color(0xFFD6B08C),
  ),

  SpaceModel(
    id: 'money',
    name: 'Money',
    title: 'Money',
    description:
        'Budgeting, bills, income, expenses, savings, debt, subscriptions, taxes, and financial planning.',
    imagePath: 'assets/images/spaces/finance.jpg',
    icon: Icons.account_balance_wallet_outlined,
    color: const Color(0xFF6F5847),
  ),

  SpaceModel(
    id: 'business',
    name: 'Business',
    title: 'Business',
    description:
        'Clients, services, salon work, model calls, inventory, content, courses, income, and business planning.',
    imagePath: 'assets/images/spaces/business.jpg',
    icon: Icons.business_center_outlined,
    color: const Color(0xFF8F6A4E),
  ),

  SpaceModel(
    id: 'school',
    name: 'School',
    title: 'School',
    description:
        'Classes, assignments, study planning, notes, due dates, learning resources, and school documents.',
    imagePath: 'assets/images/spaces/school.jpg',
    icon: Icons.school_outlined,
    color: const Color(0xFFC7A27B),
  ),

  SpaceModel(
    id: 'work',
    name: 'Work',
    title: 'Work',
    description:
        'Career planning, resumes, licenses, certifications, job applications, interviews, training, and work goals.',
    imagePath: 'assets/images/spaces/career.jpg',
    icon: Icons.badge_outlined,
    color: const Color(0xFF8F6A4E),
  ),

  SpaceModel(
    id: 'spiritual',
    name: 'Spiritual',
    title: 'Spiritual',
    description:
        'Prayer, Bible study, devotionals, prophecy notes, dreams, journals, deliverance, and spiritual growth.',
    imagePath: 'assets/images/spaces/spiritual.jpg',
    icon: Icons.auto_awesome_outlined,
    color: const Color(0xFF6E5846),
  ),

  SpaceModel(
    id: 'home',
    name: 'Home',
    title: 'Home',
    description:
        'Cleaning, chores, routines, repairs, household inventory, meal planning, projects, ideas, and home organization.',
    imagePath: 'assets/images/spaces/home.jpg',
    icon: Icons.home_outlined,
    color: const Color(0xFFBFA38A),
  ),

  SpaceModel(
    id: 'beauty',
    name: 'Beauty',
    title: 'Beauty',
    description:
        'Hair, nails, skin, inspiration, beauty routines, salon planning, services, products, and client-facing prep.',
    imagePath: 'assets/images/spaces/beauty.jpg',
    icon: Icons.face_outlined,
    color: const Color(0xFFD2B49C),
  ),

  SpaceModel(
    id: 'family',
    name: 'Family',
    title: 'Family',
    description:
        'Children, routines, learning, behavior, school documents, activities, appointments, memories, and family organization.',
    imagePath: 'assets/images/spaces/kids.jpg',
    icon: Icons.family_restroom_outlined,
    color: const Color(0xFFAA8665),
  ),

  SpaceModel(
    id: 'library',
    name: 'Library',
    title: 'Library',
    description:
        'Books, PDFs, EPUBs, reading lists, notes, highlights, favorites, and personal learning materials.',
    imagePath: 'assets/images/spaces/library.jpg',
    icon: Icons.menu_book_outlined,
    color: const Color(0xFF9C7656),
  ),

  SpaceModel(
    id: 'travel',
    name: 'Travel',
    title: 'Travel',
    description:
        'Trips, itineraries, packing lists, bookings, travel documents, plans, and saved travel ideas.',
    imagePath: 'assets/images/spaces/travel.jpg',
    icon: Icons.flight_takeoff_outlined,
    color: const Color(0xFF7E6A58),
  ),

  SpaceModel(
    id: 'reserve',
    name: 'Reserve',
    title: 'Reserve',
    description:
        'Locked sensitive data, passwords, identity records, private files, and secure storage.',
    imagePath: 'assets/images/spaces/reserve.jpg',
    icon: Icons.lock_outline,
    color: const Color(0xFF47372B),
    locked: true,
  ),

  SpaceModel(
    id: 'custom',
    name: 'Custom',
    title: 'Custom',
    description:
        'A flexible space you can rename and shape around anything you are building, tracking, or organizing.',
    imagePath: 'assets/images/spaces/projects.jpg',
    icon: Icons.add_box_outlined,
    color: const Color(0xFF8B735F),
  ),
];