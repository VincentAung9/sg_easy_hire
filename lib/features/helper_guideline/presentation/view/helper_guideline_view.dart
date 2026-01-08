import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:sg_easy_hire/core/router/router.dart';

class HelperGuidelineView extends StatelessWidget {
  const HelperGuidelineView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guidelines'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(RoutePaths.home);
            }
          },
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Chip(
              label: Text('Important', style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.orange,
              side: BorderSide.none,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Platform Guidelines intro
            _buildSection(
              icon: Icons.description,
              color: Colors.teal,
              title: 'Platform Guidelines',
              subtitle:
                  'Follow these guidelines to ensure a positive experience and increase your chances of finding the perfect job.',
            ),

            SizedBox(height: 16),

            // Profile Completion
            _buildExpandableSection(
              icon: Icons.person,
              color: Colors.blue,
              title: 'Profile Completion',
              subtitle: 'Complete your profile accurately',
              items: [
                'Provide accurate personal information',
                'Upload a clear, professional photo',
                'List all relevant work experience',
                'Include certifications and skills',
                'Keep your contact information updated',
              ],
            ),

            SizedBox(height: 16),

            // Safety & Security
            _buildExpandableSection(
              icon: Icons.security,
              color: Colors.green,
              title: 'Safety & Security',
              subtitle: 'Stay safe while using the platform',
              items: [
                'Never share your password with anyone',
                'Verify employer information before interviews',
                'Report suspicious activities immediately',
                'Use only official communication channels',
                'Protect your personal documents',
              ],
            ),

            SizedBox(height: 16),

            // Professional Conduct
            _buildExpandableSection(
              icon: Icons.work,
              color: Colors.purple,
              title: 'Professional Conduct',
              subtitle: 'Maintain professionalism at all times',
              items: [
                'Respond to messages promptly',
                'Be honest about your skills and experience',
                'Dress appropriately for interviews',
                'Communicate respectfully with employers',
                'Honor your commitments and schedules',
              ],
            ),

            SizedBox(height: 16),

            // Interview Guidelines
            _buildExpandableSection(
              icon: Icons.video_call,
              color: Colors.orange,
              title: 'Interview Guidelines',
              subtitle: 'Prepare for successful interviews',
              items: [
                'Arrive on time for scheduled interviews',
                'Prepare questions about the job',
                'Bring necessary documents',
                'Follow up after interviews',
                'Notify if you need to reschedule',
              ],
            ),

            SizedBox(height: 24),
            Text(
              'Do\'s and Don\'ts',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Do's section
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.solidCircleCheck,
                        color: Colors.green,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Do's",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  _buildBullet(
                    'Keep your profile updated regularly',
                    Icons.check_circle,
                    Colors.green,
                  ),
                  _buildBullet(
                    'Respond to job offers within 24 hours',
                    Icons.check_circle,
                    Colors.green,
                  ),
                  _buildBullet(
                    'Provide honest feedback after placements',
                    Icons.check_circle,
                    Colors.green,
                  ),
                  _buildBullet(
                    'Report any issues through proper channels',
                    Icons.check_circle,
                    Colors.green,
                  ),
                  _buildBullet(
                    'Maintain confidentiality of employer information',
                    Icons.check_circle,
                    Colors.green,
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.pink[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.warning, color: Colors.red),
                      SizedBox(width: 8),
                      Text(
                        "Don'ts",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  _buildBullet(
                    'Share login credentials with others',
                    Icons.circle,
                    Colors.red,
                  ),
                  _buildBullet(
                    'Accept payment outside the platform',
                    Icons.circle,
                    Colors.red,
                  ),
                  _buildBullet(
                    'Misrepresent your qualifications',
                    Icons.circle,
                    Colors.red,
                  ),
                  _buildBullet(
                    'Ghost employers or miss interviews',
                    Icons.circle,
                    Colors.red,
                  ),
                  _buildBullet(
                    'Share inappropriate content',
                    Icons.circle,
                    Colors.red,
                  ),
                ],
              ),
            ),

            SizedBox(height: 32),

            // Help section
            Center(
              child: Column(
                children: [
                  Icon(Icons.help_outline, size: 40, color: Colors.teal),
                  SizedBox(height: 8),
                  Text(
                    'Need Help?',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text('Contact our support team'),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => context.go(
                      RoutePaths.helpSupport,
                    ), // Add your support action here
                    child: Text('Get Help'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.teal,
                      side: BorderSide(color: Colors.teal),
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

  Widget _buildBullet(String text, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 6,
            backgroundColor: color,
          ),

          SizedBox(width: 12),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  Widget _buildSection({
    required IconData icon,
    required Color color,
    required String title,
    String? subtitle,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 32, color: color),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                if (subtitle != null)
                  Text(subtitle, style: TextStyle(color: Colors.grey[600])),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableSection({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required List<String> items,
  }) {
    return ExpansionTile(
      initiallyExpanded: true,
      leading: Icon(icon, color: color),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      children: items
          .map(
            (item) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.circleCheck,
                    color: Colors.green,
                    size: 14,
                  ),
                  SizedBox(width: 12),
                  Expanded(child: Text(item)),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
