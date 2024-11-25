import 'package:flutter/material.dart';
import 'package:to_do_app/layout/home_screen.dart';

Widget defaultFormField(
        {required TextEditingController controller,
        required TextInputType type,
        bool isPassword = false,
        onChange,
        onSubmit,

        required  validate,
        required String label,
        required IconData prefix,
         suffix,
         onTap,
        bool isClickable = true,
        bool keyboardAppearance = true,

        }) => TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      validator: validate,

      onChanged: onChange,
      onFieldSubmitted: onSubmit,
      onTap: onTap,
      enabled: isClickable,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        border:const OutlineInputBorder(),
        suffixIcon: Icon(suffix) ,
        ),
    );



Widget buildTaskItem(Map mode)=> Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        
        crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      CircleAvatar(
      
        radius: 40,
        
        child: Text('${mode['time']}'),
        backgroundColor: maincolor,
      ),
      
      SizedBox(width:20),
       Column(mainAxisSize: MainAxisSize.min,
        
        children: [
          SizedBox(height: 10,),
          Text('${mode['title']}',style: TextStyle(fontSize : 16,fontWeight:FontWeight.bold)),
          Text('${mode['date']}',style: TextStyle(color:Colors.grey)),
      
        
        ],
      ),
      ],
      
      ),
    );

   