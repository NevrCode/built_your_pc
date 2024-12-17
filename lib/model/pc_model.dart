class PCModel {
  String id;
  String name;
  Map<String, dynamic> cpu;
  Map<String, dynamic> gpu;
  Map<String, dynamic> ssd;
  Map<String, dynamic> ram;
  Map<String, dynamic> psu;
  Map<String, dynamic> pcCase;
  Map<String, dynamic> mobo;

  PCModel({
    required this.id,
    required this.cpu,
    required this.name,
    required this.gpu,
    required this.ssd,
    required this.ram,
    required this.psu,
    required this.pcCase,
    required this.mobo,
  });

  factory PCModel.fromMap(Map<String, dynamic> map) {
    return PCModel(
      id: map['id'] as String,
      name: map['name'] as String,
      cpu: map['cpu'] as Map<String, dynamic>,
      gpu: map['gpu'] as Map<String, dynamic>,
      ram: map['ram'] as Map<String, dynamic>,
      ssd: map['ssd'] as Map<String, dynamic>,
      psu: map['psu'] as Map<String, dynamic>,
      pcCase: map['case'],
      mobo: map['mobo'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'cpu': cpu['id'],
      'gpu': gpu['id'],
      'ssd': ssd['id'],
      'ram': ram['id'],
      'psu': psu['id'],
      'mobo': mobo['id'],
      'case': pcCase['id'],
    };
  }

  // Map<String, dynamic> toMapComplete() {
  //   return {
  //     'id': id,
  //     'cpu': cpu.toMap(),
  //     'gpu': gpu.toMap(),
  //     'ssd': ssd.toMap(),
  //     'ram': ram.toMap(),
  //     'psu': psu.toMap(),
  //   };
  // }
}
