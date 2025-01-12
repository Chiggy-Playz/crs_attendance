import 'package:crs_attendance/config/extensions.dart';
import 'package:crs_attendance/models/employee.dart';
import 'package:crs_attendance/providers/employees/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class EmployeePage extends ConsumerStatefulWidget {
  const EmployeePage({super.key, this.id});

  static const routePath = '/employee/:id';
  static const routeName = 'employee';

  final String? id;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EmployeePageState();
}

class _EmployeePageState extends ConsumerState<EmployeePage> {
  String? get id => widget.id;
  bool get isCreating => id == null;
  final _formKey = GlobalKey<FormState>();
  EmployeeModel? _existingEmployee;

  String _name = '';
  int _salary = 0;
  Color _color = Colors.red;
  bool _disabled = false;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadEmployee();
  }

  Future<void> _loadEmployee() async {
    if (id == null) return;
    setState(() => _isLoading = true);
    try {
      _existingEmployee =
          await ref.read(employeeRepositoryProvider).getEmployee(id!);
      if (!mounted) return;
      if (_existingEmployee == null) {
        // Handle error
        context.showSnackBar("Employee not found");
        return;
      }
      setState(() {
        _name = _existingEmployee!.name;
        _salary = _existingEmployee!.salary;
        _color = _existingEmployee!.color;
        _disabled = _existingEmployee!.disabled;
      });
    } catch (e) {
      context.showErrorSnackBar("Failed to load employee: $e");
      context.pop();
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isCreating ? 'Create Employee' : 'Edit Employee'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildForm(),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              initialValue: _name,
              decoration: const InputDecoration(labelText: 'Name'),
              onSaved: (value) => _name = value!,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Name cannot be empty';
                }
                return null;
              },
            ),
            const Gap(16),
            TextFormField(
              initialValue: _salary.toString(),
              decoration: const InputDecoration(labelText: 'Salary'),
              keyboardType: TextInputType.number,
              onSaved: (value) => _salary = int.parse(value!),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Salary cannot be empty';
                }
                if (int.tryParse(value) == null) {
                  return 'Salary must be a number';
                }
                return null;
              },
            ),
            const Gap(16),
            ListTile(
              leading: Container(
                decoration: BoxDecoration(
                  color: _color,
                  shape: BoxShape.circle,
                ),
                width: 32,
              ),
              title: const Text('Color'),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              onTap: chooseColor,
            ),
            const Gap(16),
            if (!isCreating)
              SwitchListTile(
                secondary: const Icon(Icons.block),
                title: const Text("Disabled"),
                value: _disabled,
                onChanged: (value) => setState(() => _disabled = value),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ),
            const Gap(16),
            FilledButton(
              onPressed: saveEmployee,
              child: Text(isCreating ? 'Create' : 'Save'),
            ),
          ],
        ),
      ),
    );
  }

  void chooseColor() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: BlockPicker(
            pickerColor: _color,
            onColorChanged: (color) => setState(() => _color = color),
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Done'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Future<void> saveEmployee() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    final employee = EmployeeModel(
      id: id ?? "",
      name: _name,
      salary: _salary,
      color: _color,
      createdAt: _existingEmployee?.createdAt ?? DateTime.now(),
      disabled: _disabled,
    );

    if (isCreating) {
      await ref.read(employeeRepositoryProvider).addEmployee(employee);
    } else {
      await ref.read(employeeRepositoryProvider).updateEmployee(employee);
    }
    if (!mounted) return;
    context.pop();
  }
}
