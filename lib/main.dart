import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const CashPeakApp());
}

// ============================================================
// APP
// ============================================================

class CashPeakApp extends StatelessWidget {
  const CashPeakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CashPeak',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF080B0D),
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFB600),
          brightness: Brightness.dark,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

// ============================================================
// SPLASH
// ============================================================

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

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
          builder: (_) => const MainShell(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050607),
      body: Center(
        child: Image.asset(
          'assets/cashpeak_logo.png',
          width: 250,
          errorBuilder: (_, __, ___) {
            return const Icon(
              Icons.monetization_on,
              size: 100,
              color: Color(0xFFFFB600),
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
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int currentIndex = 0;
  int coins = 1250;

  String? upiId;

  final List<TransactionItem> transactions = [
    const TransactionItem(
      title: 'Welcome Bonus',
      coins: 500,
      icon: Icons.card_giftcard,
    ),
    const TransactionItem(
      title: 'Daily Check-in',
      coins: 40,
      icon: Icons.calendar_today,
    ),
    const TransactionItem(
      title: 'Video Reward',
      coins: 130,
      icon: Icons.play_circle,
    ),
  ];

  double get rupees => coins / 100;

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

    _showMessage('+$amount Coins added!');
  }

  void withdrawCoins(int amount) {
    if (amount < 10000) {
      _showMessage(
        'Minimum withdrawal is 10,000 Coins (₹100).',
      );
      return;
    }

    if (amount > coins) {
      _showMessage('Insufficient Coins.');
      return;
    }

    setState(() {
      coins -= amount;

      transactions.insert(
        0,
        TransactionItem(
          title: 'Withdrawal Request',
          coins: -amount,
          icon: Icons.arrow_upward,
        ),
      );
    });

    _showMessage(
      'Withdrawal request submitted successfully.',
    );
  }

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(
        coins: coins,
        onEarn: addCoins,
        onWithdraw: withdrawCoins,
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
        upiId: upiId,
        onSaveUpi: (value) {
          setState(() {
            upiId = value;
          });
          _showMessage('UPI ID saved successfully.');
        },
      ),
    ];

    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF101417),
        indicatorColor: const Color(0xFF2F3A05),
        selectedIndex: currentIndex,
        onDestinationSelected: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.task_alt_outlined),
            selectedIcon: Icon(Icons.task_alt),
            label: 'Earn',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet_outlined),
            selectedIcon: Icon(Icons.account_balance_wallet),
            label: 'Wallet',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
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
  final Function(int) onWithdraw;

  const HomePage({
    super.key,
    required this.coins,
    required this.onEarn,
    required this.onWithdraw,
  });

  double get rupees => coins / 100;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(context),
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
            InfoCard(
              icon: Icons.monetization_on_outlined,
              text: '100 Coins = ₹1',
            ),
            const SizedBox(height: 10),
            InfoCard(
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
            ActivityTile(
              icon: Icons.card_giftcard,
              title: 'Welcome Bonus',
              subtitle: '+500 Coins',
            ),
            ActivityTile(
              icon: Icons.calendar_today,
              title: 'Daily Check-in',
              subtitle: '+40 Coins',
            ),
            ActivityTile(
              icon: Icons.play_circle,
              title: 'Video Reward',
              subtitle: '+130 Coins',
            ),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/cashpeak_logo.png',
          width: 55,
          height: 55,
          errorBuilder: (_, __, ___) {
            return const Icon(
              Icons.monetization_on,
              size: 50,
              color: Color(0xFFFFB600),
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
                  color: Color(0xFFFFB600),
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
            Color(0xFF1C3200),
            Color(0xFF101A08),
          ],
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFB88600),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your Coins',
            style: TextStyle(
              color: Color(0xFFD0D0D0),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Coins Balance',
            style: TextStyle(
              color: Color(0xFFFFB600),
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            '$coins Coins',
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '≈ ₹${rupees.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 18,
              color: Color(0xFFFFD75A),
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
      color: const Color(0xFF151A1D),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          width: fullWidth ? double.infinity : null,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: const Color(0xFF30363A),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: const Color(0xFFFFB600),
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
        color: const Color(0xFF121619),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const SizedBox(width: 2),
          Icon(
            icon,
            color: const Color(0xFFFFB600),
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(fontSize: 15),
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
        backgroundColor: const Color(0xFF252A1A),
        child: Icon(
          icon,
          color: const Color(0xFFFFB600),
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
                color: Color(0xFFB0B0B0),
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
        color: const Color(0xFF13181B),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFF2B3135),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFF272A12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: const Color(0xFFFFB600),
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
                    color: Color(0xFF9B9B9B),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  reward,
                  style: const TextStyle(
                    color: Color(0xFFFFB600),
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
              backgroundColor: const Color(0xFFFFB600),
              foregroundColor: Colors.black,
            ),
            child: const Text('Earn'),
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
                  _showWithdrawDialog(context);
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
                  backgroundColor: const Color(0xFFFFB600),
                  foregroundColor: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                'Minimum 10000 Coins',
                style: TextStyle(
                  color: Color(0xFF9B9B9B),
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
            if (transactions.isEmpty)
              const Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Text('No transactions yet.'),
                ),
              )
            else
              ...transactions.map(
                (transaction) => TransactionTile(
                  item: transaction,
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showWithdrawDialog(BuildContext context) {
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
    final isPositive = item.coins >= 0;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: isPositive
            ? const Color(0xFF203015)
            : const Color(0xFF301515),
        child: Icon(
          item.icon,
          color: isPositive
              ? const Color(0xFFB7E85C)
              : const Color(0xFFFF6B6B),
        ),
      ),
      title: Text(item.title),
      trailing: Text(
        '${isPositive ? '+' : ''}${item.coins}',
        style: TextStyle(
          color: isPositive
              ? const Color(0xFFB7E85C)
              : const Color(0xFFFF6B6B),
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
  final String? upiId;
  final ValueChanged<String> onSaveUpi;

  const ProfilePage({
    super.key,
    required this.upiId,
    required this.onSaveUpi,
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
              backgroundColor: Color(0xFF252A1A),
              child: Icon(
                Icons.person,
                size: 55,
                color: Color(0xFFFFB600),
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'CashPeak User',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              upiId ?? 'UPI ID not added',
              style: const TextStyle(
                color: Color(0xFF9B9B9B),
              ),
            ),
            const SizedBox(height: 30),
            ProfileOption(
              icon: Icons.account_balance_wallet_outlined,
              title: 'UPI ID',
              subtitle: upiId ?? 'Add your UPI ID',
              onTap: () {
                _showUpiDialog(context);
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
                    builder: (_) => const NotificationsPage(),
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
                    color: Color(0xFFFFB600),
                  ),
                  children: const [
                    Text(
                      'CashPeak rewards app prototype.',
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

  void _showUpiDialog(BuildContext context) {
    final controller = TextEditingController(
      text: upiId ?? '',
    );

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Add UPI ID'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.emailAddress,
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
                final value = controller.text.trim();

                if (value.isEmpty) {
                  return;
                }

                Navigator.pop(dialogContext);
                onSaveUpi(value);
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
      color: const Color(0xFF13181B),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF252A1A),
          child: Icon(
            icon,
            color: const Color(0xFFFFB600),
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
            message: '500 Coins have been added to your account.',
          ),
          NotificationTile(
            icon: Icons.calendar_today,
            title: 'Daily Check-in',
            message: 'Complete your daily check-in and earn coins.',
          ),
          NotificationTile(
            icon: Icons.account_balance_wallet,
            title: 'Withdrawal',
            message: 'Minimum withdrawal is 10,000 Coins.',
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
      color: const Color(0xFF13181B),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF252A1A),
          child: Icon(
            icon,
            color: const Color(0xFFFFB600),
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
