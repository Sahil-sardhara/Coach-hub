import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/dark_mode.dart';

class EditProfilePage extends StatefulWidget {
  final String name;
  final String course;
  final String location;
  final String email;
  final String phone;

  const EditProfilePage({
    super.key,
    required this.name,
    required this.course,
    required this.location,
    required this.email,
    required this.phone,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _courseController;
  late TextEditingController _locationController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _courseController = TextEditingController(text: widget.course);
    _locationController = TextEditingController(text: widget.location);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField("Name", _nameController, isDark),
            const SizedBox(height: 10),
            _buildReadOnlyField("Email", widget.email, isDark),
            const SizedBox(height: 10),
            _buildTextField("Course", _courseController, isDark),
            const SizedBox(height: 10),
            _buildReadOnlyField("Phone", widget.phone, isDark),
            const SizedBox(height: 10),
            _buildTextField("Location", _locationController, isDark),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final updatedProfile = {
                        'name': _nameController.text,
                        'course': _courseController.text,
                        'location': _locationController.text,
                        'email': widget.email,
                        'phone': widget.phone,
                      };

                      Navigator.pop(
                        context,
                        updatedProfile,
                      ); // <-- return updated data
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Profile updated successfully!"),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Save Changes",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.primary),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    bool isDark,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(color: isDark ? Colors.white : Colors.black),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildReadOnlyField(String label, String value, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: TextEditingController(text: value),
        enabled: false,
        style: TextStyle(color: isDark ? Colors.white : Colors.black),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 16,
          ),
        ),
      ),
    );
  }
}
