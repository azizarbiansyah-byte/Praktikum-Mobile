import 'package:flutter/material.dart';

class KategoriBMI {
  final double batasAtas;
  final String nama;
  const KategoriBMI(this.batasAtas, this.nama);
}

const kategoriPria = [
  KategoriBMI(18.5, 'Kekurangan Berat Badan'),
  KategoriBMI(25.0, 'Berat Badan Ideal'),
  KategoriBMI(30.0, 'Kelebihan Berat Badan'),
  KategoriBMI(double.infinity, 'Obesitas'),
];

const kategoriWanita = [
  KategoriBMI(18.5, 'Kekurangan Berat Badan'),
  KategoriBMI(25.0, 'Berat Badan Ideal'),
  KategoriBMI(30.0, 'Kelebihan Berat Badan'),
  KategoriBMI(double.infinity, 'Obesitas'),
];

class KalkulatorBMIScreen extends StatefulWidget {
  const KalkulatorBMIScreen({super.key});

  @override
  State<KalkulatorBMIScreen> createState() => _KalkulatorBMIScreenState();
}

class _KalkulatorBMIScreenState extends State<KalkulatorBMIScreen> {
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();

  double? _bmiResult;
  String _bmiInterpretation = 'Silahkan Masukan data anda';

  bool _isPria = true;
  Color get _warnaTema => _isPria ? Colors.lightBlue : Colors.pink.shade300;
  String get _judul => _isPria ? 'BMI Pria' : 'BMI Wanita';
  Color get _warnaHasil {
    final bmi = _bmiResult;
    if (bmi == null) return Colors.grey;
    if (bmi < 18.5) return Colors.blue;
    if (bmi < 25) return Colors.green;
    if (bmi < 30) return Colors.orange;
    return Colors.red;
  }

  String _cariKategori(double bmi) {
    final daftar = _isPria ? kategoriPria : kategoriWanita;
    return daftar.firstWhere((k) => bmi < k.batasAtas).nama;
  }

  void _gantiMode(bool pria) {
    setState(() {
      _isPria = pria;
    });
    if (_bmiResult != null) {
      _calculateBMI();
    }
  }

  void _calculateBMI() {
    final double weight = double.tryParse(_weightController.text) ?? 0;
    final double heightInCm = double.tryParse(_heightController.text) ?? 0;

    setState(() {
      if (weight > 0 && heightInCm > 0) {
        final double heightInM = heightInCm / 100;
        final double bmi = weight / (heightInM * heightInM);

        _bmiResult = bmi;
        _bmiInterpretation = _cariKategori(bmi);
      } else {
        _bmiResult = null;
        _bmiInterpretation = 'Masukan Data yang valid';
      }
    });
  }

  void _reset() {
    _weightController.clear();
    _heightController.clear();
    FocusScope.of(context).unfocus();
    setState(() {
      _bmiResult = null;
      _bmiInterpretation = 'Silahkan Masukan data anda';
    });
  }

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_judul),
        centerTitle: true,
        backgroundColor: _warnaTema,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SegmentedButton<bool>(
                segments: const [
                  ButtonSegment(
                    value: true,
                    label: Text('Pria'),
                    icon: Icon(Icons.male),
                  ),
                  ButtonSegment(
                    value: false,
                    label: Text('Wanita'),
                    icon: Icon(Icons.female),
                  ),
                ],
                selected: {_isPria},
                onSelectionChanged: (pilihan) => _gantiMode(pilihan.first),
              ),
              const SizedBox(height: 25),
              TextField(
                controller: _weightController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  labelText: 'Berat Badan (kg)',
                  icon: const Icon(Icons.monitor_weight_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: _heightController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  labelText: 'Tinggi Badan (cm)',
                  icon: const Icon(Icons.height),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: _calculateBMI,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _warnaTema,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Hitung BMI'),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: _reset,
                style: OutlinedButton.styleFrom(
                  foregroundColor: _warnaTema,
                  side: BorderSide(color: _warnaTema),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Reset'),
              ),
              const SizedBox(height: 40),
              const Text(
                'Hasil',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: _warnaTema.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      _bmiResult?.toStringAsFixed(1) ?? '--',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: _warnaHasil,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _bmiInterpretation,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: _warnaHasil),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
