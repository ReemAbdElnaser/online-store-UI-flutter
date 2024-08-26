import 'package:flutter/material.dart';

class AboutTeamPage extends StatelessWidget {
  final List<Map<String, String>> teamMembers = [
    {
      'name': 'ٌReem abdelnasser ',
      'role': 'Lead Developer',
      'email': 'rema_21@app.com',
    },
    {
      'name': 'Reem abdelnasser ',
      'role': 'UI/UX Designer',
      'email': 'rema_21@app.com',
    },
    {
      'name': 'Reem abdelnasser ',
      'role': 'Quality Assurance',
      'email': 'rema_21@app.com',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('About the Team'),
        backgroundColor: const Color.fromARGB(255, 166, 128, 232),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Meet the Team',
              style: textTheme.titleLarge,
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: teamMembers.length,
                itemBuilder: (context, index) {
                  final member = teamMembers[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16.0),
                    elevation: 4.0,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            member['name']!,
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            member['role']!,
                            style: textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            member['email']!,
                            style: textTheme.bodySmall?.copyWith(
                              color: Colors.blue[800],
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
