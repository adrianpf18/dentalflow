import 'package:flutter/material.dart';
import 'app_temas.dart';
import 'modelos/pedido.dart';

class TarjetaPedido extends StatelessWidget {
  final Pedido pedido;
  final VoidCallback? onCancelar;

  const TarjetaPedido({super.key, required this.pedido, this.onCancelar});

  // Color y texto del chip según el estado
  Map<String, dynamic> _infoEstado(String estado) {
    switch (estado) {
      case 'En Producción':
        return {'color': const Color(0xFF7CB9E8), 'texto': 'En Producción'};
      case 'Enviado':
        return {'color': const Color(0xFF9B8FD4), 'texto': 'Enviado'};
      case 'Entregado':
        return {'color': const Color(0xFF8FC99A), 'texto': 'Entregado'};
      case 'Cancelado':
        return {'color': Colors.redAccent, 'texto': 'Cancelado'};
      case 'Rechazado':
        return {'color': const Color(0xFFB85450), 'texto': 'Rechazado'};
      default: // Solicitado
        return {'color': const Color(0xFFE8A87C), 'texto': 'Solicitado'};
    }
  }

  // Tiempo restante hasta la fecha de entrega
  String _tiempoRestante() {
    final diferencia = pedido.fechaEntrega.difference(DateTime.now());
    if (diferencia.isNegative) return 'Vencido';
    if (diferencia.inHours < 48) return '${diferencia.inHours}h restantes';
    return '${diferencia.inDays}d restantes';
  }

  // Si quedan menos de 48h el texto va en rojo/naranja
  Color _colorTiempo() {
    final diferencia = pedido.fechaEntrega.difference(DateTime.now());
    if (diferencia.isNegative) return Colors.redAccent;
    if (diferencia.inHours < 48) return const Color(0xFFE8A87C);
    return AppTheme.textoSecundario;
  }

  String _formatearFecha(DateTime fecha) {
    return '${fecha.day.toString().padLeft(2, '0')}/${fecha.month.toString().padLeft(2, '0')}/${fecha.year}';
  }

  @override
  Widget build(BuildContext context) {
    final estado = pedido.estado;
    final info = _infoEstado(estado);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Fila superior: nombre paciente + fecha creación
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  pedido.nombrePaciente,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textoPrincipal),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                _formatearFecha(pedido.fechaCreacion),
                style: const TextStyle(fontSize: 12, color: AppTheme.textoSecundario),
              ),
            ],
          ),

          const SizedBox(height: 6),

          // Fila central: tipo de trabajo + tiempo restante
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                pedido.tipoTrabajo,
                style: const TextStyle(fontSize: 14, color: AppTheme.textoSecundario),
              ),
              Text(
                _tiempoRestante(),
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _colorTiempo()),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Fila inferior: chip estado + botón acción
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Chip de estado
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: (info['color'] as Color).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  info['texto'] as String,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: info['color'] as Color),
                ),
              ),

              // Botón acción solo si está Solicitado
              if (estado == 'Solicitado' && onCancelar != null)
                TextButton.icon(
                  onPressed: onCancelar,
                  icon: const Icon(Icons.cancel_outlined, size: 16, color: Colors.redAccent),
                  label: const Text('Cancelar', style: TextStyle(fontSize: 13, color: Colors.redAccent)),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
