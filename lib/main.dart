import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const CashPeakApp());
}

// ============================================================
// CASHPEAK APP
// ============================================================

class CashPeakApp extends StatefulWidget {
  const CashPeakApp({super.key});

  @override
  State<CashPeakApp> createState() => _CashPeakAppState();
}

class _CashPeakAppState extends State<CashPeakApp> {
  ThemeMode themeMode = ThemeMode.light;

  static const Color green = Color(0xFF16A34A);
  static const Color darkGreen = Color(0xFF15803D);
  static const Color lightGreen = Color(0xFFEAF7EE);
  static const Color background = Color(0xFFF6F8F7);
  static const Color textDark = Color(0xFF111827);
  static const Color textGrey = Color(0xFF64748B);

  ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: green,
        brightness: Brightness.light,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        foregroundColor: textDark,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(
            color: Color(0xFFE5E7EB),
          ),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        elevation: 8,
        indicatorColor: lightGreen,
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF8FAFC),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Color(0xFFE2E8F0),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Color(0xFFE2E8F0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: green,
            width: 1.5,
          ),
        ),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: darkGreen,
      ),
    );
  }

  ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF0B1220),
      colorScheme: ColorScheme.fromSeed(
        seedColor: green,
        brightness: Brightness.dark,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF0B1220),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFF111827),
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(
            color: Color(0xFF1F2937),
          ),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: const Color(0xFF111827),
        elevation: 8,
        indicatorColor: const Color(0xFF163B27),
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF172033),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Color(0xFF293548),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Color(0xFF293548),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: green,
            width: 1.5,
          ),
        ),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: darkGreen,
      ),
    );
  }

  void changeTheme(ThemeMode mode) {
    setState(() {
      themeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CashPeak',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      home: SplashScreen(
        themeMode: themeMode,
        onThemeChanged: changeTheme,
      ),
    );
  }
}

// ============================================================
// SPLASH SCREEN
// ============================================================

class SplashScreen extends StatefulWidget {
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeChanged;

  const SplashScreen({
    super.key,
    required this.themeMode,
    required this.onThemeChanged,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => MainShell(
            themeMode: widget.themeMode,
            onThemeChanged: widget.onThemeChanged,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/cashpeak_logo.png',
          width: 210,
          errorBuilder: (_, __, ___) {
            return Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                color: const Color(0xFFEAF7EE),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Icon(
                Icons.monetization_on_rounded,
                size: 65,
                color: Color(0xFF16A34A),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ============================================================
// TRANSACTION MODEL
// ============================================================

class TransactionItem {
  final String title;
  final int coins;
  final IconData icon;

  const TransactionItem({
    required this.title,
    required this.coins,
    required this.icon,
  });
}

// ============================================================
// MAIN SHELL
// ============================================================

class MainShell extends StatefulWidget {
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeChanged;

  const MainShell({
    super.key,
    required this.themeMode,
    required this.onThemeChanged,
  });

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int currentIndex = 0;

  int coins = 1250;

  String userName = 'CashPeak User';
  String userEmail = '';
  String? upiId;

  final List<TransactionItem> transactions = [
    const TransactionItem(
      title: 'Welcome Bonus',
      coins: 500,
      icon: Icons.card_giftcard_rounded,
    ),
    const TransactionItem(
      title: 'Daily Check-in',
      coins: 40,
      icon: Icons.calendar_today_rounded,
    ),
    const TransactionItem(
      title: 'Video Reward',
      coins: 130,
      icon: Icons.play_circle_rounded,
    ),
  ];

  void addCoins(
    int amount,
    String title,
    IconData icon,
  ) {
    setState(() {
      coins += amount;

      transactions.insert(
        0,
        TransactionItem(
          title: title,
          coins: amount,
          icon: icon,
        ),
      );
    });

    showMessage('+$amount Coins added!');
  }

  void withdrawCoins(int amount) {
    if (amount < 10000) {
      showMessage(
        'Minimum withdrawal is 10,000 Coins (₹100).',
      );
      return;
    }

    if (amount > coins) {
      showMessage('Insufficient Coins.');
      return;
    }

    setState(() {
      coins -= amount;

      transactions.insert(
        0,
        TransactionItem(
          title: 'Withdrawal Request',
          coins: -amount,
          icon: Icons.arrow_upward_rounded,
        ),
      );
    });

    showMessage(
      'Withdrawal request submitted successfully.',
    );
  }

  void saveAccount(
    String name,
    String email,
  ) {
    setState(() {
      userName = name;
      userEmail = email;
    });

    showMessage('Account details saved.');
  }

  void showMessage(String text) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(text),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(
        coins: coins,
        onEarn: addCoins,
      ),
      EarnPage(
        onEarn: addCoins,
      ),
      WalletPage(
        coins: coins,
        transactions: transactions,
        onWithdraw: withdrawCoins,
      ),
      ProfilePage(
        userName: userName,
        userEmail: userEmail,
        upiId: upiId,
        themeMode: widget.themeMode,
        onSaveAccount: saveAccount,
        onSaveUpi: (value) {
          setState(() {
            upiId = value;
          });

          showMessage('UPI ID saved.');
        },
        onThemeChanged: widget.onThemeChanged,
        onEarn: addCoins,
      ),
    ];

    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.task_alt_outlined),
            selectedIcon: Icon(Icons.task_alt_rounded),
            label: 'Earn',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.account_balance_wallet_outlined,
            ),
            selectedIcon: Icon(
              Icons.account_balance_wallet_rounded,
            ),
            label: 'Wallet',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// ============================================================
// HOME PAGE
// ============================================================

class HomePage extends StatelessWidget {
  final int coins;
  final Function(int, String, IconData) onEarn;

  const HomePage({
    super.key,
    required this.coins,
    required this.onEarn,
  });

  @override
  Widget build(BuildContext context) {
    final rupees = coins / 100;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          18,
          14,
          18,
          25,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAF7EE),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    'assets/cashpeak_logo.png',
                    errorBuilder: (_, __, ___) {
                      return const Icon(
                        Icons.monetization_on_rounded,
                        color: Color(0xFF16A34A),
                        size: 34,
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CashPeak',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Earn More. Reach The Peak.',
                        style: TextStyle(
                          color: Color(0xFF16A34A),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .surface,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Theme.of(context)
                          .dividerColor,
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const NotificationsPage(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.notifications_none_rounded,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 22),

            // BALANCE
            BalanceCard(
              coins: coins,
              rupees: rupees,
            ),

            const SizedBox(height: 28),

            const Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 14),

            Row(
              children: [
                Expanded(
                  child: ActionCard(
                    icon: Icons.play_circle_outline_rounded,
                    title: 'Watch & Earn',
                    onTap: () {
                      onEarn(
                        130,
                        'Video Reward',
                        Icons.play_circle_rounded,
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ActionCard(
                    icon: Icons.quiz_outlined,
                    title: 'Quiz',
                    onTap: () {
                      onEarn(
                        50,
                        'Quiz Reward',
                        Icons.quiz_rounded,
                      );
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            ActionCard(
              icon: Icons.calendar_today_outlined,
              title: 'Daily Check-in',
              fullWidth: true,
              onTap: () {
                onEarn(
                  40,
                  'Daily Check-in',
                  Icons.calendar_today_rounded,
                );
              },
            ),

            const SizedBox(height: 28),

            const Text(
              'How Coins Work',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 12),

            const InfoCard(
              icon: Icons.monetization_on_outlined,
              text: '100 Coins = ₹1',
            ),

            const SizedBox(height: 10),

            const InfoCard(
              icon: Icons.account_balance_wallet_outlined,
              text: 'Minimum withdrawal = ₹100',
            ),

            const SizedBox(height: 28),

            const Text(
              'Recent Activity',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 12),

            const ActivityTile(
              icon: Icons.card_giftcard_rounded,
              title: 'Welcome Bonus',
              subtitle: '+500 Coins',
            ),

            const ActivityTile(
              icon: Icons.calendar_today_rounded,
              title: 'Daily Check-in',
              subtitle: '+40 Coins',
            ),

            const ActivityTile(
              icon: Icons.play_circle_rounded,
              title: 'Video Reward',
              subtitle: '+130 Coins',
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// BALANCE CARD
// ============================================================

class BalanceCard extends StatelessWidget {
  final int coins;
  final double rupees;

  const BalanceCard({
    super.key,
    required this.coins,
    required this.rupees,
  });

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness ==
        Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: dark
              ? const [
                  Color(0xFF123D27),
                  Color(0xFF0F2B20),
                ]
              : const [
                  Color(0xFFE9F9EE),
                  Color(0xFFDDF5E5),
                ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: dark
              ? const Color(0xFF24613F)
              : const Color(0xFFB7DCC3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              dark ? 0.20 : 0.06,
            ),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: dark
                      ? const Color(0xFF1B5135)
                      : Colors.white,
                  borderRadius:
                      BorderRadius.circular(13),
                ),
                child: const Icon(
                  Icons.account_balance_wallet_rounded,
                  color: Color(0xFF16A34A),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Your Balance',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Text(
            '$coins',
            style: TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.w900,
              color: dark
                  ? Colors.white
                  : const Color(0xFF166534),
              height: 1,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            'Coins',
            style: TextStyle(
              color: dark
                  ? const Color(0xFFA7F3C0)
                  : const Color(0xFF64748B),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 15),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: dark
                  ? const Color(0xFF0B2A1C)
                  : Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '≈ ₹${rupees.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Color(0xFF16A34A),
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// ACTION CARD
// ============================================================

class ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool fullWidth;

  const ActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          width: fullWidth ? double.infinity : null,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 18,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Theme.of(context).dividerColor,
            ),
          ),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF7EE),
                  borderRadius:
                      BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFF16A34A),
                  size: 23,
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
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

// ============================================================
// INFO CARD
// ============================================================

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoCard({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).dividerColor,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF7EE),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF16A34A),
              size: 21,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// ACTIVITY TILE
// ============================================================

class ActivityTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const ActivityTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: const Color(0xFFEAF7EE),
        child: Icon(
          icon,
          color: const Color(0xFF16A34A),
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: Color(0xFF16A34A),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
