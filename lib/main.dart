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
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/cashpeak_logo.png',
                  width: 55,
                  height: 55,
                  errorBuilder: (_, __, ___) {
                    return const Icon(
                      Icons.monetization_on,
                      size: 50,
                      color: Color(0xFF16A34A),
                    );
                  },
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CashPeak',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Earn More. Reach The Peak.',
                        style: TextStyle(
                          color: Color(0xFF16A34A),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const NotificationsPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.notifications_none),
                ),
              ],
            ),

            const SizedBox(height: 22),

            BalanceCard(
              coins: coins,
              rupees: rupees,
            ),

            const SizedBox(height: 25),

            const Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 14),

            Row(
              children: [
                Expanded(
                  child: ActionCard(
                    icon: Icons.play_circle_outline,
                    title: 'Watch & Earn',
                    onTap: () {
                      onEarn(
                        130,
                        'Video Reward',
                        Icons.play_circle,
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
                        Icons.quiz,
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
                  Icons.calendar_today,
                );
              },
            ),

            const SizedBox(height: 28),

            const Text(
              'How Coins Work',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
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
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            const ActivityTile(
              icon: Icons.card_giftcard,
              title: 'Welcome Bonus',
              subtitle: '+500 Coins',
            ),

            const ActivityTile(
              icon: Icons.calendar_today,
              title: 'Daily Check-in',
              subtitle: '+40 Coins',
            ),

            const ActivityTile(
              icon: Icons.play_circle,
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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFE7F7EC),
            Color(0xFFE8F7EC),
          ],
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 18,
            offset: Offset(0, 7),
          ),
        ],
        border: Border.all(
          color: const Color(0xFFB7DCC3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your Coins',
            style: TextStyle(
              color: Color(0xFF64748B),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Coins Balance',
            style: TextStyle(
              color: Color(0xFF16A34A),
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            '$coins Coins',
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '≈ ₹${rupees.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 18,
              color: Color(0xFF22C55E),
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
      elevation: 3,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          width: fullWidth ? double.infinity : null,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: const Color(0xFFE1E7E3),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: const Color(0xFF16A34A),
                size: 28,
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
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
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const SizedBox(width: 2),
          Icon(
            icon,
            color: const Color(0xFF16A34A),
          ),
          const SizedBox(width: 12),
          Text(text),
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
        backgroundColor: const Color(0xFFEAF7EE),
        child: Icon(
          icon,
          color: const Color(0xFF16A34A),
        ),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}

// ============================================================
// EARN PAGE
// ============================================================

class EarnPage extends StatelessWidget {
  final Function(int, String, IconData) onEarn;

  const EarnPage({
    super.key,
    required this.onEarn,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Earn Coins',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'Complete simple tasks and earn rewards.',
              style: TextStyle(
                color: Color(0xFF6B7280),
              ),
            ),

            const SizedBox(height: 25),

            EarnTaskCard(
              icon: Icons.play_circle_outline,
              title: 'Watch Video',
              reward: '+130 Coins',
              description: 'Watch a short video to earn coins.',
              onTap: () {
                onEarn(
                  130,
                  'Video Reward',
                  Icons.play_circle,
                );
              },
            ),

            const SizedBox(height: 14),

            EarnTaskCard(
              icon: Icons.quiz_outlined,
              title: 'Complete Quiz',
              reward: '+50 Coins',
              description: 'Answer a quick quiz and earn.',
              onTap: () {
                onEarn(
                  50,
                  'Quiz Reward',
                  Icons.quiz,
                );
              },
            ),

            const SizedBox(height: 14),

            EarnTaskCard(
              icon: Icons.calendar_today_outlined,
              title: 'Daily Check-in',
              reward: '+40 Coins',
              description: 'Check in once every day.',
              onTap: () {
                onEarn(
                  40,
                  'Daily Check-in',
                  Icons.calendar_today,
                );
              },
            ),

            const SizedBox(height: 14),

            EarnTaskCard(
              icon: Icons.card_giftcard_outlined,
              title: 'Welcome Bonus',
              reward: '+500 Coins',
              description: 'Your welcome reward.',
              onTap: () {
                onEarn(
                  500,
                  'Welcome Bonus',
                  Icons.card_giftcard,
                );
              },
            ),

            const SizedBox(height: 14),

            EarnTaskCard(
              icon: Icons.people_outline,
              title: 'Refer & Earn',
              reward: '+500 Coins',
              description: 'Invite friends and earn rewards.',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ReferEarnPage(
                      onEarn: onEarn,
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 14),

            EarnTaskCard(
              icon: Icons.casino_outlined,
              title: 'Spin & Earn',
              reward: 'Win up to 100 Coins',
              description: 'Spin the reward wheel.',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SpinEarnPage(
                      onEarn: onEarn,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// EARN TASK CARD
// ============================================================

class EarnTaskCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String reward;
  final String description;
  final VoidCallback onTap;

  const EarnTaskCard({
    super.key,
    required this.icon,
    required this.title,
    required this.reward,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE2E8E5),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFFF0FDF4),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF16A34A),
              size: 28,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  reward,
                  style: const TextStyle(
                    color: Color(0xFF16A34A),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF16A34A),
              foregroundColor: Colors.white,
            ),
            child: const Text('Open'),
          ),
        ],
      ),
    );
  }
}
// ============================================================
// WALLET PAGE
// ============================================================

class WalletPage extends StatelessWidget {
  final int coins;
  final List<TransactionItem> transactions;
  final Function(int) onWithdraw;

  const WalletPage({
    super.key,
    required this.coins,
    required this.transactions,
    required this.onWithdraw,
  });

  void showWithdrawDialog(BuildContext context) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Withdraw Coins'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Coins',
              hintText: 'Minimum 10000 coins',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final amount =
                    int.tryParse(controller.text.trim()) ?? 0;

                Navigator.pop(dialogContext);
                onWithdraw(amount);
              },
              child: const Text('Request'),
            ),
          ],
        );
      },
    ).then((_) {
      controller.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    final rupees = coins / 100;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Wallet',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 18),

            BalanceCard(
              coins: coins,
              rupees: rupees,
            ),

            const SizedBox(height: 22),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () {
                  showWithdrawDialog(context);
                },
                icon: const Icon(
                  Icons.account_balance_wallet,
                ),
                label: const Text(
                  'Withdraw Coins',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF16A34A),
                  foregroundColor: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 10),

            const Center(
              child: Text(
                'Minimum 10000 Coins',
                style: TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 12,
                ),
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              'Transaction History',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            ...transactions.map(
              (item) => TransactionTile(item: item),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// TRANSACTION TILE
// ============================================================

class TransactionTile extends StatelessWidget {
  final TransactionItem item;

  const TransactionTile({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final positive = item.coins >= 0;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: positive
            ? const Color(0xFFE5F5EA)
            : const Color(0xFFFDECEC),
        child: Icon(
          item.icon,
          color: positive
              ? const Color(0xFF16A34A)
              : const Color(0xFFDC2626),
        ),
      ),
      title: Text(item.title),
      trailing: Text(
        '${positive ? '+' : ''}${item.coins}',
        style: TextStyle(
          color: positive
              ? const Color(0xFF16A34A)
              : const Color(0xFFDC2626),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// ============================================================
// PROFILE PAGE
// ============================================================

class ProfilePage extends StatelessWidget {
  final String userName;
  final String userEmail;
  final String? upiId;
  final ThemeMode themeMode;

  final Function(String, String) onSaveAccount;
  final ValueChanged<ThemeMode> onSaveUpi;
  final ValueChanged<ThemeMode> onThemeChanged;

  final Function(int, String, IconData) onEarn;

  const ProfilePage({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.upiId,
    required this.themeMode,
    required this.onSaveAccount,
    required this.onSaveUpi,
    required this.onThemeChanged,
    required this.onEarn,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            const SizedBox(height: 15),

            const CircleAvatar(
              radius: 48,
              backgroundColor: Color(0xFFEAF7EE),
              child: Icon(
                Icons.person,
                size: 55,
                color: Color(0xFF16A34A),
              ),
            ),

            const SizedBox(height: 14),

            Text(
              userName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              userEmail.isEmpty
                  ? 'Email not added'
                  : userEmail,
              style: const TextStyle(
                color: Color(0xFF6B7280),
              ),
            ),

            const SizedBox(height: 30),

            ProfileOption(
              icon: Icons.person_outline,
              title: 'Account Details',
              subtitle: 'Name and email information',
              onTap: () {
                showAccountDialog(context);
              },
            ),

            const SizedBox(height: 12),

            ProfileOption(
              icon: Icons.account_balance_wallet_outlined,
              title: 'UPI ID',
              subtitle: upiId ?? 'Add your UPI ID',
              onTap: () {
                showUpiDialog(context);
              },
            ),

            const SizedBox(height: 12),

            ProfileOption(
              icon: Icons.people_outline,
              title: 'Refer & Earn',
              subtitle: 'Invite friends and earn coins',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ReferEarnPage(
                      onEarn: onEarn,
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 12),

            ProfileOption(
              icon: Icons.casino_outlined,
              title: 'Spin & Earn',
              subtitle: 'Spin and win coins',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SpinEarnPage(
                      onEarn: onEarn,
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 12),

            ProfileOption(
              icon: Icons.palette_outlined,
              title: 'Theme',
              subtitle: 'Dark, Light or System',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ThemePage(
                      currentMode: themeMode,
                      onThemeChanged: onThemeChanged,
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 12),

            ProfileOption(
              icon: Icons.notifications_none,
              title: 'Notifications',
              subtitle: 'View notifications',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const NotificationsPage(),
                  ),
                );
              },
            ),

            const SizedBox(height: 12),

            ProfileOption(
              icon: Icons.privacy_tip_outlined,
              title: 'Privacy Policy',
              subtitle: 'Read CashPeak privacy policy',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const PrivacyPolicyPage(),
                  ),
                );
              },
            ),

            const SizedBox(height: 12),

            ProfileOption(
              icon: Icons.info_outline,
              title: 'About CashPeak',
              subtitle: 'Version 1.0.0',
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: 'CashPeak',
                  applicationVersion: '1.0.0',
                  applicationIcon: const Icon(
                    Icons.monetization_on,
                    color: Color(0xFF16A34A),
                  ),
                  children: const [
                    Text(
                      'CashPeak rewards app.',
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void showAccountDialog(BuildContext context) {
    final nameController =
        TextEditingController(text: userName);

    final emailController =
        TextEditingController(text: userEmail);

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Account Details'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 14),

                TextField(
                  controller: emailController,
                  keyboardType:
                      TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final name =
                    nameController.text.trim();

                final email =
                    emailController.text.trim();

                if (name.isEmpty) return;

                Navigator.pop(dialogContext);

                onSaveAccount(name, email);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    ).then((_) {
      nameController.dispose();
      emailController.dispose();
    });
  }

  void showUpiDialog(BuildContext context) {
    final controller =
        TextEditingController(text: upiId ?? '');

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Add UPI ID'),
          content: TextField(
            controller: controller,
            keyboardType:
                TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'UPI ID',
              hintText: 'example@upi',
              prefixIcon: Icon(
                Icons.account_balance_wallet,
              ),
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final value =
                    controller.text.trim();

                if (value.isEmpty) return;

                Navigator.pop(dialogContext);

                onSaveUpi(value as ThemeMode);
              },
              child: const Text('Save UPI'),
            ),
          ],
        );
      },
    ).then((_) {
      controller.dispose();
    });
  }
}

// ============================================================
// PROFILE OPTION
// ============================================================

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const ProfileOption({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFFFFFFF),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFEAF7EE),
          child: Icon(
            icon,
            color: const Color(0xFF16A34A),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(
          Icons.chevron_right,
        ),
      ),
    );
  }
}
// ============================================================
// PRIVACY POLICY
// ============================================================

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: const [
          Text(
            'CashPeak Privacy Policy',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 8),

          Text(
            'Last updated: August 2026',
            style: TextStyle(
              color: Color(0xFF6B7280),
            ),
          ),

          SizedBox(height: 25),

          PolicySection(
            title: '1. Information We Collect',
            text:
                'CashPeak may allow users to enter basic account information such as name, email address and UPI ID.',
          ),

          PolicySection(
            title: '2. Rewards and Coins',
            text:
                'Coins displayed in this version are demonstration rewards. Production reward systems require a secure backend.',
          ),

          PolicySection(
            title: '3. Payments and Withdrawals',
            text:
                'Withdrawal requests shown in this prototype are simulated and do not process real payments.',
          ),

          PolicySection(
            title: '4. Data Security',
            text:
                'A production version should use secure authentication, encrypted communication and a protected backend.',
          ),

          PolicySection(
            title: '5. Contact',
            text:
                'Add your official CashPeak support email before publishing the production application.',
          ),
        ],
      ),
    );
  }
}

// ============================================================
// POLICY SECTION
// ============================================================

class PolicySection extends StatelessWidget {
  final String title;
  final String text;

  const PolicySection({
    super.key,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            text,
            style: const TextStyle(
              height: 1.5,
              color: Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// NOTIFICATIONS
// ============================================================

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          NotificationTile(
            icon: Icons.card_giftcard,
            title: 'Welcome Bonus',
            message:
                '500 Coins have been added to your account.',
          ),

          NotificationTile(
            icon: Icons.calendar_today,
            title: 'Daily Check-in',
            message:
                'Complete your daily check-in and earn coins.',
          ),

          NotificationTile(
            icon: Icons.account_balance_wallet,
            title: 'Withdrawal',
            message:
                'Minimum withdrawal is 10,000 Coins.',
          ),
        ],
      ),
    );
  }
}

// ============================================================
// NOTIFICATION TILE
// ============================================================

class NotificationTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;

  const NotificationTile({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFFFFFFF),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFEAF7EE),
          child: Icon(
            icon,
            color: const Color(0xFF16A34A),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(message),
        ),
      ),
    );
  }
}
