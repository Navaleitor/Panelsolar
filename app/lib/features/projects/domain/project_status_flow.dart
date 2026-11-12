import 'package:persistence/persistence.dart';

/// Orden natural del ciclo de vida de un proyecto:
/// prospecto → diseño → cotizado → instalado → mantenimiento.
abstract final class ProjectStatusFlow {
  /// Estados en orden.
  static const List<ProjectStatus> ordered = [
    ProjectStatus.prospect,
    ProjectStatus.design,
    ProjectStatus.quoted,
    ProjectStatus.installed,
    ProjectStatus.maintenance,
  ];

  /// Estado siguiente, o `null` si ya está en el último.
  static ProjectStatus? next(ProjectStatus status) {
    final index = ordered.indexOf(status);
    return index + 1 < ordered.length ? ordered[index + 1] : null;
  }
}
