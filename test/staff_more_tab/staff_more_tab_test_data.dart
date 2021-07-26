import 'package:ssa_app/app/data/models/user/manager.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';

final mockStaff =
    Staff(id: 1, firstname: "Test", surname: "User", managerId: 1, skills: []);

final mockManager =
    Manager(id: 1, firstname: "Test", surname: "Manager", staff: [1]);
