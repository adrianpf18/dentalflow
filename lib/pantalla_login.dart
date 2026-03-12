import 'package:flutter/material.dart';
import 'app_temas.dart';
import 'pantalla_registro.dart';
import 'principal_clinica.dart';

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
  
  bool _ocultarContrasena = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _intentarLogin() {
    // 1. Validar el formulario
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // 2. Aquí irá la lógica de conexión al backend en el futuro.
    // Por ahora, simulamos un éxito y redirigimos a la pantalla principal.
    // pushReplacement destruye la pantalla de login para que no se pueda volver atrás.
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const PantallaClinica()),
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
      obscureText: _ocultarContrasena,
      decoration: InputDecoration(
        labelText: 'Contraseña',
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(
            _ocultarContrasena
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
          onPressed: () {
            setState(() => _ocultarContrasena = !_ocultarContrasena);
          },
        ),
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
    return Container(
      width: double.infinity,
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primario.withAlpha(50),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0, // Quitamos la elevación por defecto para usar la sombra manual
        ),
        onPressed: _intentarLogin,
        child: const Text(
          'INICIAR SESIÓN',
          style: TextStyle(letterSpacing: 1.2),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.fondoInput, // Fondo gris muy clarito para el Scaffold
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _construirCabecera(),
                const SizedBox(height: 32),

                
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(10), // con Alpha en vez de opacity para evitar warnings
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _construirCampoEmail(),
                        const SizedBox(height: 20),
                        _construirCampoPassword(),
                        const SizedBox(height: 32),
                        _construirBotonLogin(),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

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
      ),
    );
  }
}
