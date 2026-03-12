import 'dart:ui';
import 'package:flutter/material.dart';
import 'app_temas.dart';
import 'modelos/pedido.dart';

class PantallaNuevoPedido extends StatefulWidget {
  const PantallaNuevoPedido({super.key});

  @override
  State<PantallaNuevoPedido> createState() => _PantallaNuevoPedidoState();
}

class _PantallaNuevoPedidoState extends State<PantallaNuevoPedido> {
  final _formKey = GlobalKey<FormState>();
  
  final TextEditingController _pacienteCtrl = TextEditingController();
  final TextEditingController _trabajoCtrl = TextEditingController();
  final TextEditingController _comentariosCtrl = TextEditingController();
  
  DateTime? _fechaEntrega;
  String? _laboratorioSeleccionado;
  String _prioridadSeleccionada = 'Normal';
  
  // Colores de la paleta para prioridades
  static const Color _turquesa = Color(0xFF5BBCB4);
  static const Color _naranja = Color(0xFFE8A87C);
  static const Color _rojoSuave = Color(0xFFE07A7A);
  
  final List<String> _laboratoriosDisponibles = [
    'Lab Dental Ruiz',
    'Cerámica Exprés',
    'Ortolab Centro',
    'Prótesis Avanzadas'
  ];

  @override
  void dispose() {
    _pacienteCtrl.dispose();
    _trabajoCtrl.dispose();
    _comentariosCtrl.dispose();
    super.dispose();
  }

  Color _colorPrioridad(String prioridad) {
    switch (prioridad) {
      case 'Urgente': return _rojoSuave;
      case 'Media':   return _naranja;
      default:        return _turquesa;
    }
  }

  IconData _iconoPrioridad(String prioridad) {
    switch (prioridad) {
      case 'Urgente': return Icons.warning_amber_rounded;
      case 'Media':   return Icons.schedule_rounded;
      default:        return Icons.check_circle_outline;
    }
  }

  String _descripcionPrioridad(String prioridad) {
    switch (prioridad) {
      case 'Urgente': return 'Entrega lo antes posible';
      case 'Media':   return 'Plazo ajustado';
      default:        return 'Plazo estándar';
    }
  }

  void _mostrarSelectorPrioridad() {
    final opciones = ['Normal', 'Media', 'Urgente'];
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle
                Container(
                  width: 40, height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const Text(
                  'Nivel de prioridad',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: AppTheme.textoPrincipal),
                ),
                const SizedBox(height: 20),
                ...opciones.map((p) {
                  final seleccionada = p == _prioridadSeleccionada;
                  final color = _colorPrioridad(p);
                  return GestureDetector(
                    onTap: () {
                      setState(() => _prioridadSeleccionada = p);
                      Navigator.pop(ctx);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: seleccionada ? color.withValues(alpha: 0.12) : Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: seleccionada ? color : Colors.grey.shade200,
                          width: seleccionada ? 1.8 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 38, height: 38,
                            decoration: BoxDecoration(
                              color: color.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(_iconoPrioridad(p), color: color, size: 20),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(p, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: seleccionada ? color : AppTheme.textoPrincipal)),
                                const SizedBox(height: 2),
                                Text(_descripcionPrioridad(p), style: TextStyle(fontSize: 12, color: AppTheme.textoSecundario)),
                              ],
                            ),
                          ),
                          if (seleccionada)
                            Icon(Icons.check_rounded, color: color, size: 22),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  void _mostrarSelectorLaboratorio() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle
                Container(
                  width: 40, height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Asignar laboratorio',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: AppTheme.textoPrincipal),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ..._laboratoriosDisponibles.map((lab) {
                  final seleccionado = lab == _laboratorioSeleccionado;
                  return GestureDetector(
                    onTap: () {
                      setState(() => _laboratorioSeleccionado = lab);
                      Navigator.pop(ctx);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: seleccionado ? _turquesa.withValues(alpha: 0.10) : Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: seleccionado ? _turquesa : Colors.grey.shade200,
                          width: seleccionado ? 1.8 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 38, height: 38,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5EDD8).withValues(alpha: 0.6),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.business_rounded, color: Color(0xFFB8A67E), size: 20),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(lab, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: seleccionado ? _turquesa : AppTheme.textoPrincipal)),
                          ),
                          if (seleccionado)
                            const Icon(Icons.check_rounded, color: _turquesa, size: 22),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _seleccionarFecha(BuildContext context) async {
    final DateTime? seleccionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF5BBCB4),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: AppTheme.textoPrincipal,
            ),
          ),
          child: child!,
        );
      },
    );

    if (seleccionada != null && seleccionada != _fechaEntrega) {
      setState(() {
        _fechaEntrega = seleccionada;
      });
    }
  }

  void _guardarPedido() {
    if (_formKey.currentState!.validate()) {
      if (_fechaEntrega == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Por favor, selecciona una fecha de entrega'),
            backgroundColor: Colors.redAccent,
          ),
        );
        return;
      }

      if (_laboratorioSeleccionado == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Por favor, asigna un laboratorio al pedido'),
            backgroundColor: Colors.redAccent,
          ),
        );
        return;
      }
      
      // Crear el modelo
      final nuevoPedido = Pedido(
        id: DateTime.now().millisecondsSinceEpoch.toString(), // ID temporal
        nombrePaciente: _pacienteCtrl.text.trim(),
        tipoTrabajo: _trabajoCtrl.text.trim(),
        fechaEntrega: _fechaEntrega!,
        comentarios: _comentariosCtrl.text.trim().isEmpty ? null : _comentariosCtrl.text.trim(),
        laboratorioAsignado: _laboratorioSeleccionado!,
        prioridad: _prioridadSeleccionada,
        fechaCreacion: DateTime.now(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle_outline, color: Colors.white),
              SizedBox(width: 8),
              Expanded(child: Text('Pedido creado con éxito')),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );

      // Regresar a la pantalla anterior después de un breve momento
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          Navigator.pop(context, nuevoPedido);
        }
      });
    } else {
       ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Corrija los campos obligatorios antes de continuar'),
            backgroundColor: Colors.redAccent,
          ),
        );
    }
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
          'Nuevo Pedido',
          style: TextStyle(
            color: AppTheme.textoPrincipal,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Datos del paciente',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textoPrincipal,
                ),
              ),
              const SizedBox(height: 16),
              
              // Tarjeta blanca para el formulario
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _pacienteCtrl,
                      decoration: InputDecoration(
                        labelText: 'Nombre del paciente',
                        prefixIcon: const Icon(Icons.person_outline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFF5BBCB4), width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.redAccent),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.redAccent, width: 2),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'El nombre del paciente es obligatorio';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _trabajoCtrl,
                      decoration: InputDecoration(
                        labelText: 'Tipo de trabajo (ej. Férula, Corona)',
                        prefixIcon: const Icon(Icons.medical_services_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFF5BBCB4), width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.redAccent),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.redAccent, width: 2),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'El tipo de trabajo es obligatorio';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    // Selector de Fecha de Entrega
                    InkWell(
                      onTap: () => _seleccionarFecha(context),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _fechaEntrega == null ? Colors.grey.shade300 : const Color(0xFF5BBCB4),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_today_outlined, 
                              color: _fechaEntrega == null ? Colors.grey.shade600 : const Color(0xFF5BBCB4),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                _fechaEntrega == null 
                                  ? 'Fecha de entrega (Obligatorio)' 
                                  : 'Entrega: ${_fechaEntrega!.day.toString().padLeft(2, '0')}/${_fechaEntrega!.month.toString().padLeft(2, '0')}/${_fechaEntrega!.year}',
                                style: TextStyle(
                                  color: _fechaEntrega == null ? Colors.grey.shade600 : AppTheme.textoPrincipal,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Selector de Prioridad (custom modal)
                    InkWell(
                      onTap: _mostrarSelectorPrioridad,
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                        decoration: BoxDecoration(
                          border: Border.all(color: _colorPrioridad(_prioridadSeleccionada).withValues(alpha: 0.6)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 32, height: 32,
                              decoration: BoxDecoration(
                                color: _colorPrioridad(_prioridadSeleccionada).withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(_iconoPrioridad(_prioridadSeleccionada), color: _colorPrioridad(_prioridadSeleccionada), size: 18),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Prioridad', style: TextStyle(fontSize: 11, color: AppTheme.textoSecundario)),
                                  const SizedBox(height: 2),
                                  Text(_prioridadSeleccionada, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: _colorPrioridad(_prioridadSeleccionada))),
                                ],
                              ),
                            ),
                            Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey.shade400),
                          ],
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Selector de Laboratorio (custom modal)
                    InkWell(
                      onTap: _mostrarSelectorLaboratorio,
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _laboratorioSeleccionado != null ? _turquesa.withValues(alpha: 0.6) : Colors.grey.shade300,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 32, height: 32,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5EDD8).withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.business_outlined, color: Color(0xFFB8A67E), size: 18),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Laboratorio', style: TextStyle(fontSize: 11, color: AppTheme.textoSecundario)),
                                  const SizedBox(height: 2),
                                  Text(
                                    _laboratorioSeleccionado ?? 'Selecciona un laboratorio',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: _laboratorioSeleccionado != null ? FontWeight.w600 : FontWeight.w400,
                                      color: _laboratorioSeleccionado != null ? AppTheme.textoPrincipal : Colors.grey.shade500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey.shade400),
                          ],
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _comentariosCtrl,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Notas adicionales o color (Opcional)',
                        alignLabelWithHint: true,
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(bottom: 48),
                          child: Icon(Icons.notes_outlined),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFF5BBCB4), width: 2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Botón de crear
              Container(
                width: double.infinity,
                height: 54,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF5BBCB4).withAlpha(50),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5BBCB4),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _guardarPedido,
                  child: const Text(
                    'CREAR PEDIDO',
                    style: TextStyle(
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}