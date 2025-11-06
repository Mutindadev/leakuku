import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Mock Data for Dashboard
    const int totalChickens = 500;
    const int currentAgeDays = 25;
    const double averageWeight = 1.25; // kg
    const int mortalityCount = 15;
    const String nextVaccination = 'Gumboro (Day 28)';

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('PoultryPro Dashboard'),
        backgroundColor: const Color(0xFF4CAF50),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.bell),
            onPressed: () {
              // Handle notifications
            },
          ),
          IconButton(
            icon: const Icon(FontAwesomeIcons.user),
            onPressed: () {
              // Navigate to Profile
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGreetingCard(context),
            const SizedBox(height: 20),
            _buildQuickStats(totalChickens, currentAgeDays, averageWeight, mortalityCount),
            const SizedBox(height: 20),
            _buildSectionTitle(context, 'Growth Tracking (Weight)'),
            const SizedBox(height: 10),
            _buildWeightChart(context),
            const SizedBox(height: 20),
            _buildSectionTitle(context, 'Upcoming Events'),
            const SizedBox(height: 10),
            _buildUpcomingEventCard(context, nextVaccination),
          ],
        ),
      ),
    );
  }

  Widget _buildGreetingCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(
            FontAwesomeIcons.seedling,
            color: Color(0xFF4CAF50),
            size: 30,
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, Farmer John!',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF212121),
                    ),
              ),
              const Text(
                'Batch 2024-03 | Broilers',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats(int totalChickens, int currentAgeDays, double averageWeight, int mortalityCount) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: [
        _statCard(FontAwesomeIcons.egg, 'Total Chickens', totalChickens.toString(), const Color(0xFF4CAF50)),
        _statCard(FontAwesomeIcons.calendarDay, 'Age (Days)', currentAgeDays.toString(), const Color(0xFFFF9800)),
        _statCard(FontAwesomeIcons.weightHanging, 'Avg. Weight', '$averageWeight kg', Colors.blue),
        _statCard(FontAwesomeIcons.skull, 'Mortality', mortalityCount.toString(), Colors.red),
      ],
    );
  }

  Widget _statCard(IconData icon, String title, String value, Color color) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: color, size: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF212121)),
                ),
                Text(
                  title,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF212121),
          ),
    );
  }

  Widget _buildWeightChart(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LineChart(
            LineChartData(
              gridData: const FlGridData(show: false),
              titlesData: const FlTitlesData(show: false),
              borderData: FlBorderData(
                show: true,
                border: Border.all(color: const Color(0xff37434d), width: 1),
              ),
              minX: 0,
              maxX: 7,
              minY: 0,
              maxY: 4,
              lineBarsData: [
                LineChartBarData(
                  spots: const [
                    FlSpot(0, 0.05),
                    FlSpot(1, 0.2),
                    FlSpot(2, 0.45),
                    FlSpot(3, 0.75),
                    FlSpot(4, 1.25),
                    FlSpot(5, 1.8),
                    FlSpot(6, 2.5),
                    FlSpot(7, 3.2),
                  ],
                  isCurved: true,
                  color: const Color(0xFF4CAF50),
                  barWidth: 5,
                  isStrokeCapRound: true,
                  dotData: const FlDotData(show: true),
                  belowBarData: BarAreaData(show: false),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUpcomingEventCard(BuildContext context, String event) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      // ignore: deprecated_member_use
      color: const Color(0xFFFF9800).withOpacity(0.1), // Light accent color background
      child: ListTile(
        leading: const Icon(FontAwesomeIcons.syringe, color: Color(0xFFFF9800), size: 30),
        title: Text(
          'Next Event: $event',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: const Text('Prepare the vaccine and update your schedule.'),
        trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFFFF9800)),
        onTap: () {
          // Navigate to Feed & Vaccination Page
        },
      ),
    );
  }
}
