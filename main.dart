import 'package:flutter/material.dart';
//menyatakan mengimport paket flutter yang diperlukan untuk membangun ui

void main() {
  runApp(MyApp());
} //bertujuan untuk menjalankan aplikasi flutter

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulir Biodata',
      home: FormulirBiodata(), //yang berarti ketika dijalankan akan
      // menampilkan bagian yg pertama ini
    );//
  }
}

class FormulirBiodata extends StatefulWidget {//berfungsi untuk
  //mengubah tampilan widget apabila pengguna mulai menginput
  @override
  _FormulirBiodataState createState() => _FormulirBiodataState();
}

class _FormulirBiodataState extends State<FormulirBiodata> {
  String name = '';
  DateTime? selectedDate = DateTime.now();
  String gender = '';
  bool isEmployed = false;
  String aboutMe = '';
  String selectedOption = 'SMP'; // Nilai default
 //atribut

  void _submitForm() { //proses yg teradi ketika submit
    // Logika pengiriman formulir

    // Menampilkan snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Formulir berhasil dikirim!'),
      ),
    );

    // Tampilkan dialog atau halaman tambahan
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Sukses'),
        content: Text('Terima kasih atas pengisian formulir.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Tutup dialog
            },
            child: Text('Tutup'),
          ),
        ],
      ),
    );
  }



  TextEditingController nameController = TextEditingController();
  TextEditingController aboutMeController = TextEditingController();
//dapat menggunakan TextEditingController untuk mengatur nilai awal dari
// input teks dengan nameController.text = 'Nilai Awal' atau aboutMeController.text
// = 'Nilai Awal'.

  //proses yg terjadi ketika mereset
  void _resetForm() {
    setState(() {
      nameController.text = '';
      selectedDate = DateTime.now();
      gender = '';
      isEmployed = false;
      aboutMeController.text = '';
      selectedOption = 'SMP';
    });
  }
//semua kembali seperti default





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Dalam konteks formulir biodata, Scaffold biasanya digunakan di dalam
      // MyApp atau di dalam widget lain untuk menyusun elemen-elemen
      // formulir seperti TextField, RadioButton, Checkbox, dan sebagainya.
      appBar: AppBar(
        title: Text('Formulir Biodata'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Nama'),
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),

              SizedBox(height: 16.0),
              Text('Tanggal Lahir:'),
              Row(
                children: [
                  Expanded(
                    child: Text(selectedDate != null
                        ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                        //calender day
                        : 'Belum memilih tanggal'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDate ?? DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          selectedDate = pickedDate;
                        });
                      }
                    },
                    child: Text('Pilih Tanggal'),
                  ),
                ],
              ),

              SizedBox(height: 16.0),
              Text('Jenis Kelamin:'),
              Row(// widget horizontal
                children: [
                  Radio( //widget tombol pilihan tunggal
                    value: 'Laki-laki',
                    groupValue: gender, //atribut
                    onChanged: (value) { //yang dipilih
                      setState(() {
                        gender = value.toString(); //
                      });
                    },
                  ),
                  Text('Laki-laki'),
                  Radio(
                    value: 'Perempuan',
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value.toString();
                      });
                    },
                  ),
                  Text('Perempuan'),
                ],
              ),
              SizedBox(height: 16.0),
              CheckboxListTile(
                title: Text('Bekerja'),
                value: isEmployed, //boolean
                onChanged: (value) {
                  setState(() {
                    isEmployed = value!;
                  });
                },
              ),
              SizedBox(height: 16.0),
              Text('Tentang Saya:'),
              TextFormField(
                controller: aboutMeController,
                decoration: InputDecoration(border: OutlineInputBorder()), //border
                onChanged: (value) {
                  setState(() {
                    aboutMe = value;
                  }); //text area
                },
              ),

              SizedBox(height: 16.0),
              Text('Pendidikan:'),
              DropdownButtonFormField<String>( //widget yang menggunakan drop drown list
                value: selectedOption,
                onChanged: (String? value) {
                  setState(() {
                    selectedOption = value!;
                  });
                },
                items: ['SMP', 'SMA', 'KULIAH']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  ElevatedButton( //tombol submit
                    onPressed: _submitForm,
                    child: Text('Submit'),
                  ),
                  SizedBox(width: 16.0),
                  ElevatedButton(
                    onPressed: _resetForm,
                    child: Text('Reset'),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
