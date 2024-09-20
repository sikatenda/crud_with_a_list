import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: MyWidget()));
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  //text edit controller for expense name
  TextEditingController nameController = TextEditingController();
  //text edit controller for expense amount
  TextEditingController amoutController = TextEditingController();

  //list of expenses
  List<Expenses> expenses = List.empty(growable: true);

  int Index = -1;

//dialog to create new record
  void createRecord() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              //dialog box to create a new record
              title: const Text('New Record'),
              content: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    //input environment for the user to input the expense name
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                          hintText: 'Name',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    //input environment for the user to input the expense amount
                    child: TextField(
                      controller: amoutController,
                      //get the input numbers only from the keyboard
                      keyboardType: TextInputType.number,
                      maxLength: 15,
                      decoration: const InputDecoration(
                          hintText: 'Amount',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)))),
                    ),
                  ),
                ],
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //button to save the user input
                    ElevatedButton(
                      onPressed: () {
                        String name = nameController.text.trim();
                        String amount = amoutController.text.trim();
                        if (name.isNotEmpty && amount.isNotEmpty) {
                          setState(() {
                            expenses.add(Expenses(
                                name: name, amount: int.parse(amount)));

                            nameController.clear();
                            amoutController.clear();
                          });
                          nameController.clear();
                          amoutController.clear();
                        }
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          textStyle: const TextStyle(color: Colors.white60)),
                      child: const Text(
                        'SAVE',
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    ElevatedButton(
                      //button to cancel the capturing process and close the dialog box
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          textStyle: const TextStyle(color: Colors.white)),
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              ]);
        });
  }

//dialog to update a record
  void updateRecord() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              //dialog box to update an existing record
              title: const Text('Update Record'),
              content: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    //input envoronment to update the name of the record
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    //input envoronment to update the amount of the record
                    child: TextField(
                      controller: amoutController,
                      keyboardType: TextInputType.number,
                      maxLength: 15,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)))),
                    ),
                  ),
                ],
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //button to update an existing record
                    ElevatedButton(
                      onPressed: () {
                        String name = nameController.text.trim();
                        String amount = amoutController.text.trim();
                        if (name.isNotEmpty && amount.isNotEmpty) {
                          setState(() {
                            expenses[Index].name = name;
                            expenses[Index].amount = int.parse(amount);
                            Index = -1;

                            nameController.clear();
                            amoutController.clear();
                          });
                        }
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          textStyle: const TextStyle(color: Colors.white)),
                      child: const Text(
                        'UPDATE',
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    //button to cancel the updating process and close the dialog box
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          textStyle: const TextStyle(color: Colors.white)),
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Center(
              child: Text("EXPENSES"), //the app title
            ),
            backgroundColor: Colors.cyan[300],
          ),
          //button to open the dialog box for creating a new record
          floatingActionButton: FloatingActionButton(
            onPressed: createRecord,
            child: const Icon(Icons.add),
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              //display "No data found" when list is empty
              expenses.isEmpty
                  ? const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('No data found'),
                      ],
                    )
                  : Expanded(
                      //list view builder
                      child: ListView.builder(
                        itemCount: expenses.length,
                        itemBuilder: (context, index) => getList(index),
                      ),
                    ),
            ],
          ),
          backgroundColor: Colors.grey[400],
        ));
  }

  Widget getList(int index) {
    return Card(
      child: Column(
        children: [
          //listile
          ListTile(
              leading: CircleAvatar(
                backgroundColor: index % 2 == 0 ? Colors.amber : Colors.blue,
                foregroundColor: Colors.black87,
                child: Text(
                  expenses[index].name[0],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        expenses[index].name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(expenses[index].amount.toString()),
                    ],
                  ),
                ],
              ),
              trailing: Wrap(
                alignment: WrapAlignment.end,
                children: [
                  //icon to open a dialog box and update an exixting record
                  IconButton(
                      onPressed: () {
                        nameController.text = expenses[index].name;
                        amoutController.text =
                            expenses[index].amount.toString();
                        setState(() {
                          updateRecord();
                          Index = index;
                        });
                      },
                      icon: const Icon(Icons.edit)),
                  //icon to delete an exixting record
                  IconButton(
                      onPressed: () {
                        setState(() {
                          expenses.removeAt(index);
                        });
                      },
                      icon: const Icon(Icons.delete)),
                ],
              )),
        ],
      ),
    );
  }
}

class Expenses {
  String name;
  int amount;
  Expenses({required this.name, required this.amount});
}
