import 'package:bubbles/Injection.dart';
import 'package:bubbles/UI/Onboarding/SignUp_Screen/bloc/SignUp_bloc.dart';
import 'package:bubbles/UI/Onboarding/SignUp_Screen/bloc/SignUp_event.dart';
import 'package:bubbles/UI/Onboarding/SignUp_Screen/bloc/SignUp_state.dart';
import 'package:bubbles/UI/Onboarding/SignUp_Screen/pages/Gender_screen.dart';
import 'package:bubbles/UI/Onboarding/SignUp_Screen/pages/Interset_screen.dart';
import 'package:bubbles/UI/Onboarding/SignUp_Screen/pages/UserData.dart';
import 'package:bubbles/core/Colors/constants.dart';
import 'package:bubbles/core/theme/ResponsiveText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class WhichGender extends StatefulWidget {
  UsersData? Users;
  WhichGender({this.Users});


  @override
  State<WhichGender> createState() => _WhichGenderState();
}

class _WhichGenderState extends State<WhichGender> {
  final bloc2 = sl<SignUpBloc>();
  int SelectedGenderId = 1000;
@override
  void initState() {
    super.initState();
    bloc2.add(GetSubGenders());
    DiditOnce = true;
}
bool DiditOnce = false;
  List<int> Selected = [];
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    TextTheme _TextTheme = Theme.of(context).textTheme;
    ColorScheme ColorS = Theme.of(context).colorScheme;
    return  BlocBuilder(
        bloc: bloc2,
        builder: (BuildContext context, SignUpState state) {


          if (state.success! && DiditOnce){
            Selected = List.filled(
                state.GetSubGenders!.genders!.length,
                0);
            DiditOnce = false;
          }
          return   Scaffold(
            backgroundColor: Color(0xffEAEAEA),
            body: SafeArea(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: w/10,
                        margin: EdgeInsets.only(top: h/40,left: 10.w),
                        child: InkWell(
                          onTap: (){
                            WidgetsBinding.instance.addPostFrameCallback((_) =>
                                Navigator.of(context).pop()
                            );
                          },
                          child: Text('<',
                              textAlign: TextAlign.left,style: _TextTheme.headline1!.copyWith(
                                  color: Color.fromRGBO(148, 38, 87, 1),
                                  fontSize: 20.sp,
                                  letterSpacing: 0.3,
                                  fontWeight: FontWeight.w300,
                                  height: 1
                              )),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: h/40),
                        child: Text('How do you identify?', textAlign: TextAlign.center, style: TextStyle(
                            color: Color.fromRGBO(148, 38, 87, 1),
                            fontFamily: 'Red Hat Text',
                            fontSize: 20.sp,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w600,
                            height: 1.h
                        ),),
                      ),
                      Text(""),
                      Text("")
                    ],
                  ),
                  SizedBox(height: h/20,),
                  Center(
                    child: Stack(
                      children: [


                        (state.success == true)
                            ?
                    Container(
                      width: w/1.1,
                      height: h/1.4,
                      child: ListView.separated(
                        itemCount: state.GetSubGenders!.genders!.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return
                            InkWell(
                              onTap: (){
                                SelectedGenderId= state.GetSubGenders!.genders![index].id!;
                                Selected = List.filled(
                                    state.GetSubGenders!.genders!.length,
                                    0);
                                Selected[index] = 1;
                                setState(() { });
                              },
                              child: Container(
                                width: w/1.1,
                                height: h/9,
                                decoration: BoxDecoration(
                                  borderRadius : BorderRadius.only(
                                    topLeft: Radius.circular(5.r),
                                    topRight: Radius.circular(5.r),
                                    bottomLeft: Radius.circular(5.r),
                                    bottomRight: Radius.circular(5.r),
                                  ),
                                  color : Color.fromRGBO(207, 109, 56, 1),
                                )
                                ,child: Center(
                                  child:
                                  Container(
                                    margin: EdgeInsets.only(left: h/50),
                                    child:      Row(
                                      children: [
                                        Text(state.GetSubGenders!.genders![index].title!,
                                            textAlign: TextAlign.left, style :_TextTheme.headline1!.copyWith(
                                                color:  Selected[index] == 1 ?Colors.black :Color.fromRGBO(255, 255, 255, 1),
                                                fontFamily: 'Red Hat Text',
                                                fontSize: 20.sp,
                                                letterSpacing: 0.2,
                                                fontWeight: FontWeight.w400,
                                                height: 1.h
                                            )
                                        ),
                                      ],
                                    ),
                                  )

                              ),
                              ),
                            );
                        }, separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(height: 10.h,); },
                      ),
                    )
                            : state.isLoading == true
                            ? Container(
                            width: w/1.1,
                            height: h/1.4,
                            child: Center(child: listLoader(context: context)))
                            : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Container(
                                width: w/1.1,
                                height: h/1.4,

                                child: const Text("Error Was Found"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      if (SelectedGenderId!=1000) {
                        widget.Users!.SetGender(SelectedGenderId);
                     Navigator.pop(context);
                      }
                    },
                    child: Container(
                      width: w/1.3,
                      height: h/15,
                      margin: EdgeInsets.only(top: h/30),
                      decoration: BoxDecoration(
                        borderRadius : BorderRadius.only(
                          topLeft: Radius.circular(5.r),
                          topRight: Radius.circular(5.r),
                          bottomLeft: Radius.circular(5.r),
                          bottomRight: Radius.circular(5.r),
                        ),
                        color : Color.fromRGBO(148, 38, 87, 1),
                      ),
                      child: Center(
                        child:  Text('Confirm', textAlign: TextAlign.center,     style:
                        _TextTheme.headline1!.copyWith(
                            fontWeight: FontWeight.w600,
                          fontSize: 20.sp
                        ),),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          );
        });


  }
  Widget listLoader({context}) {
    return  SpinKitThreeBounce(
      color: Colors.blue,
      size: 30.0.w,
    );
  }
}
