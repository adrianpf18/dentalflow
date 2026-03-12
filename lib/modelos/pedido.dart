/// Modelo de datos que representa un pedido dental.
///
/// Cada pedido es creado por una clínica y se asigna a un laboratorio.
/// Es inmutable: para modificarlo, usa [copyWith].
class Pedido {
  final String? id;
  final String nombrePaciente;
  final String tipoTrabajo;
  final DateTime fechaEntrega;
  final String? comentarios;
  final String laboratorioAsignado;
  final String prioridad;
  final String estado;
  final DateTime fechaCreacion;

  Pedido({
    this.id,
    required this.nombrePaciente,
    required this.tipoTrabajo,
    required this.fechaEntrega,
    required this.laboratorioAsignado,
    this.comentarios,
    this.prioridad = 'Normal',
    this.estado = 'Solicitado',
    DateTime? fechaCreacion,
  }) : fechaCreacion = fechaCreacion ?? DateTime.now();

  // ---------------------------------------------------------------------------
  // Serialización
  // ---------------------------------------------------------------------------

  /// Convierte el pedido a un Map listo para Firestore / JSON.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombrePaciente': nombrePaciente,
      'tipoTrabajo': tipoTrabajo,
      'fechaEntrega': fechaEntrega.toIso8601String(),
      'comentarios': comentarios,
      'laboratorioAsignado': laboratorioAsignado,
      'prioridad': prioridad,
      'estado': estado,
      'fechaCreacion': fechaCreacion.toIso8601String(),
    };
  }

  /// Crea un [Pedido] a partir de un Map (Firestore / JSON).
  ///
  /// Si el mapa contiene datos corruptos o incompletos, lanza una
  /// [FormatException] con un mensaje descriptivo.
  factory Pedido.fromMap(Map<String, dynamic> map) {
    try {
      return Pedido(
        id: map['id'] as String?,
        nombrePaciente: map['nombrePaciente'] as String? ?? '',
        tipoTrabajo: map['tipoTrabajo'] as String? ?? '',
        fechaEntrega: DateTime.parse(map['fechaEntrega'] as String),
        laboratorioAsignado: map['laboratorioAsignado'] as String? ?? '',
        comentarios: map['comentarios'] as String?,
        prioridad: map['prioridad'] as String? ?? 'Normal',
        estado: map['estado'] as String? ?? 'Solicitado',
        fechaCreacion: map['fechaCreacion'] != null
            ? DateTime.parse(map['fechaCreacion'] as String)
            : null,
      );
    } catch (e) {
      throw FormatException(
        'Error al parsear Pedido desde Map: $e\nDatos recibidos: $map',
      );
    }
  }

  // ---------------------------------------------------------------------------
  // Utilidades
  // ---------------------------------------------------------------------------

  /// Devuelve una copia del pedido con los campos que indiques modificados.
  Pedido copyWith({
    String? id,
    String? nombrePaciente,
    String? tipoTrabajo,
    DateTime? fechaEntrega,
    String? comentarios,
    String? laboratorioAsignado,
    String? prioridad,
    String? estado,
    DateTime? fechaCreacion,
  }) {
    return Pedido(
      id: id ?? this.id,
      nombrePaciente: nombrePaciente ?? this.nombrePaciente,
      tipoTrabajo: tipoTrabajo ?? this.tipoTrabajo,
      fechaEntrega: fechaEntrega ?? this.fechaEntrega,
      comentarios: comentarios ?? this.comentarios,
      laboratorioAsignado: laboratorioAsignado ?? this.laboratorioAsignado,
      prioridad: prioridad ?? this.prioridad,
      estado: estado ?? this.estado,
      fechaCreacion: fechaCreacion ?? this.fechaCreacion,
    );
  }

  @override
  String toString() =>
      'Pedido(id: $id, paciente: $nombrePaciente, trabajo: $tipoTrabajo, '
      'estado: $estado, prioridad: $prioridad, lab: $laboratorioAsignado)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Pedido &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

