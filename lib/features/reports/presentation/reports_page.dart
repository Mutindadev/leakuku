import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports & Analytics'),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.download),
            onPressed: () {
              // TODO: Download reports
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildReportCard(
            context,
            icon: FontAwesomeIcons.fileLines,
            title: 'Production Report',
            subtitle: 'Weekly egg production summary',
            date: 'Jan 15 - Jan 21, 2024',
            color: const Color(0xFF4CAF50),
          ),
          const SizedBox(height: 12),
          _buildReportCard(
            context,
            icon: FontAwesomeIcons.moneyBill,
            title: 'Financial Report',
            subtitle: 'Revenue and expenses breakdown',
            date: 'January 2024',
            color: Colors.green[700]!,
          ),
          const SizedBox(height: 12),
          _buildReportCard(
            context,
            icon: FontAwesomeIcons.heartPulse,
            title: 'Health Report',
            subtitle: 'Flock health and vaccination status',
            date: 'January 2024',
            color: Colors.blue,
          ),
          const SizedBox(height: 12),
          _buildReportCard(
            context,
            icon: FontAwesomeIcons.chartBar,
            title: 'Growth Analytics',
            subtitle: 'Weight and growth tracking',
            date: 'January 2024',
            color: const Color(0xFFFF9800),
          ),
          const SizedBox(height: 12),
          _buildReportCard(
            context,
            icon: FontAwesomeIcons.utensils,
            title: 'Feed Consumption',
            subtitle: 'Feed usage and efficiency',
            date: 'January 2024',
            color: Colors.brown,
          ),
        ],
      ),
    );
  }

  Widget _buildReportCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required String date,
    required Color color,
  }) {
    return Card(
      child: InkWell(
        onTap: () {
          // TODO: View report details
        },
        borderRadius: BorderRadius.circular(12),
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
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      date,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[500],
                          ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
