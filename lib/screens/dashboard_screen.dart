import 'package:Sanket/screens/alerts_screen.dart';
import 'package:Sanket/screens/bluetooth_screen.dart';
import 'package:Sanket/widgets/weather.dart';
import 'package:flutter/material.dart';
import '../widgets/action_button.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key, required this.onNavigate});
  final Function(int) onNavigate;

  @override
  Widget build(BuildContext context) {
    final today = DateFormat("dd MMM, yyyy").format(DateTime.now());

    return Scaffold(
      body: Container( decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/images/sanketbg.jpg"),
        fit: BoxFit.cover, 
      ),
    ),
        child: Column(
          children: [
            // 🔹 HEADER with gradient + glow
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Welcome Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TweenAnimationBuilder<double>(
                        duration: const Duration(milliseconds: 900),
                        tween: Tween(begin: 0, end: 1),
                        builder: (context, value, child) => Opacity(
                          opacity: value,
                          child: Transform.translate(
                            offset: Offset(0, (1 - value) * 20),
                            child: child,
                          ),
                        ),
                        child: const Text(
                          "Welcome to Sanket!",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Color.fromARGB(255, 122, 145, 186),
                                blurRadius: 12,
                                offset: Offset(0, 0),
                              )
                            ],
                          ),
                        ),
                      ),
                      // 🔔 Notification
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const AlertsScreen()),
                          );
                        },
                        icon: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            const Icon(Icons.notifications, color: Colors.white, size: 28),
                            Positioned(
                              right: 0,
                              top: -2,
                              child: Container(
                                height: 12,
                                width: 12,
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.redAccent,
                                      blurRadius: 6,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
        
                  const SizedBox(height: 16),
        
                  // 📅 Date Chip (glass)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white24, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(2, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      today,
                      style: const TextStyle(
                        color: Colors.white,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
        
                  const SizedBox(height: 12),
        
                  // 🌤 Weather
                  Container(
                    width: 120,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white24, width: 1),
                    ),
                    child: const WeatherWidget(),
                  ),
        
                  const SizedBox(height: 12),
                ],
              ),
            ),
        
            // 🔹 WHITE CONTENT AREA
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
                child: Container(
                  color: Colors.grey.shade50,
                  child: ListView(
                    padding: const EdgeInsets.all(18.0),
                    children: [
                      // Quick Actions
                      _animatedCard(
                        delay: 0,
                        child: _buildSectionCard(
                          context,
                          title: 'Quick Actions',
                          child: Row(
                            children: [
                              Expanded(
                                child: _animatedButton(
                                  ActionButton(
                                    title: 'New Report',
                                    icon: Icons.note_add,
                                    color: Colors.lightBlue,
                                    onPressed: () => onNavigate(1),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _animatedButton(
                                  ActionButton(
                                    title: 'Pair a device',
                                    icon: Icons.bluetooth,
                                    color: Colors.orangeAccent,
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(builder: (ctx) => const BluetoothScreen()),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
        
                      // Sync Status
                      _animatedCard(
                        delay: 200,
                        child: _buildSectionCard(
                          context,
                          title: 'Sync Status',
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Last Sync: 15 mins ago'),
                                  Text(
                                    '2 reports pending',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 4,
                                ),
                                onPressed: () {},
                                icon: const Icon(Icons.sync),
                                label: const Text('Sync Now'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
        
                      // Recent Reports
                      _animatedCard(
                        delay: 400,
                        child: _buildSectionCard(
                          context,
                          title: 'Recent Reports',
                          child: Column(
                            children: [
                              _animatedTile(_buildReportTile('Sunita Devi', '5 mins ago', true), 0),
                              _animatedTile(_buildReportTile('Ramesh Kumar', '2 hours ago', false), 1),
                              _animatedTile(_buildReportTile('Geeta Singh', 'Yesterday', false), 2),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Section Card
  Widget _buildSectionCard(BuildContext context, {required String title, required Widget child}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 6,
      shadowColor: Colors.black26,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey.shade800,
                  ),
            ),
            const SizedBox(height: 14),
            child,
          ],
        ),
      ),
    );
  }

  // Report Tile
  Widget _buildReportTile(String name, String time, bool isSynced) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
      subtitle: Text(time, style: TextStyle(color: Colors.grey.shade600)),
      trailing: Chip(
        label: Text(isSynced ? 'Synced' : 'Pending'),
        backgroundColor: isSynced ? Colors.green.shade100 : Colors.orange.shade100,
        labelStyle: TextStyle(
          color: isSynced ? Colors.green.shade800 : Colors.orange.shade800,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Animation helpers
  Widget _animatedCard({required int delay, required Widget child}) {
    return DelayedAnimation(delay: delay, child: child);
  }

  Widget _animatedTile(Widget child, int index) {
    return DelayedAnimation(delay: index * 200, child: child);
  }

  Widget _animatedButton(Widget child) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 400),
      tween: Tween(begin: 0.95, end: 1),
      builder: (context, value, _) => Transform.scale(scale: value, child: child),
    );
  }
}

// 🔹 Reusable Delayed Animation
class DelayedAnimation extends StatefulWidget {
  final Widget child;
  final int delay;
  const DelayedAnimation({super.key, required this.child, required this.delay});

  @override
  State<DelayedAnimation> createState() => _DelayedAnimationState();
}

class _DelayedAnimationState extends State<DelayedAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    final curve = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    _animOffset = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(curve);

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: SlideTransition(position: _animOffset, child: widget.child),
    );
  }
}
