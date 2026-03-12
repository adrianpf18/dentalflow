import 'package:flutter/material.dart';
import 'app_temas.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final llaveDelFormulario = GlobalKey<FormState>();

  String? tipoEntidad;
  bool ocultarContrasena = true;

  final nombreCtrl = TextEditingController();
  final cifCtrl = TextEditingController();
  final direCtrl = TextEditingController();
  final telfCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final respCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final passRepetirCtrl = TextEditingController();

  @override
  void dispose() {
    // Limpieza
    nombreCtrl.dispose();
    cifCtrl.dispose();
    direCtrl.dispose();
    telfCtrl.dispose();
    emailCtrl.dispose();
    respCtrl.dispose();
    passCtrl.dispose();
    passRepetirCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.fondoInput,
      appBar: AppBar(
        backgroundColor: AppTheme.fondoInput,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textoPrincipal),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Solicitar Acceso',
          style: TextStyle(
            color: AppTheme.textoPrincipal,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: Form(
        key: llaveDelFormulario,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Tu solicitud será revisada manualmente antes de activar el acceso.',
                style: TextStyle(fontSize: 14, color: AppTheme.textoSecundario),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(10),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tipo de entidad',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textoPrincipal,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Botones de selección
                    Row(
                      children: [
                        _botonOpcion('Clínica', Icons.local_hospital_outlined),
                        const SizedBox(width: 12),
                        _botonOpcion('Laboratorio', Icons.science_outlined),
                      ],
                    ),
                    const SizedBox(height: 32),

                    if (tipoEntidad != null) ...[
                      TextFormField(
                        controller: nombreCtrl,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: tipoEntidad == 'Clínica'
                              ? 'Nombre de la clínica'
                              : 'Nombre del laboratorio',
                          prefixIcon: const Icon(Icons.business_outlined),
                        ),
                        validator: (valor) {
                          if (valor == null || valor.isEmpty)
                            return '¡Falta el nombre!';
                          return null;
                        },
                      ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: cifCtrl,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'CIF / NIF',
                    prefixIcon: Icon(Icons.badge_outlined),
                  ),
                  validator: (valor) =>
                      valor!.isEmpty ? 'Necesitamos el CIF' : null,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: direCtrl,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Dirección completa',
                    prefixIcon: Icon(Icons.location_on_outlined),
                  ),
                  validator: (valor) =>
                      valor!.isEmpty ? '¿Dónde está ubicado?' : null,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: telfCtrl,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Teléfono',
                    prefixIcon: Icon(Icons.phone_outlined),
                  ),
                  validator: (valor) =>
                      valor!.length < 9 ? 'Número inválido' : null,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Email profesional',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  validator: (valor) {
                    if (valor == null || !valor.contains('@')) {
                      return 'Esto no parece un email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: respCtrl,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: tipoEntidad == 'Clínica'
                        ? 'Responsable'
                        : 'Técnico responsable',
                    prefixIcon: const Icon(Icons.person_outlined),
                  ),
                  validator: (valor) =>
                      valor!.isEmpty ? '¿Quién es el responsable?' : null,
                ),
                const SizedBox(height: 16),

                // Contraseña con ojito para ver
                TextFormField(
                  controller: passCtrl,
                  obscureText: ocultarContrasena,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        ocultarContrasena
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      onPressed: () {
                        setState(() => ocultarContrasena = !ocultarContrasena);
                      },
                    ),
                  ),
                  validator: (valor) => (valor != null && valor.length < 6)
                      ? 'Mínimo 6 caracteres'
                      : null,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: passRepetirCtrl,
                  obscureText: ocultarContrasena,
                  textInputAction: TextInputAction.done, // Botón "Hecho"
                  decoration: const InputDecoration(
                    labelText: 'Confirmar contraseña',
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                  validator: (valor) {
                    if (valor != passCtrl.text)
                      return 'Las contraseñas no coinciden';
                    return null;
                  },
                ),

                const SizedBox(height: 32),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.secundario,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Tus datos serán tratados conforme al RGPD. Solo para gestionar tu acceso.',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.textoSecundario,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                const SizedBox(height: 24),

                Container(
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
                      elevation: 0,
                    ),
                    onPressed: _registrarUsuario,
                    child: const Text(
                      'ENVIAR SOLICITUD',
                      style: TextStyle(letterSpacing: 1.2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget simple para los botones de arriba
  Widget _botonOpcion(String tipo, IconData icono) {
    final seleccionado = tipoEntidad == tipo;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => tipoEntidad = tipo),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: seleccionado ? AppTheme.primario : AppTheme.fondoInput,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: seleccionado ? AppTheme.primario : AppTheme.bordeInput,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icono,
                color: seleccionado ? Colors.white : AppTheme.textoSecundario,
                size: 28,
              ),
              const SizedBox(height: 8),
              Text(
                tipo,
                style: TextStyle(
                  color: seleccionado ? Colors.white : AppTheme.textoSecundario,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _registrarUsuario() {
    if (llaveDelFormulario.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Formulario válido. Listo para conectar al backend.'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}
