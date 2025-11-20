import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.mark_email_read),
            onPressed: () {
              // TODO: Mark all as read
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          final isUnread = index < 3;
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: isUnread ? const Color(0xFF4CAF50) : Colors.grey[300],
              child: Icon(
                _getNotificationIcon(index % 4),
                color: Colors.white,
                size: 20,
              ),
            ),
            title: Text(
              _getNotificationTitle(index % 4),
              style: TextStyle(
                fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            subtitle: Text(_getNotificationMessage(index % 4)),
            trailing: Text(
              '${index + 1}h ago',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
            onTap: () {
              // TODO: Navigate to notification detail
            },
          );
        },
      ),
    );
  }

  IconData _getNotificationIcon(int type) {
    switch (type) {
      case 0:
        return FontAwesomeIcons.bellConcierge;
      case 1:
        return FontAwesomeIcons.syringe;
      case 2:
        return FontAwesomeIcons.exclamationTriangle;
      case 3:
        return FontAwesomeIcons.chartLine;
      default:
        return FontAwesomeIcons.bell;
    }
  }

  String _getNotificationTitle(int type) {
    switch (type) {
      case 0:
        return 'Feeding Reminder';
      case 1:
        return 'Vaccination Due';
      case 2:
        return 'Health Alert';
      case 3:
        return 'Production Report Ready';
      default:
        return 'Notification';
    }
  }

  String _getNotificationMessage(int type) {
    switch (type) {
      case 0:
        return 'Time to feed Flock 1';
      case 1:
        return 'Flock 2 needs vaccination';
      case 2:
        return 'Check Flock 3 for health issues';
      case 3:
        return 'Weekly report is available';
      default:
        return 'You have a new notification';
    }
  }
}
