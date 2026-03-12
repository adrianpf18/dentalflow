import 'package:flutter/material.dart';
import 'app_temas.dart';
import 'nuevo_pedido.dart';

class PantallaClinica extends StatelessWidget {
  final String nombreClinica;
  const PantallaClinica({super.key, this.nombreClinica = 'Clínica Carrizo'});

  String get _saludo {
    final h = DateTime.now().hour;
    if (h < 14) return 'Buenos días';
    if (h < 21) return 'Buenas tardes';
    return 'Buenas noches';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.fondo,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const PantallaNuevoPedido()),
          );
        },
        backgroundColor: const Color(0xFF5BBCB4),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Nuevo pedido', style: TextStyle(fontWeight: FontWeight.w600)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 28),

              // Cabecera
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_saludo, style: const TextStyle(fontSize: 14, color: AppTheme.textoSecundario)),
                        Text(nombreClinica, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.textoPrincipal), overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded), color: AppTheme.textoPrincipal),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.menu_rounded), color: AppTheme.textoPrincipal),
                ],
              ),

              const SizedBox(height: 32),

              // Tarjetas resumen
              const Text('Resumen', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppTheme.textoPrincipal)),
              const SizedBox(height: 14),
              Row(
                children: [
                  _tarjeta('0', 'Pendientes', const Color(0xFF5BBCB4), Icons.hourglass_top_rounded),
                  const SizedBox(width: 14),
                  _tarjeta('0', 'En proceso', const Color(0xFFE8A87C), Icons.precision_manufacturing_rounded),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  _tarjeta('0', 'Enviados', const Color(0xFF7CB9E8), Icons.local_shipping_rounded),
                  const SizedBox(width: 14),
                  _tarjeta('0', 'Entregados', const Color(0xFF8FC99A), Icons.check_circle_rounded),
                ],
              ),

              // Lista vacía
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.inbox_rounded, size: 56, color: AppTheme.textoSecundario.withOpacity(0.4)),
                      const SizedBox(height: 12),
                      Text('No hay pedidos todavía', style: TextStyle(fontSize: 15, color: AppTheme.textoSecundario.withOpacity(0.6))),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tarjeta(String numero, String etiqueta, Color color, IconData icono) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Row(
          children: [
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
              child: Icon(icono, color: color, size: 20),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(numero, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: color, height: 1)),
                Text(etiqueta, style: const TextStyle(fontSize: 12, color: AppTheme.textoSecundario, fontWeight: FontWeight.w500)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}