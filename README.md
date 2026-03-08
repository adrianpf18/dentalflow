# DentalFlow 🦷

Plataforma móvil para la gestión y trazabilidad de trabajos protésicos 
entre clínicas dentales y laboratorios.

## ¿Qué problema resuelve?

La comunicación entre clínicas dentales y laboratorios protésicos 
sigue dependiendo de WhatsApp, llamadas y anotaciones en papel. 
Esto genera pérdida de información, incumplimientos del RGPD y 
errores de coordinación que afectan directamente a los pacientes.

DentalFlow centraliza todo el flujo en una sola app: creación de 
pedidos, seguimiento de estados en tiempo real, gestión de imágenes 
clínicas y control de acceso por roles.

## Stack tecnológico

- **Frontend:** Flutter (Dart) — Android e iOS desde un único código
- **Base de datos:** Cloud Firestore (NoSQL, sincronización en tiempo real)
- **Autenticación:** Firebase Authentication (tokens criptográficos)
- **Almacenamiento:** Firebase Cloud Storage (imágenes clínicas)
- **Control de versiones:** Git + GitHub

## Funcionalidades principales (MVP)

- Login con roles diferenciados (Clínica / Laboratorio)
- Gestión de pedidos con máquina de estados (FSM)
- Trazabilidad completa de cada transición (quién, cuándo, desde qué rol)
- Subida de imágenes clínicas vinculadas a cada pedido
- Aislamiento total de datos entre organizaciones (RBAC)
- Historial inmutable de pedidos cancelados y rechazados

## Estado del proyecto

| Fase | Estado |
|------|--------|
| Análisis y diseño | ✅ Completada |
| Core Frontend (Login, Registro) | ✅ Completada |
| Pantallas de gestión de pedidos | 🔄 En desarrollo |
| Lógica FSM y Security Rules | ⏳ Pendiente |
| Pruebas e integración | ⏳ Pendiente |

## Contexto académico

Proyecto de fin de grado — Grado Superior en Desarrollo de 
Aplicaciones Multiplataforma (DAM)  
Centro: I.E.S San Andrés  
Tutor: Roberto  
Autor: Adrián Palomo Faña
