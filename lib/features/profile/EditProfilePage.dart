import 'package:coach_hub/core/theme/dark_mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';

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
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Edit Profile"),
        backgroundColor: AppColors.primary,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            _neumorphicField("Name", _nameController, isDark),
            const SizedBox(height: 15),

            _neumorphicReadOnly("Email", widget.email, isDark),
            const SizedBox(height: 15),

            _neumorphicField("Course", _courseController, isDark),
            const SizedBox(height: 15),

            _neumorphicReadOnly("Phone", widget.phone, isDark),
            const SizedBox(height: 15),

            _neumorphicField("Location", _locationController, isDark),
            const SizedBox(height: 30),

            // -------------------------
            // SAVE + CANCEL BUTTONS
            // -------------------------
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, {
                        'name': _nameController.text,
                        'course': _courseController.text,
                        'location': _locationController.text,
                        'email': widget.email,
                        'phone': widget.phone,
                      });

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
                        borderRadius: BorderRadius.circular(16),
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

                const SizedBox(width: 12),

                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.primary),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.primary,
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

  // ------------------------------------------------------------
  // 🔵 Neumorphic Text Field (Editable)
  // ------------------------------------------------------------
  Widget _neumorphicField(
    String label,
    TextEditingController controller,
    bool isDark,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: neumorphicBox(),
      child: TextField(
        controller: controller,
        style: TextStyle(color: AppColors.textDark),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: AppColors.textLight),
          border: InputBorder.none,
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // 🔵 Neumorphic Read-Only Field (Email, Phone)
  // ------------------------------------------------------------
  Widget _neumorphicReadOnly(String label, String value, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: neumorphicBox(),
      child: TextField(
        controller: TextEditingController(text: value),
        enabled: false,
        style: const TextStyle(color: AppColors.textLight),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: AppColors.textLight),
          border: InputBorder.none,
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // 🔵 Reusable Neumorphic Box Decoration
  // ------------------------------------------------------------
  BoxDecoration neumorphicBox() {
    return BoxDecoration(
      color: AppColors.background,
      borderRadius: BorderRadius.circular(18),
      boxShadow: const [
        BoxShadow(
          color: AppColors.lightShadow,
          blurRadius: 6,
          offset: Offset(-4, -4),
        ),
        BoxShadow(
          color: AppColors.darkShadow,
          blurRadius: 6,
          offset: Offset(4, 4),
        ),
      ],
    );
  }
}
