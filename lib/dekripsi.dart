import 'package:apk_kriptografi_modern/enkripsi.dart';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class Dekripsi extends StatefulWidget {
  const Dekripsi({
    super.key,
  });

  @override
  State<Dekripsi> createState() => _DekripsiState();
}

class _DekripsiState extends State<Dekripsi> {
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _keyController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();

  final key = encrypt.Key.fromLength(16);
  final iv = encrypt.IV.fromUtf8('1234567890123456');

  String _decrypt(String encryptedText, String key) {
    final encrypter = encrypt.Encrypter(encrypt.AES(encrypt.Key.fromUtf8(key)));
    final decrypted = encrypter.decrypt64(encryptedText, iv: iv);
    return decrypted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 400,
              height: 450,
              decoration: BoxDecoration(color: Colors.blue[100], borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Center(child: Text('Dekripsi', style: Theme.of(context).textTheme.headlineLarge)),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _inputController,
                      decoration: const InputDecoration(
                        labelText: 'Masukan Teks untuk di Dekripsi',
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _keyController,
                      decoration: const InputDecoration(
                        labelText: 'Masukkan Kunci (16 karakter)',
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _outputController,
                      decoration: const InputDecoration(
                        labelText: 'Hasil Dekripsi',
                      ),
                      readOnly: true,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _outputController.text = _decrypt(_inputController.text, _keyController.text);
                        });
                      },
                      child: const Text('Hasil Dekripsi'),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _inputController.clear();
                          _keyController.clear();
                          _outputController.clear();
                        });
                      },
                      child: const Text('Hapus Riwayat'),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        var route = MaterialPageRoute(
                          builder: (context) => const Enkripsi(),
                        );
                        Navigator.push(context, route);
                      },
                      child: const Text('Enkripsi'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Made By Qathrun Nada Annaqiya © 2024',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
