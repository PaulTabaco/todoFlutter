import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String? _newTodoElement;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: _menuOpen,
                icon: const Icon(Icons.menu))
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('todoItems').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!((snapshot.data?.docs.length ?? 0) > 0)) {
            return const Text("List is Empty. You can make first", style: TextStyle(color: Colors.white));
          }
          return  ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: Key(snapshot.data?.docs[index].id ?? ""),
                  child: Card(
                    child: ListTile(
                      title: Text(snapshot.data?.docs[index].get('item') ?? ""),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_sweep),
                        color: Colors.blueGrey[200],
                        onPressed: () {
                          FirebaseFirestore.instance.collection('todoItems').doc(snapshot.data?.docs[index].id).delete();
                        },
                      ),
                    ),
                  ),
                  onDismissed: (direction) {
                    //if (direction == DismissDirection.endToStart ) {}
                    FirebaseFirestore.instance.collection('todoItems').doc(snapshot.data?.docs[index].id).delete();
                  },
                );
              }
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Добавить запись'),
                  content: TextField(
                    onChanged: (String value){
                        _newTodoElement = value;
                    },
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          FirebaseFirestore.instance.collection('todoItems').add({'item': _newTodoElement});

                          Navigator.of(context).pop();
                        },
                        child: const Text('Ok')),
                    ElevatedButton(
                        onPressed: () { Navigator.of(context).pop(); },
                        child: const Text('Cancel')),
                  ],
                );
              });
        }, //_incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add_alert, color: Colors.white,),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _menuOpen () {
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (BuildContext context) {
              return Scaffold(
                appBar: AppBar(title: const Text('Menu')),
                body: Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);},
                        child: const Text('На главную')),
                    const Padding(padding: EdgeInsets.only(left: 15)),
                    const Text('End of menu')
                  ],
                ),
              );
            })
    );
  }
}
