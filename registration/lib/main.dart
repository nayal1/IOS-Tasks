
import 'package:flutter/material.dart';

void main() {
  runApp(const RegistrationApp());
}

class RegistrationApp extends StatelessWidget {
  const RegistrationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User Registration',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF6F0E8),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF795548),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFFDDD0C2),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFF795548),
              width: 2,
            ),
          ),
        ),
      ),
      home: const RegistrationScreen(),
    );
  }
}

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() =>
      _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // Identifies the Form and allows us to validate all fields.
  final _formKey = GlobalKey<FormState>();

  // Controllers store the text entered by the user.
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _acceptTerms = false;
  bool _submitted = false;

  String _selectedRole = 'Student';

  // Releases the controllers when the screen is removed.
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Validates all fields and handles registration.
  void _register() {
    setState(() {
      _submitted = true;
    });

    final isFormValid =
        _formKey.currentState!.validate();

    if (!isFormValid || !_acceptTerms) {
      return;
    }

    // Prints the submitted data in the debug console.
    debugPrint('--- Registration Data ---');
    debugPrint('Full Name: ${_nameController.text.trim()}');
    debugPrint('Email: ${_emailController.text.trim()}'); 
    debugPrint('Password: ${_passwordController.text}');
    debugPrint('Role: $_selectedRole');
    debugPrint('Terms accepted: $_acceptTerms');
    debugPrint('-------------------------');

    // Displays a success message.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Registration successful!'),
        backgroundColor: Color(0xFF5D7350),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F0E8),
        title: const Text(
          'Create Account',
          style: TextStyle(
            color: Color(0xFF4E342E),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 500,
              ),
              child: Card(
                color: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    autovalidateMode:
                        AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.stretch,
                      children: [
                        const Icon(
                          Icons.person_add_alt_1,
                          size: 48,
                          color: Color(0xFF795548),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Join Our Community',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4E342E),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Fill in the details below to create your account.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 28),

                        // Full Name
                        const Text(
                          'Full Name',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _nameController,
                          keyboardType: TextInputType.name,
                          textCapitalization:
                              TextCapitalization.words,
                          decoration: const InputDecoration(
                            hintText: 'Enter your full name',
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty) {
                              return 'Full name is required.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 18),

                        // Email
                        const Text(
                          'Email Address',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _emailController,
                          keyboardType:
                              TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: 'name@narxoz.kz',
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                          validator: (value) {
                            final email = value?.trim() ?? '';

                            if (email.isEmpty) {
                              return 'Email is required.';
                            }

                            final atIndex = email.indexOf('@');
                            final dotIndex = email.lastIndexOf('.');

                            if (atIndex <= 0 ||
                                dotIndex <= atIndex + 1 ||
                                dotIndex == email.length - 1) {
                              return 'Enter a valid email address.';
                            }

                            return null;
                          },
                        ),
                        const SizedBox(height: 18),

                        // Password
                        const Text(
                          'Password',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: 'At least 6 characters',
                            prefixIcon: Icon(Icons.lock_outline),
                          ),
                          onChanged: (value) {
                            // Recheck Confirm Password while typing.
                            _formKey.currentState?.validate();
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required.';
                            }

                            if (value.length < 6) {
                              return 'Password must be at least 6 characters.';
                            }

                            return null;
                          },
                        ),
                        const SizedBox(height: 18),

                        // Confirm Password
                        const Text(
                          'Confirm Password',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: 'Re-enter your password',
                            prefixIcon: Icon(Icons.lock_reset),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password.';
                            }

                            if (value != _passwordController.text) {
                              return 'Passwords do not match.';
                            }

                            return null;
                          },
                        ),
                        const SizedBox(height: 22),

                        // User Role
                        const Text(
                          'I am a...',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          initialValue: _selectedRole,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.badge_outlined),
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'Student',
                              child: Text('Student'),
                            ),
                            DropdownMenuItem(
                              value: 'Teacher',
                              child: Text('Teacher'),
                            ),
                            DropdownMenuItem(
                              value: 'Developer',
                              child: Text('Developer'),
                            ),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                _selectedRole = value;
                              });
                            }
                          },
                        ),
                        const SizedBox(height: 18),

                        // Terms and Conditions
                        CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          controlAffinity:
                              ListTileControlAffinity.leading,
                          value: _acceptTerms,
                          title: const Text(
                            'I accept the Terms and Conditions',
                            style: TextStyle(fontSize: 14),
                          ),
                          activeColor: const Color(0xFF795548),
                          onChanged: (value) {
                            setState(() {
                              _acceptTerms = value ?? false;
                            });
                          },
                        ),

                        // Terms error appears after submission.
                        if (_submitted && !_acceptTerms)
                          const Padding(
                            padding: EdgeInsets.only(
                              left: 12,
                              bottom: 12,
                            ),
                            child: Text(
                              'You must accept the Terms and Conditions.',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          ),

                        const SizedBox(height: 12),

                        // Register Button
                        SizedBox(
                          height: 52,
                          child: ElevatedButton(
                            onPressed: _register,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF795548),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Register',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Please make sure all information is correct.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}