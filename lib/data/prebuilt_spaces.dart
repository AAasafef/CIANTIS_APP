import 'package:flutter/material.dart';

import '../models/space_model.dart';

final List<SpaceModel>
    prebuiltSpaces = [

  SpaceModel(
    id: 'school',

    name: 'School',

    description:
        'Assignments, deadlines, notes, quizzes, study tools, and learning systems.',

    imagePath:
        'assets/images/spaces/school.jpg',

    icon:
        Icons.school_outlined,
  ),

  SpaceModel(
    id: 'wellness',

    name:
        'Health & Wellness',

    description:
        'Fitness, sleep, nutrition, habits, movement, mindfulness, and wellness tracking.',

    imagePath:
        'assets/images/spaces/wellness.jpg',

    icon:
        Icons.favorite_outline,
  ),

  SpaceModel(
    id: 'spiritual',

    name: 'Spiritual',

    description:
        'Prayer, scripture study, reflection, gratitude, worship, and spiritual growth.',

    imagePath:
        'assets/images/spaces/spiritual.jpg',

    icon:
        Icons.auto_awesome_outlined,
  ),

  SpaceModel(
    id: 'business',

    name: 'Business',

    description:
        'Clients, products, content, finances, analytics, and business systems.',

    imagePath:
        'assets/images/spaces/business.jpg',

    icon:
        Icons.business_center_outlined,
  ),

  SpaceModel(
    id: 'money',

    name: 'Money',

    description:
        'Budgeting, savings, bills, expenses, investments, and financial planning.',

    imagePath:
        'assets/images/spaces/money.jpg',

    icon:
        Icons.attach_money_outlined,
  ),

  SpaceModel(
    id: 'family',

    name: 'Family',

    description:
        'Schedules, routines, children, events, groceries, and home management.',

    imagePath:
        'assets/images/spaces/family.jpg',

    icon:
        Icons.home_outlined,
  ),

  SpaceModel(
    id: 'beauty',

    name: 'Beauty',

    description:
        'Skincare, self-care, appointments, beauty routines, products, and goals.',

    imagePath:
        'assets/images/spaces/beauty.jpg',

    icon:
        Icons.spa_outlined,
  ),

  SpaceModel(
    id: 'work',

    name: 'Work',

    description:
        'Meetings, schedules, productivity, tasks, career goals, and workflows.',

    imagePath:
        'assets/images/spaces/work.jpg',

    icon:
        Icons.work_outline,
  ),

  SpaceModel(
    id: 'travel',

    name: 'Travel',

    description:
        'Trips, itineraries, memories, packing lists, travel budgets, and planning.',

    imagePath:
        'assets/images/spaces/travel.jpg',

    icon:
        Icons.flight_takeoff_outlined,
  ),
];