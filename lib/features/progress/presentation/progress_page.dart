import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Tracking'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatCard(
              context,
              icon: FontAwesomeIcons.egg,
              title: 'Egg Production',
              value: '1,250',
              subtitle: 'This Month',
              color: const Color(0xFF4CAF50),
            ),
            const SizedBox(height: 12),
            _buildStatCard(
              context,
              icon: FontAwesomeIcons.chartLine,
              title: 'Growth Rate',
              value: '+12%',
              subtitle: 'Compared to Last Month',
              color: const Color(0xFFFF9800),
            ),
            const SizedBox(height: 12),
            _buildStatCard(
              context,
              icon: FontAwesomeIcons.heartPulse,
              title: 'Health Score',
              value: '95%',
              subtitle: 'All Flocks',
              color: Colors.blue,
            ),
            const SizedBox(height: 12),
            _buildStatCard(
              context,
              icon: FontAwesomeIcons.sackDollar,
              title: 'Revenue',
              value: '\$5,420',
              subtitle: 'This Month',
              color: Colors.green[700]!,
            ),
            const SizedBox(height: 24),
            Text(
              'Recent Activities',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            ...List.generate(5, (index) {
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: const Icon(FontAwesomeIcons.checkCircle, color: Color(0xFF4CAF50)),
                  title: Text('Activity ${index + 1}'),
                  subtitle: Text('Completed ${index + 1} days ago'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                  ),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
