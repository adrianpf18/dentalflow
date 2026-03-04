import 'package:flutter/material.dart';
import 'app_temas.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final llaveDelFormulario = GlobalKey<FormState>();

  // Variables de estado con nombres claros
  String? queSoy; // ¿Clínica o Laboratorio?
  bool estoyPensando = false; // Para el spinner de carga
  bool ocultarSecretos = true; // Para ver/ocultar contraseñas

  // Controladores (nombres cortos)
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
    // Limpieza al salir
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
      backgroundColor: AppTheme.fondo,
      appBar: AppBar(
        backgroundColor: AppTheme.fondo,
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
      // Envolvemos todo en un Form para que la "Llave Maestra" funcione
      body: Form(
        key: llaveDelFormulario,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tu solicitud será revisada manualmente antes de activar el acceso.',
                style: TextStyle(fontSize: 14, color: AppTheme.textoSecundario),
              ),
              const SizedBox(height: 32),

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

              // Solo mostramos el formulario si ya eligió quién es
              if (queSoy != null) ...[
                // Usamos TextFormField en lugar de TextField para poder validar
                TextFormField(
                  controller: nombreCtrl,
                  textInputAction:
                      TextInputAction.next, // Botón "Siguiente" en teclado
                  decoration: InputDecoration(
                    labelText: queSoy == 'Clínica'
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
                    labelText: queSoy == 'Clínica'
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
                  obscureText: ocultarSecretos,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        ocultarSecretos
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      onPressed: () {
                        setState(() => ocultarSecretos = !ocultarSecretos);
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
                  obscureText: ocultarSecretos,
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

                ElevatedButton(
                  onPressed: estoyPensando ? null : lanzarCohete,
                  child: estoyPensando
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text('Enviar Solicitud'),
                ),
                const SizedBox(height: 32),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // Widget simple para los botones de arriba
  Widget _botonOpcion(String tipo, IconData icono) {
    final seleccionado = queSoy == tipo;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => queSoy = tipo),
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

  void lanzarCohete() {
    // 1. Preguntamos a la llave maestra si todo está OK
    if (llaveDelFormulario.currentState!.validate()) {
      // 2. Si está OK, empezamos a cargar
      setState(() => estoyPensando = true);

      // Simulación de envío
      Future.delayed(const Duration(seconds: 2), () {
        if (!mounted) return; // Seguridad por si cerramos la pantalla antes
        setState(() => estoyPensando = false);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('¡Listo! Solicitud enviada.'),
            backgroundColor: AppTheme.primario,
          ),
        );
      });
    }
  }
}
