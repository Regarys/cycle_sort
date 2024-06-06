import 'package:cycle_sort/main.dart';
import 'package:flutter/material.dart';

class CycleSortPg extends StatefulWidget {
  const CycleSortPg({super.key});

  @override
  State<CycleSortPg> createState() => _CycleSortPgState();
}

class _CycleSortPgState extends State<CycleSortPg> {
  final formKey = GlobalKey<FormState>();
  final tecSblmUrut = TextEditingController();
  final tecStlhUrut = TextEditingController();
  final tecData = TextEditingController();
  List<int> list = [];
  List<String> steps = [];

  void addStep(String step) {
    setState(() {
      steps.add(step);
    });
  }

  void clearSteps() {
    setState(() {
      steps.clear();
    });
  }

  List<int> cycleSort(List<int> dataList) {
    int n = dataList.length;

    for (int cycleStart = 0; cycleStart < n - 1; cycleStart++) {
      int item = dataList[cycleStart];
      int pos = cycleStart;

      // Mencari dimana kita menaruh element seharusnya
      for (int i = cycleStart + 1; i < n; i++) {
        if (dataList[i] < item) {
          pos++;
        }
      }

      // Cek apabila elemennya sudah sesuai dengan posisi yang kita mau
      if (pos == cycleStart) {
        continue;
      }

      // letakkan element di tempat yang betul jika ada angka yang sama semisal ada 2 angka 5 disebuah data [ 2, 3, 5, 5,] maka angka dilettakkan di kanannya
      while (item == dataList[pos]) {
        pos++;
      }

      //pertukaran dan peletakan nilai
      int temp = dataList[pos];
      dataList[pos] = item;
      item = temp;

      // Rotate the rest of the cycle
      while (pos != cycleStart) {
        pos = cycleStart;
        for (int i = cycleStart + 1; i < n; i++) {
          if (dataList[i] < item) {
            pos++;
          }
        }

        // mengecek lagi apa ada yang sama atau tidak, jika ada maka diletakkan di kanan
        while (item == dataList[pos]) {
          pos++;
        }

        // peletakan dan pertukaran nilai lagi
        int temp = dataList[pos];
        dataList[pos] = item;
        item = temp;

        addStep(dataList.map((e) => e.toString()).join(', '));
      }
    }

    return List.from(dataList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cycle Sort'),
        automaticallyImplyLeading: true,
        backgroundColor: const Color(0xFFF4CE14),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyApp()));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Container(
                      width: 370,
                      child: TextFormField(
                        controller: tecData,
                        validator: (value) => value == null || value.isEmpty
                            ? 'Data masih kosong'
                            : null,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Klik Untuk Memasukkan Angkamu',
                          labelStyle: TextStyle(color: Color(0xFF495E57)),
                          hintText: 'Masukan Angka Satu Persatu',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Color(0xFFF4CE14)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Color(0xFF495E57)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFF495E57)),
                    child: Text(
                      'Data : ${list}',
                      style: TextStyle(color: Colors.white70, fontSize: 18),
                    ),
                  ),
                ),
                Container(
                  child: ButtonBar(
                    alignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FilledButton(
                        onPressed: () {
                          setState(() {
                            if (tecData.text.length != 0) {
                              int data = int.parse(tecData.text.toString());
                              list.add(data);
                              tecData.text = '';
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Kolom Masih Kosong')));
                            }
                          });
                        },
                        child: Text(
                          'Input',
                          style: TextStyle(fontSize: 14),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFF4CE14),
                          fixedSize: Size(150, 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            list.clear();
                            tecSblmUrut.text = '';
                            tecStlhUrut.text = '';
                            clearSteps();
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Data Telah Dihapus')));
                          });
                        },
                        child: Text(
                          'Hapus',
                          style: TextStyle(fontSize: 14),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF495E57),
                          fixedSize: Size(150, 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: FilledButton(
                    onPressed: () {
                      setState(() {
                        String dataNotSort = '';
                        String dataSort = '';
                        list.forEach((elementNotSort) {
                          dataNotSort = dataNotSort + ' ${elementNotSort} ';
                        });
                        tecSblmUrut.text = dataNotSort;
                        addStep(list.map((e) => e.toString()).join(', '));

                        list = cycleSort(list);

                        dataSort = '';
                        list.forEach((elementSort) {
                          dataSort = dataSort + ' ${elementSort} ';
                        });
                        tecStlhUrut.text = dataSort;
                      });
                    },
                    child: Text('Urutkan'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFb7a70f),
                      fixedSize: Size(355, 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      TextField(
                        maxLines: 2,
                        readOnly: true,
                        controller: tecSblmUrut,
                        decoration: InputDecoration(
                            labelText: 'Data sebelum pengurutan',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        maxLines: 2,
                        readOnly: true,
                        controller: tecStlhUrut,
                        decoration: InputDecoration(
                            labelText: 'Data Setelah pengurutan',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Langkah - Langkah Pengurutan',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF495E56)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                            color: Color(0xFFF4CE14),
                            borderRadius: BorderRadius.circular(20)),
                        child: ListView.builder(
                          itemCount: steps.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.all(8),
                              margin: EdgeInsets.symmetric(vertical: 4),
                              child: Text(
                                  'Langkah  ${index + 1}: ${steps[index]}'),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
