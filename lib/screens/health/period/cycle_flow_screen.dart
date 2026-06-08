import 'package:flutter/material.dart';

class CycleFlowScreen extends StatefulWidget {
  const CycleFlowScreen({super.key});

  @override
  State<CycleFlowScreen> createState() => _CycleFlowScreenState();
}

class _CycleFlowScreenState extends State<CycleFlowScreen> {
  String selectedFlow = 'Medium';

  final List<String> flows = const [
    'Spotting',
    'Light',
    'Medium',
    'Heavy',
  ];

  @override
  Widget build(BuildContext context) {
    return _CyclePageShell(
      title: 'Flow',
      subtitle: 'PERIOD LOG',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InfoCard(
            title: 'Current Flow',
            body: selectedFlow,
          ),
          const SizedBox(height: 18),
          ...flows.map((flow) {
            final active = selectedFlow == flow;

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedFlow = flow;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: active
                      ? const Color(0xFF241D18)
                      : const Color(0xFFFBF8F4).withOpacity(.9),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: const Color(0xFFE2D8CD),
                    width: .7,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.water_drop_outlined,
                      color: active
                          ? const Color(0xFFFFF9F1)
                          : const Color(0xFF241D18),
                      size: 22,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        flow,
                        style: TextStyle(
                          color: active
                              ? const Color(0xFFFFF9F1)
                              : const Color(0xFF241D18),
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    if (active)
                      const Icon(
                        Icons.check_rounded,
                        color: Color(0xFFFFF9F1),
                        size: 20,
                      ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _CyclePageShell extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;

  const _CyclePageShell({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE8),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _BackButtonBox(
                    onTap: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 42,
                            height: .95,
                            fontWeight: FontWeight.w300,
                            letterSpacing: -1.4,
                            color: Color(0xFF241D18),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 3,
                            color: Color(0xFF8B7D72),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

class _BackButtonBox extends StatelessWidget {
  final VoidCallback onTap;

  const _BackButtonBox({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 42,
        width: 42,
        decoration: BoxDecoration(
          color: const Color(0xFFFBF8F4).withOpacity(.9),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: const Color(0xFFE2D8CD),
            width: .7,
          ),
        ),
        child: const Icon(
          Icons.chevron_left_rounded,
          color: Color(0xFF241D18),
          size: 24,
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String body;

  const _InfoCard({
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              color: Color(0xFF8B7D72),
              fontSize: 11,
              fontWeight: FontWeight.w300,
              letterSpacing: 2.6,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            body,
            style: const TextStyle(
              color: Color(0xFF241D18),
              fontSize: 30,
              height: 1,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}

BoxDecoration _cardDecoration() {
  return BoxDecoration(
    color: const Color(0xFFFBF8F4).withOpacity(.9),
    borderRadius: BorderRadius.circular(24),
    border: Border.all(
      color: const Color(0xFFE2D8CD),
      width: .7,
    ),
  );
}