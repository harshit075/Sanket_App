import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onLogin;
  final VoidCallback? onRegister; // Register callback

  const LoginScreen({
    required this.onLogin,
    this.onRegister,
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey _menuKey = GlobalKey(); // Key to track the button

  bool _obscureText = true;
  String _selectedLanguage = 'English';

  // ✅ Email validator function
  String? emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final email = value.trim();
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(email)) {
      return 'Enter a valid email address';
    }
    return null; // valid
  }

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _showLanguageMenu() async {
    final RenderBox button =
        _menuKey.currentContext!.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    final Offset buttonPosition =
        button.localToGlobal(Offset.zero, ancestor: overlay);

    // Create a RelativeRect aligned to the bottom of the button
      final RelativeRect position = RelativeRect.fromLTRB(
    buttonPosition.dx,
    buttonPosition.dy + button.size.height,
    overlay.size.width - (buttonPosition.dx + button.size.width),
    overlay.size.height - (buttonPosition.dy + button.size.height),
  );
    final String? selected = await showMenu<String>(
      context: context,
      position: position,
      items: const [
        PopupMenuItem(value: 'English', child: Text('English')),
        PopupMenuItem(value: 'हिन्दी', child: Text('हिन्दी')),
        PopupMenuItem(value: 'অসমীয়া', child: Text('অসমীয়া')),
        PopupMenuItem(value: 'বাংলা', child: Text('বাংলা')),
      ],
    );

    if (selected != null) {
      setState(() {
        _selectedLanguage = selected;
      });
    }
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      widget.onLogin();
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.teal.shade50,
    resizeToAvoidBottomInset: true, 
    body: SafeArea(
      child: SingleChildScrollView(   
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40), // spacing at top
              
              // App Logo and Title section
              const CircleAvatar(
                radius: 40,
                backgroundColor: Colors.teal,
                child: Text(
                  'AS',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Arogya Setu NER',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal),
              ),
              const Text(
                'Smart Community Health Monitoring',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 48),

              // Email input
              TextFormField(
                controller: _idController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email ID',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: emailValidator,
              ),
              const SizedBox(height: 16),

              // Password input
              TextFormField(
                controller: _passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: IconButton(
                    icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility),
                    onPressed: _togglePasswordVisibility,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Sign In button
              ElevatedButton(
                onPressed: _handleLogin,
                child: const Text('Sign In', style: TextStyle(fontSize: 16)),
              ),

              // Register option
              TextButton(
                onPressed: widget.onRegister,
                child: const Text('New user? Register here'),
              ),

              const SizedBox(height: 40),

              // Footer
              TextButton.icon(
                
                key: _menuKey,
                onPressed: _showLanguageMenu,
                icon: const Icon(Icons.language),
                label: Text('Language: $_selectedLanguage'),
              ),
              const Text(
                'Version 1.1.0',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    ),
  );
}
}
