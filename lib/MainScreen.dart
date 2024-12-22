import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/addtodo.dart';
import 'package:url_launcher/url_launcher.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  //String text="simple text";
  List<String> todolist=[];

  void addtodo({required String todoText}){
    if(todolist.contains(todoText)) {
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Text("Already exist"),
          content: Text('This todo data already exist'),
          actions: [InkWell(child: Text('Close'),
          onTap: (){
            Navigator.pop(context);
          },)],
        );
      });
      return;
    }
    setState(() {
     // text="$todotext";
   // todolist.add(todotext);
      todolist.insert(0,todoText);
    });
    updatelocaldata();
    Navigator.pop(context);
  }

    void updatelocaldata()async{
      // Obtain shared preferences.
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setStringList('todolist',todolist);
    }
    void loadData()async{
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      setState(() {
        todolist= (prefs.getStringList('todolist') ?? []).toList();
      });
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child:Column(
          children: [
            Container(height:150,
            width:double.infinity,
            color: Colors.blueGrey[700],
            child: Center(child: Text("MY SOCIAL MEDIA ACCOUNTS",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white70),),),),
            ListTile(
              onTap: (){
                launchUrl(Uri.parse("https://github.com/wasif-kh4n"));
              },
              title: Text("My Github Account",style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: Icon(Icons.person,size: 30,color: Colors.blueGrey[700],),
            ),
            ListTile(
              onTap: (){
                launchUrl(Uri.parse("https://www.linkedin.com/in/wasif-khan-1064ab261/"));
              },
              title: Text("My Linkdin Account",style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: Icon(Icons.person,size: 30,color: Colors.blueGrey[700],),
            ),
            ListTile(
              onTap: (){
                launchUrl(Uri.parse("https://www.facebook.com/profile.php?id=100016376556285&mibextid=ZbWKwL%2F"));
              },
              title: Text("My Facebook Account",style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: Icon(Icons.person,size: 30,color: Colors.blueGrey[700],),
            ),
            ListTile(
              onTap: (){
                launchUrl(Uri.parse("https://www.instagram.com/wasif_kh4n/"));
              },
              title: Text("My Instagram Account",style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: Icon(Icons.person,size: 30,color: Colors.blueGrey[700],),
            ),

          ],
        )
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text("TODO APP",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold ),
        ),
      // backgroundColor: Colors.blueGrey,
        actions: [
          InkWell(
            splashColor: Colors.blueGrey[300],
          //  highlightColor: Colors.transparent,
           // enableFeedback: true,
            onTap: (){
             showModalBottomSheet(
               // backgroundColor: Colors.blueGrey,
                 context: context, builder: (context){
             //  backgroundColor: Colors.blueGrey,
               return Padding(
                 padding: MediaQuery.of(context).viewInsets,
                 child: Container(
                   padding: EdgeInsets.all(8),
                  // color: Colors.blueGrey
                   height :250,
                   child: Addtodo(addtodo: addtodo),
                 ),
               );
             });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.add,
                //  color: Colors.blueGrey,
                  size: 40),
            ),
          ),

        ],
      ),
     // body:/ Container(child: Text('$text'),),
      body:ListView.builder(
       // padding: EdgeInsets.all(10),
        itemCount: todolist.length,
          itemBuilder:(
              BuildContext context,int index){
            return ListTile(
             onTap: (){
               showModalBottomSheet(context: context, builder: (context){
                 return Container(
                   width: double.infinity,
                   padding: EdgeInsets.all(20),
                   child:ElevatedButton(onPressed: (){
                     setState(() {
                       todolist.removeAt(index);
                     });
                     updatelocaldata();
                     Navigator.pop(context);
                   }, child:Text('Mark as done'))
                 );

               });
             },
                title: Text(todolist[index]),
            //  leading:Icon(Icons.arrow_back_ios) ,
             // trailing: Icon(Icons.arrow_back_outlined),
            );

    }
      ),

    );
  }
}
