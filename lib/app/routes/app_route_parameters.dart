abstract class AppRouteParameterValues {
  static const FALSE = 'false';
  static const TRUE = 'true';
}

class StaffSkillOverviewParameters {
  const StaffSkillOverviewParameters({
    required this.id,
    required this.name,
    this.edit = AppRouteParameterValues.FALSE,
    this.assign = AppRouteParameterValues.FALSE,
  }) : assert(
          edit != AppRouteParameterValues.FALSE ||
              assign != AppRouteParameterValues.FALSE,
          'Edit or assign must not be null',
        );

  factory StaffSkillOverviewParameters.fromMap(Map<String, String?> map) {
    return StaffSkillOverviewParameters(
      id: map[StaffSkillOverviewParameters.ID]!,
      name: map[StaffSkillOverviewParameters.NAME]!,
      edit: map[StaffSkillOverviewParameters.EDIT] ??
          AppRouteParameterValues.FALSE,
      assign: map[StaffSkillOverviewParameters.ASSIGN] ??
          AppRouteParameterValues.FALSE,
    );
  }

  final String id;
  final String name;
  final String edit;
  final String assign;

  static const String ID = 'id';
  static const String NAME = 'name';
  static const String EDIT = 'edit';
  static const String ASSIGN = 'assign';

  Map<String, String> get toMap => {
        StaffSkillOverviewParameters.ID: id,
        StaffSkillOverviewParameters.NAME: name,
        StaffSkillOverviewParameters.EDIT: edit,
        StaffSkillOverviewParameters.ASSIGN: assign,
      };
}
