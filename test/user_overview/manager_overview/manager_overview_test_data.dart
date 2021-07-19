import 'package:ssa_app/app/data/models/user/manager.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';

final mockManager =
    Manager(id: 1, firstname: "Test", surname: "User", staff: [1, 2]);

final mockStaffOne =
    Staff(id: 1, firstname: "Test", surname: "User", managerId: 1, skills: []);

final mockStaffTwo =
    Staff(id: 2, firstname: "Test", surname: "User", managerId: 1, skills: []);
