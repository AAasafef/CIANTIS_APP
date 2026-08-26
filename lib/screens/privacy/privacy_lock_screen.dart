import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

import '../dashboard/dashboard_screen.dart';

class PrivacyLockScreen extends StatefulWidget {
  const PrivacyLockScreen({super.key});

  @override
  State<PrivacyLockScreen> createState() => _PrivacyLockScreenState();
}

class _PrivacyLockScreenState extends State<PrivacyLockScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  final LocalAuthentication _auth = LocalAuthentication();

  late final AnimationController _lightController;
  late final AnimationController _secondaryController;

  bool _authenticating = false;
  bool _unlocked = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _lightController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
    )..repeat(reverse: true);

    _secondaryController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 24),
    )..repeat(reverse: true);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_unlocked &&
        (state == AppLifecycleState.inactive ||
            state == AppLifecycleState.paused ||
            state == AppLifecycleState.hidden)) {
      setState(() => _unlocked = false);
    }
  }

  Future<void> _authenticate() async {
    if (_authenticating || _unlocked || kIsWeb) return;

    setState(() => _authenticating = true);

    try {
      final canUseBiometrics = await _auth.canCheckBiometrics;
      final supported = await _auth.isDeviceSupported();

      if (!canUseBiometrics && !supported) return;

      final authenticated = await _auth.authenticate(
        localizedReason: ' ',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
          useErrorDialogs: true,
        ),
      );

      if (!mounted) return;

      if (authenticated) {
        setState(() => _unlocked = true);
      }
    } catch (_) {
      // Intentionally silent. This screen gives no hints about how to unlock.
    } finally {
      if (mounted) {
        setState(() => _authenticating = false);
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _lightController.dispose();
    _secondaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_unlocked) {
      return const DashboardScreen();
    }

    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onLongPress: _authenticate,
        child: AnimatedBuilder(
          animation: Listenable.merge([
            _lightController,
            _secondaryController,
          ]),
          builder: (context, _) {
            return Stack(
              fit: StackFit.expand,
              children: [
                const _BaseBackground(),
                _MovingGlow(
                  progress: _lightController.value,
                  primary: true,
                ),
                _MovingGlow(
                  progress: _secondaryController.value,
                  primary: false,
                ),
                const _SoftVeil(),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 2),
                    child: Text(
                      'HELLO',
                      style: TextStyle(
                        color: Color(0xFFE9E1D4),
                        fontFamily: 'Helvetica Neue',
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 2.1,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _BaseBackground extends StatelessWidget {
  const _BaseBackground();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF777168),
            Color(0xFF5B5751),
            Color(0xFF44413D),
            Color(0xFF2F2F2E),
            Color(0xFF202124),
          ],
          stops: [0.0, 0.22, 0.48, 0.72, 1.0],
        ),
      ),
    );
  }
}

class _MovingGlow extends StatelessWidget {
  const _MovingGlow({
    required this.progress,
    required this.primary,
  });

  final double progress;
  final bool primary;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final eased = Curves.easeInOut.transform(progress);

    final x = primary
        ? lerpDouble(-size.width * 0.52, size.width * 0.42, eased)!
        : lerpDouble(size.width * 0.46, -size.width * 0.44, eased)!;

    final wave = math.sin(eased * math.pi);
    final y = primary
        ? lerpDouble(-size.height * 0.05, size.height * 0.33, eased)! +
            wave * 30
        : lerpDouble(size.height * 0.30, size.height * 0.08, eased)! -
            wave * 18;

    final glowWidth = primary ? size.width * 1.32 : size.width * 1.05;
    final glowHeight = primary ? size.height * 0.42 : size.height * 0.50;

    return Positioned(
      left: x,
      top: y,
      child: IgnorePointer(
        child: ImageFiltered(
          imageFilter: ImageFilter.blur(
            sigmaX: primary ? 38 : 46,
            sigmaY: primary ? 38 : 46,
          ),
          child: Container(
            width: glowWidth,
            height: glowHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(glowHeight),
              gradient: RadialGradient(
                colors: primary
                    ? const [
                        Color(0x8FE7DCC8),
                        Color(0x55D2C5AF),
                        Color(0x20B3A998),
                        Color(0x00B3A998),
                      ]
                    : const [
                        Color(0x4FD9CFBE),
                        Color(0x2FB9AFA0),
                        Color(0x10A19789),
                        Color(0x00A19789),
                      ],
                stops: const [0.0, 0.30, 0.58, 1.0],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SoftVeil extends StatelessWidget {
  const _SoftVeil();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0x06000000),
            Color(0x12000000),
            Color(0x4A07090B),
          ],
          stops: [0.0, 0.58, 1.0],
        ),
      ),
    );
  }
}
