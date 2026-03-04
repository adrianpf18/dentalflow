import 'package:flutter/material.dart';
import 'app_temas.dart';
import 'pantalla_registro.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  bool estaCargando = false;

  @override
  void dispose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  void intentarLogin() async {
    setState(() => estaCargando = true);

    // Simulación de espera
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    setState(() => estaCargando = false);

    print("Email introducido: ${emailCtrl.text}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Usamos los colores de tu AppTheme
      backgroundColor: AppTheme.fondo,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const SizedBox(height: 60),

              // LOGO: Imagen .png cargada desde assets
              Image.asset(
                'assets/images/logo.png',
                height: 80, // Mantenemos el tamaño que tenías
                fit: BoxFit.contain, // Para que la imagen no se deforme
              ),

              const SizedBox(height: 30),
              const Text(
                'DentalFlow',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textoPrincipal,
                ),
              ),
              const Text(
                'Gestión de trabajos protésicos',
                style: TextStyle(fontSize: 15, color: AppTheme.textoSecundario),
              ),

              const SizedBox(height: 40),

              // CAMPO EMAIL
              TextField(
                controller: emailCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),

              const SizedBox(height: 16),

              // CAMPO PASSWORD
              TextField(
                controller: passCtrl,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  prefixIcon: Icon(Icons.lock_outline),
                ),
              ),

              const SizedBox(height: 32),

              // BOTÓN LOGIN: Con la lógica de carga aquí dentro
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: estaCargando ? null : intentarLogin,
                  child: estaCargando
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Iniciar Sesión'),
                ),
              ),

              const SizedBox(height: 16),

              // BOTÓN IR A REGISTRO
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterScreen()),
                  );
                },
                child: const Text(
                  '¿No tienes cuenta? Solicitar Acceso',
                  style: TextStyle(color: AppTheme.textoSecundario),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
