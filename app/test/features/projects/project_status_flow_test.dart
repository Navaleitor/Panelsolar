import 'package:flutter_test/flutter_test.dart';
import 'package:panelsolar/features/projects/domain/project_status_flow.dart';
import 'package:persistence/persistence.dart';

void main() {
  test('sigue el ciclo prospecto → … → mantenimiento', () {
    expect(
      ProjectStatusFlow.next(ProjectStatus.prospect),
      ProjectStatus.design,
    );
    expect(
      ProjectStatusFlow.next(ProjectStatus.quoted),
      ProjectStatus.installed,
    );
    expect(ProjectStatusFlow.next(ProjectStatus.maintenance), isNull);
    expect(ProjectStatusFlow.ordered.toSet(), ProjectStatus.values.toSet());
  });
}
