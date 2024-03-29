import 'package:flutter/widgets.dart';
import 'package:ssa_app/app/data/models/skill/skill.dart';
import 'package:ssa_app/app/data/models/skill/staff_skill.dart';
import 'package:ssa_app/app/data/models/user/manager.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';

typedef SkillVoidCallback = void Function(Skill);
typedef IntVoidCallback = void Function(int);
typedef NullableIntVoidCallback = void Function(int?);

typedef NullableFutureStaffCallback = Future<Staff>? Function(int);
typedef NullableFutureManagerCallback = Future<Manager>? Function(int);

typedef WidgetCallbackStaffSkill = Widget Function(StaffSkill);
typedef NullableFutureStaffSkillListCallback = Future<List<StaffSkill>>?
    Function(List<int>);
