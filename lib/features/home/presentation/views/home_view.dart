import 'package:flutter/material.dart';
import 'main_shell.dart';

/// Legacy HomeView — now redirects to MainShell.
/// Kept for compatibility if any screen references HomeView directly.
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // Delegate to MainShell which manages all tabs
    return const MainShell();
  }
}
