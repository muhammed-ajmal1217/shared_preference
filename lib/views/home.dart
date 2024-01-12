import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharedpreferencesample/controller/sharedpref_functions.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    final pro=Provider.of<SharedProvider>(context,listen: false);
    pro.getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<SharedProvider>(
          builder: (context, pro, child) => 
           Column(
            children: [
              SizedBox(height: 30,),
              Text('Shared Preference',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
              SizedBox(height: 30,),
              TextFormField(
                controller: pro.nameController,
                decoration: InputDecoration(
                  hintText: 'Name'
                ),
              ),
              ElevatedButton(onPressed: () => pro.adddata(pro.nameController.text), child: Text('save')),
              Expanded(child: ListView.builder(itemBuilder: (context, index) {
                final data=pro.datas[index];
                return ListTile(
                  title: Text(data),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () => pro.deleteData(index),
                        child: Icon(Icons.delete)),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditPage(index: index),)),
                        child: Icon(Icons.edit)),
                    ],
                  ),
                  );
              },
              itemCount: pro.datas.length,
              ))
            ],
          ),
        ),
      ),
    );
  }


}

class EditPage extends StatefulWidget {
  final int index;

  EditPage({Key? key, required this.index}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late SharedProvider pro;

  @override
void initState() {
  super.initState();
  pro = Provider.of<SharedProvider>(context, listen: false);
  Future.delayed(Duration.zero, () {
    pro.getdata();
    pro.nameController.text = pro.datas[widget.index];
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SharedProvider>(
        builder: (context, pro, child) => Column(
          children: [
            SizedBox(height: 30,),
            Text(
              'Shared Preference',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 30,),
            TextFormField(
              controller: pro.nameController,
              decoration: InputDecoration(
                hintText: 'Name',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                  pro.updateData(
                pro.nameController.text,
                widget.index,
              );
              Navigator.pop(context);
              },
              child: Text('update'),
            ),
          ],
        ),
      ),
    );
  }
}