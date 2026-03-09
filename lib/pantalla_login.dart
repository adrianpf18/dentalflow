import 'package:flutter/material.dart';
import 'app_temas.dart';
import 'pantalla_registro.dart';

class PantallaLogin extends StatefulWidget {
  const PantallaLogin({super.key});

  @override
  State<PantallaLogin> createState() => _PantallaLoginState();
}

class _PantallaLoginState extends State<PantallaLogin> {
  // CLAVE FORMULARIO: Para identificar el formulario.
  // Nos permite identificar de forma única este formulario y poder validarlo.
  final _formKey = GlobalKey<FormState>();

  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _intentarLogin() {
    // 1. Validar el formulario (se aplican las reglas definidas en los TextFormField)
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // 2. Aquí irá la lógica de conexión al backend en el futuro.
    // Por ahora, se muestra un mensaje indicando que el formulario es válido.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Formulario válido. Listo para conectar al backend."),
        backgroundColor: Colors.green,
      ),
    );
  }

  // Logo y texto de la pantalla de logi
  Widget _construirCabecera() {
    return Column(
      children: [
        Image.asset(
          'assets/images/logo.png',
          height: 80, 
          fit: BoxFit.contain, 
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
      ],
    );
  }

  // Campo de email
  Widget _construirCampoEmail() {
    return TextFormField(
      controller: _emailCtrl,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: 'Email',
        prefixIcon: Icon(Icons.email_outlined),
      ),

      validator: (valor) {
        if (valor == null || valor.isEmpty) {
          return 'Por favor, introduce tu email';
        }
        if (!valor.contains('@')) {
          return 'Introduce un email válido';
        }
        return null; 
      },
    );
  }

  // Campo de contraseña
  Widget _construirCampoPassword() {
    return TextFormField(
      controller: _passCtrl,
      obscureText: true,
      decoration: const InputDecoration(
        labelText: 'Contraseña',
        prefixIcon: Icon(Icons.lock_outline),
      ),
      validator: (valor) {
        if (valor == null || valor.isEmpty) {
          return 'Por favor, introduce tu contraseña';
        }
        if (valor.length < 6) {
          return 'La contraseña debe tener al menos 6 caracteres';
        }
        return null; 
      },
    );
  }

  // Botón de login
  Widget _construirBotonLogin() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: _intentarLogin,
        child: const Text('Iniciar Sesión'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.fondo,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          // Usamos un Form para englobar nuestros campos y poder validarlos
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 60),

                _construirCabecera(),

                const SizedBox(height: 40),

                _construirCampoEmail(),

                const SizedBox(height: 16),

                _construirCampoPassword(),

                const SizedBox(height: 32),

                _construirBotonLogin(),

                const SizedBox(height: 16),

                TextButton(
                  onPressed: () {
                    // Nota: Aquí se está navegando a RegisterScreen desde pantalla_registro.dart
                    // Se podría renombrar la clase RegisterScreen a PantallaRegistro en el futuro para consistencia total.
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
      ),
    );
  }
}
