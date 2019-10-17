// 1.imports

import 'dart:async';
import 'employee.dart';

class EmployeeBloc {
// 2.List of Employees
//sink to add in pipe
// stream to get data from pipe
// by pipe i mean data flow

  List<Employee> _employeeList = [
    Employee(1, "Employee One", 10000.25),
    Employee(2, "Employee Two", 11000.25),
    Employee(3, "Employee Three", 12000.25),
    Employee(4, "Employee Four", 13000.25),
    Employee(5, "Employee Five", 14000.25),
    Employee(6, "Employee Six", 15000.25),
    Employee(7, "Employee Seven", 16000.25),
    Employee(8, "Employee Eight", 17000.25),
    Employee(9, "Employee Nine", 18000.25),
    Employee(10, "Employee Ten", 19000.25),
  ];

// 3.Stream Controllers

  final _employeeListStreamController = StreamController<List<Employee>>();

  final _employeeSalaryIncrementStreamController = StreamController();

  final _employeeSalaryDecrementStreamController = StreamController();

// getters

// 4.Stream Sink getter

  Stream<List<Employee>> get employeeListStream =>
      _employeeListStreamController.stream;
  StreamSink<List<Employee>> get employeeListSink =>
      _employeeListStreamController.sink;
  StreamSink<Employee> get employeeSalaryIncrement =>
      _employeeSalaryIncrementStreamController.sink;
  StreamSink<Employee> get employeeSalaryDecrement =>
      _employeeSalaryDecrementStreamController.sink;

//constructor
// 5.Constructor - add data; Listen to changes

  EmployeeBloc() {
    _employeeListStreamController.add(_employeeList);
    _employeeSalaryIncrementStreamController.stream.listen(_incrementSalary);
    _employeeSalaryDecrementStreamController.stream.listen(_decrementSalary);
  }

//core functions

// 6. Core functions

  _incrementSalary(Employee employee) {
    double salary = employee.salary;

    double incrementedSalary = salary * 20 / 100;

    _employeeList[employee.id - 1].salary = salary + incrementedSalary;

    employeeListSink.add(_employeeList);
  }

  void _decrementSalary(Employee employee) {
    double salary = employee.salary;

    double decrementedSalary = salary * 20 / 100;

    _employeeList[employee.id - 1].salary = salary - decrementedSalary;

    employeeListSink.add(_employeeList);
  }

// 7.dispose

  void dispose() {
    _employeeSalaryIncrementStreamController.close();
    _employeeSalaryDecrementStreamController.close();
    _employeeListStreamController.close();
  }
}
