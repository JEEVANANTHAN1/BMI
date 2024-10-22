import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Body Mass Index',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: const DetailForm(),
    );
  }
}

class DetailForm extends StatefulWidget {
  const DetailForm({super.key});

  @override
  State<DetailForm> createState() => _DetailFormState();
}

class _DetailFormState extends State<DetailForm> {
  // Calculation Part
  String calc(String gender, String display) {
    if (gender.isEmpty) {
      display = "Select Gender";
    } else if (height.text.isEmpty) {
      display = "Enter Height";
    } else if (weight.text.isEmpty) {
      display = "Enter Weight";
    } else {
      // Convert height to meters and weight to kilograms
      double h = double.parse(height.text) / 100; // height in meters
      double w = double.parse(weight.text); // weight in kg

      // Calculate BMI using the correct formula
      double bmi = w / (h * h);

      if (bmi < 18.5) {
        display = "Underweight";
      } else if (bmi >= 18.5 && bmi <= 24.9) {
        display = "Normal weight";
      } else if (bmi >= 25 && bmi <= 29.9) {
        display = "Overweight";
      } else {
        display = "Obese";
      }
    }
    return display;
  }

  // Gender button colors
  Color maleColor = const Color(0xFF673AB7);
  Color femaleColor = const Color(0xFF673AB7);
  String gender = "";
  String display = "";
  final TextEditingController weight = TextEditingController();
  final TextEditingController height = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Gender:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: maleColor,
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(1),
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          // Set male button as selected, and female as unselected
                          gender = "male";
                          maleColor = Colors.brown;
                          femaleColor = const Color(0xFF673AB7); // Reset female
                        });
                        print("male");
                      },
                      icon: ClipRRect(
                          borderRadius: BorderRadius.circular(3),
                          child: Image.network(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTeWoRhF6Rvuaud4JHoCSXEsp7dn4zYjEtMDg&s',
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ))),
                ),
                const SizedBox(
                  width: 50,
                ),
                Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                      color: femaleColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          // Set female button as selected, and male as unselected
                          gender = "female";
                          femaleColor = Colors.brown;
                          maleColor = const Color(0xFF673AB7); // Reset male
                        });
                        print("female");
                      },
                      icon: ClipRRect(
                          borderRadius: BorderRadius.circular(3),
                          child: Image.network(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJv7ojWEx3SJncD-Xeb_TxI_5NIp5n2q6ipA&s',
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ))),
                ),
              ],
            ),
            const Text("Height:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
            const SizedBox(height: 10),
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 50, 0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: height,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Weight:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
            const SizedBox(height: 10),
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 50, 0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: weight,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        display = calc(gender, display);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF673AB7),
                        foregroundColor:
                            const Color.fromARGB(255, 252, 252, 253)),
                    child: const Text("Calculate")),
                IconButton(
                    onPressed: () {
                      setState(() {
                        height.clear();
                        weight.clear();
                        gender = "";
                        display = "";
                        maleColor = const Color(0xFF673AB7);
                        femaleColor = const Color(0xFF673AB7);
                      });
                    },
                    icon: const Icon(Icons.replay_outlined))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Center(
                child: Text(
              "Output:",
              style: TextStyle(fontSize: 25),
            )),
            Center(
                child: Text(
              "$display",
              style: TextStyle(fontSize: 25),
            ))
          ],
        ),
      ),
    );
  }
}
