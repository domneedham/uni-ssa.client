import 'package:ssa_app/app/data/models/user/manager.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';

final mockManager = Manager(id: 1, firstname: "D", surname: "N", staff: [1]);
final mockStaff =
    Staff(id: 2, firstname: "N", surname: "D", skills: [], managerId: 1);
