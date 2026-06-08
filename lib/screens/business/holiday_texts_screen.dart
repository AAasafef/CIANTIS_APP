import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class HolidayTextsScreen extends StatelessWidget {
  const HolidayTextsScreen({super.key});

  Future<void> _downloadHolidayTexts(
    BuildContext context,
  ) async {
    final directory =
        await getApplicationDocumentsDirectory();

    final file = File(
      '${directory.path}/holiday_client_texts.txt',
    );

    final buffer = StringBuffer();

    for (final message in _holidayMessages) {
      buffer.writeln('==============================');
      buffer.writeln(message.holiday);
      buffer.writeln('==============================');
      buffer.writeln(message.text);
      buffer.writeln('');
    }

    await file.writeAsString(buffer.toString());

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Holiday texts saved to: ${file.path}',
          ),
        ),
      );
    }
  }

  Future<void> _copyText(
    BuildContext context,
    String text,
  ) async {
    await Clipboard.setData(
      ClipboardData(text: text),
    );

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Text copied.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F1EB),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Holiday Texts',
          style: TextStyle(
            color: Color(0xFF2B2118),
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.sms_outlined,
                    color: Color(0xFF8B735B),
                    size: 38,
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Premade client holiday texts',
                    style: TextStyle(
                      color: Color(0xFF2B2118),
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'These are ready-to-use holiday messages for clients. Nothing is sent automatically. You can copy one message or download the full set.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 20),

                  GestureDetector(
                    onTap: () {
                      _downloadHolidayTexts(context);
                    },
                    child: Container(
                      height: 54,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2D241D),
                        borderRadius:
                            BorderRadius.circular(22),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'Download All Texts',
                        style: TextStyle(
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

            const SizedBox(height: 26),

            const Text(
              'Holiday Messages',
              style: TextStyle(
                color: Color(0xFF2B2118),
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 18),

            ..._holidayMessages.map(
              (message) {
                return _HolidayMessageCard(
                  message: message,
                  onCopy: () {
                    _copyText(
                      context,
                      message.text,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _HolidayMessageCard extends StatelessWidget {
  final HolidayMessage message;
  final VoidCallback onCopy;

  const _HolidayMessageCard({
    required this.message,
    required this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 46,
                width: 46,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1E7DA),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  message.icon,
                  color: const Color(0xFF8B735B),
                  size: 24,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Text(
                  message.holiday,
                  style: const TextStyle(
                    color: Color(0xFF2B2118),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              IconButton(
                onPressed: onCopy,
                icon: const Icon(
                  Icons.copy_rounded,
                  color: Color(0xFF8B735B),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Text(
            message.text,
            style: const TextStyle(
              color: Color(0xFF6B5B4D),
              fontSize: 14,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}

class HolidayMessage {
  final String holiday;
  final String text;
  final IconData icon;

  const HolidayMessage({
    required this.holiday,
    required this.text,
    required this.icon,
  });
}

const List<HolidayMessage> _holidayMessages = [
  HolidayMessage(
    holiday: 'New Year’s Day',
    icon: Icons.celebration_outlined,
    text:
        'Happy New Year! I hope this year brings you peace, growth, beauty, and blessings. Thank you for supporting my business. I can’t wait to continue serving you this year.',
  ),

  HolidayMessage(
    holiday: 'Valentine’s Day',
    icon: Icons.favorite_border,
    text:
        'Happy Valentine’s Day! Sending love and appreciation your way today. Thank you for being such a valued client. I hope your day is beautiful, soft, and full of love.',
  ),

  HolidayMessage(
    holiday: 'Easter',
    icon: Icons.wb_sunny_outlined,
    text:
        'Happy Easter! Wishing you and your family a peaceful, beautiful, and blessed day. Thank you for continuing to support my business.',
  ),

  HolidayMessage(
    holiday: 'Mother’s Day',
    icon: Icons.spa_outlined,
    text:
        'Happy Mother’s Day! Today is a reminder that you deserve love, rest, beauty, and appreciation. Wishing you a soft and beautiful day filled with joy.',
  ),

  HolidayMessage(
    holiday: 'Memorial Day',
    icon: Icons.flag_outlined,
    text:
        'Wishing you a peaceful Memorial Day. Today we honor and remember those who served and sacrificed. I hope you enjoy a safe and meaningful day.',
  ),

  HolidayMessage(
    holiday: 'Father’s Day',
    icon: Icons.family_restroom_outlined,
    text:
        'Happy Father’s Day! Wishing a beautiful and peaceful day to all the fathers, father figures, and families celebrating today.',
  ),

  HolidayMessage(
    holiday: 'Independence Day',
    icon: Icons.local_fire_department_outlined,
    text:
        'Happy 4th of July! I hope you enjoy a safe, beautiful, and relaxing holiday with family and friends. Thank you for supporting my business.',
  ),

  HolidayMessage(
    holiday: 'Labor Day',
    icon: Icons.work_outline,
    text:
        'Happy Labor Day! I hope you get time to rest, reset, and enjoy the day. Thank you for your continued support and trust in my services.',
  ),

  HolidayMessage(
    holiday: 'Halloween',
    icon: Icons.nightlight_outlined,
    text:
        'Happy Halloween! Wishing you a fun, safe, and beautiful day. Whether you’re dressing up or keeping it cozy, I hope you enjoy it.',
  ),

  HolidayMessage(
    holiday: 'Veterans Day',
    icon: Icons.military_tech_outlined,
    text:
        'Happy Veterans Day. Today we honor all who have served. Thank you to every veteran and military family for your service and sacrifice.',
  ),

  HolidayMessage(
    holiday: 'Thanksgiving',
    icon: Icons.restaurant_outlined,
    text:
        'Happy Thanksgiving! I’m truly grateful for your support, trust, and loyalty. Wishing you and your family a peaceful holiday filled with love and gratitude.',
  ),

  HolidayMessage(
    holiday: 'Christmas',
    icon: Icons.card_giftcard_outlined,
    text:
        'Merry Christmas! Wishing you and your family a beautiful, peaceful, and blessed holiday. Thank you for being part of my business journey.',
  ),

  HolidayMessage(
    holiday: 'New Year’s Eve',
    icon: Icons.auto_awesome_outlined,
    text:
        'Happy New Year’s Eve! Thank you for being part of my year. I’m so grateful for your support and excited for everything ahead. Wishing you a safe and beautiful night.',
  ),
];