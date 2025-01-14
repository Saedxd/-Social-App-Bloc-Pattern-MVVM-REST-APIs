import 'dart:async';
import 'package:bubbles/App/app.dart';
import 'package:bubbles/Data/prefs_helper/iprefs_helper.dart';
import 'package:bubbles/Injection.dart';
import 'package:bubbles/UI/Profile/FindFriends_Screen/bloc/FindFriends_bloc.dart';
import 'package:bubbles/UI/Profile/FindFriends_Screen/bloc/FindFriends_event.dart';
import 'package:bubbles/UI/Profile/FindFriends_Screen/bloc/FindFriends_state.dart';
import 'package:bubbles/UI/Profile/Profile_Screen/bloc/profile_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:share_plus/share_plus.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:bubbles/core/Colors/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:showcaseview/showcaseview.dart';
import '../../QrScanner_Screen/pages/QrScanner_screen.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class FindFriends_screen extends StatefulWidget {
  const FindFriends_screen({Key? key}) : super(key: key);

  @override
  State<FindFriends_screen> createState() => _FindFriends_screenState();
}

class _FindFriends_screenState extends State<FindFriends_screen>{

  final _key1 = GlobalKey();
  final _key2 = GlobalKey();
  final pref = sl<IPrefsHelper>();
  final FindBLOC = sl<FindFriends>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _SearchController = TextEditingController();
  final _formkey1 = GlobalKey<FormState>();
  late FocusNode FocuseNODE;
  List<Contact> contacts = [];
  int contactsLength = 0;
  int ShownLength1 = 0;
  List<int> Selected = [0, 0];
  bool contactsLoaded = false;
  String subject = ' Bubbles is a socialMedia Application';
  List<String> recipents = [];
  ScrollController _controller = ScrollController();
  late final Email? email;
  bool diditOnce22 = false;

  @override
  void initState() {
    super.initState();
    FocuseNODE = FocusNode();
    FindBLOC.add(GetProfile());
    diditOnce22 = true;
  }

  @override
  void dispose() {
    super.dispose();
    _SearchController.dispose();
  }

  void _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
    print(_result);
  }

  void _onShareWithResult(BuildContext context, String UserHashID) async {
    ShareResult result;
    final box = context.findRenderObject() as RenderBox?;
    result = await Share.shareWithResult(UserHashID,
        subject: subject,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }

  bool diditonce = false;
  bool diditonce2 = false;

  CommingSoonPopup(
      BuildContext Context,
      double h,
      double w,
      String Value,
      String buttonValue,
      int FontSize
      ) async {
    return showDialog(
        context: Context,
           barrierDismissible: true,
        builder: (Context) {
          return AlertDialog(
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.all(h/100),
              content:Container(
                width: w/1.4,
                height: h/3,
                decoration: BoxDecoration(
                  borderRadius : BorderRadius.only(
                    topLeft: Radius.circular(8.285714149475098.r),
                    topRight:Radius.circular(8.285714149475098.r),
                    bottomLeft: Radius.circular(8.285714149475098.r),
                    bottomRight:Radius.circular(8.285714149475098.r),
                  ),
                  color: Colors.transparent,
                ),


                child: Stack(
                  children: [

                    Positioned(
                      top: h/12.5,
                      child: Container(
                        width: w/1.4,
                        height: h/4.2,
                        decoration: BoxDecoration(
                          borderRadius : BorderRadius.only(
                            topLeft: Radius.circular(8.285714149475098.r),
                            topRight: Radius.circular(8.285714149475098.r),
                            bottomLeft: Radius.circular(8.285714149475098.r),
                            bottomRight:Radius.circular(8.285714149475098.r),
                          ),
                          color : Color.fromRGBO(47, 47, 47, 1),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(""),


                            Center(
                              child: Text(Value,
                                textAlign: TextAlign.center, style: TextStyle(
                                    color: Color.fromRGBO(234, 234, 234, 1),
                                    fontFamily: 'Red Hat Display',
                                    fontSize:  13.sp,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                    height: 1
                                ),),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: h/15.5,
                                      width: w/2,
                                      decoration: BoxDecoration(
                                        borderRadius : BorderRadius.only(
                                          topLeft: Radius.circular(4.142857074737549.r),
                                          topRight: Radius.circular(4.142857074737549.r),
                                          bottomLeft:Radius.circular(4.142857074737549.r),
                                          bottomRight:Radius.circular(4.142857074737549.r),
                                        ),
                                        boxShadow : [BoxShadow(
                                            color: Color.fromRGBO(0, 0, 0, 0.25),
                                            offset: Offset(0,0),
                                            blurRadius: 6.628571510314941
                                        )],
                                        color : Color.fromRGBO(168, 48, 99, 1),
                                      ),
                                      child: Center(
                                        child:
                                        Text(buttonValue, textAlign: TextAlign.center, style: TextStyle(
                                            color: Color.fromRGBO(234, 234, 234, 1),
                                            fontFamily: 'Red Hat Text',
                                            fontSize:  12.sp,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w400,
                                            height: 1
                                        ),),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: h/8,
                      bottom: h/5,
                      child: SvgPicture.asset(
                        "Assets/images/widget.svg",
                        width: 90.w,
                      ),
                    ),
                  ],
                ),
              )

          );
        });
  }
  @override
  Widget build(BuildContext context) {
    TextTheme _textthem = Theme.of(context).textTheme;
    ColorScheme COLOR = Theme.of(context).colorScheme;
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      body: buildSafeArea(context, w, h),
    );
  }

  Widget buildSafeArea(BuildContext context, double w, double h) {
    TextTheme _TextTheme = Theme.of(context).textTheme;
    ColorScheme ColorS = Theme.of(context).colorScheme;
    return BlocBuilder(
        bloc: FindBLOC,
        builder: (BuildContext context, FindFriendsState state) {
          if (state.CopyMessageOpened!) {
            Future.delayed(const Duration(milliseconds: 1000), () {
              FindBLOC.add(CloseCopyMessage());
            });
          }

          if (state.IsCompletMessage!) {
            Future.delayed(const Duration(milliseconds: 1000), () {
              FindBLOC.add(CloseCompletMessage());
            });
          }

          if (state.success == true && diditonce == true) {
            if (state.error != "Access denied Please Allow Contact Service") {
              print("how many timess");
              contacts = state.contacts;

              contactsLength = contacts.length;
              contactsLength > 30
                  ? ShownLength1 = (contactsLength / 10).floor()
                  : ShownLength1 = (contactsLength / 2).floor();
              for (int i = 0; i < contacts.length; i++) {
                recipents.add(contacts[i].phones!.length >= 1
                    ? contacts[i].phones!.elementAt(0).value.toString()
                    : "");
              }
              FindBLOC.add(CloseContactMessage());
              FindBLOC.add(OpenCompletMessage());
              print(recipents);

              contactsLoaded = true;
            } else {
              FindBLOC.add(CloseContactMessage());
              Future.delayed(Duration.zero, () {
                CommingSoonPopup(context, h, w, state.error!.toString(),"Okay!", 18);
                // Page2().method(_scaffoldKey.currentContext!, "Error",
                //    state.error! , "Back");
              });
            }
            diditonce = false;
          }


          if (state.AddFreindSuccess! && diditonce2) {
            print("im in one");
            if (state.AddNewFriend!.statuscode == 200) {
              print("im in two");
              if (state.AddNewFriend!.msg=="You can't add your self as a friend") {
                Future.delayed(Duration.zero, () {
                  CommingSoonPopup(
                      context, h, w, "You cannot add yourself as a friend",
                      "whaaaaaat?", 18);
                //   // Page2().method(_scaffoldKey.currentContext!, "Friend request is successfully sent",
                //   //     state.AddNewFriend!.msg!, "Back");
              });
              }
              else if (state.AddNewFriend!.msg=="success") {
               Future.delayed(Duration.zero, () {
                  CommingSoonPopup(
                      context, h, w, "Friend request is successfully sent",
                      "Good!", 18);
                });
              }
              else if (state.AddNewFriend!.msg=="Wrong Serial name please try again"){
                Future.delayed(Duration.zero, () {
                  CommingSoonPopup(
                      context, h, w, "Serial is not found please try again with correct info",
                      "Good!", 18);
                  // Page2().method(_scaffoldKey.currentContext!, "Friend request is successfully sent",
                  //     state.AddNewFriend!.msg!, "Back");
                });
              }
              else if (state.AddNewFriend!.msg==" Friend Code Cant be Empty"){
             print("im in three");
             Future.delayed(Duration.zero, () {
                  CommingSoonPopup(
                      context, h, w, "Serial code can't be empty",
                      "ok!", 18);
             });

              }
            }
            diditonce2 = false;
          }

          if (state.success! && diditOnce22) {
            email = Email(
              body:
                  "Hey! 👋  Wondering what's happening around you right now? Download the app and get into the bubble!  https://bit.ly/bubbles.app You can find me with username ${state.ProfileDate!.user!.serial.toString()} Spread the news! Early sign up rewards available now.",
              subject: 'Bubbles',
              recipients: [''],
            );
            diditOnce22 = false;
          }

          alreatDialogBuilder(
            BuildContext Context,
            double h,
            double w,
            FindFriendsState state,
          ) async {
            return showDialog(
                context: Context,
                   barrierDismissible: true,
                builder: (Context) {
                  return Builder(builder: (context) {
                    return AlertDialog(
                      backgroundColor: Colors.transparent,
                      insetPadding: EdgeInsets.all(h / 200),
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context, true);
                              },
                              child: Container(
                                color: Colors.transparent,
                                width: w / 1.2,
                                height: h / 1.2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: w / 1.2,
                                          height: h / 2.6,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10.r),
                                              topRight: Radius.circular(10.r),
                                              bottomLeft: Radius.circular(10.r),
                                              bottomRight: Radius.circular(10.r),
                                            ),
                                            color: Colors.white,
                                          ),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: w / 1.3,
                                                height: h / 2.4,
                                                padding: EdgeInsets.only(
                                                    left: h / 30, top: h / 50),
                                                child: Hero(
                                                  tag: "QRImage",
                                                  child: QrImage(
                                                    foregroundColor:
                                                        Colors.black,
                                                    data: state.ProfileDate!
                                                        .user!.serial
                                                        .toString(),
                                                    version: QrVersions.auto,
                                                    size: 200.w,
                                                    gapless: false,
                                                    // embeddedImage: AssetImage('Assets/images/bubbly design neu legacy-35.png',),
                                                    // embeddedImageStyle: QrEmbeddedImageStyle(
                                                    //   size: Size(h/20, h/20),
                                                    //   ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )),
                        ],
                      ),
                    );
                  });
                });
          }

          return GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: SafeArea(
              child: Stack(children: [
                SafeArea(
                  child:Column(
                        children: [
                          Container(
                            width: w/1.1,
                            margin: EdgeInsets.only(top: h / 50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    child: IconButton(
                                      icon: SvgPicture.asset(
                                          "Assets/images/Frame 11.svg",
                                          width: 30.w,
                                          color: ColorS.surface),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    )),
                                Container(
                                  child: Text(
                                    'Find Friends',
                                    textAlign: TextAlign.center,
                                    style: _TextTheme.headlineLarge!.copyWith(
                                        fontWeight: FontWeight.w600,
                                      fontSize:  20.sp,
                                    ),
                                  ),
                                ),
                             Container(
                                      child:  IconButton(
                                        icon: SvgPicture.asset(
                                            "Assets/images/Frame(22).svg",
                                            color: ColorS.surface),
                                        onPressed: ()async {
                                          var result = await
                                          Navigator
                                              .push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                      QR_Scanner( ),
                                            ),
                                          ).then((value)async {
                                            if (value == "Yep!") {
                                              Future.delayed(Duration.zero, () {
                                                CommingSoonPopup(context, h, w,"User was added successfully", "Ok", 24);
                                              });
                                            }
                                          }
                                            );
                                        },
                                      )
                                ),
                              ],
                            ),
                          ),
                           SizedBox(
                            height: h/25,
                          ),
                          state.success == true
                              ? Container(
                                  width: w,
                                  height: h / 4,
                                  child: Column(
                                    children: [
                                    Container(
                                    width: w/3.3,
                                    decoration:
                                    BoxDecoration(
                                        color: Colors.white60,
                                        borderRadius:
                                        BorderRadius.only(
                                          topLeft:
                                          Radius.circular(h/100),
                                          topRight:
                                          Radius.circular(h/100),
                                          bottomLeft:
                                          Radius.circular(h/100),
                                          bottomRight:
                                          Radius.circular(h/100),

                                        )
                                    ),
                                    child :
                                    // AspectRatio(
                                    // aspectRatio: 50/10, //aspect ratio for Image
                                    // child:
                                        AspectRatio(
                                    aspectRatio: 10/10, //aspect ratio for Image
                                    child:
                              InkWell(
                                            onTap: () {
                                              alreatDialogBuilder(
                                                  context, h, w, state);
                                            },
                                            child: Center(
                                            child: Hero(
                                                tag: "QRImage",
                                                child: QrImage(
                                                  foregroundColor:
                                                  Colors.black,
                                                  data: state.ProfileDate!
                                                      .user!.serial
                                                      .toString(),
                                                  version: QrVersions.auto,
                                                  size: 200.w,
                                                  gapless: true,
                                                  // embeddedImage: AssetImage('Assets/images/bubbly design neu legacy-35.png',),
                                                  // embeddedImageStyle: QrEmbeddedImageStyle(
                                                  //   size: Size(h/20, h/20),
                                                  //   ),
                                                ),
                                              ),
                                          ),
                                        ),
                               //       ),
                                    ),
                                    ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: h / 100, bottom: h / 50),
                                        //   color: Colors.blue,
                                        width: w,
                                        height: h / 22,

                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                                state.ProfileDate!.user!.serial
                                                    .toString(),
                                                textAlign: TextAlign.left,
                                                style: _TextTheme.headlineLarge!
                                                    .copyWith(
                                                  fontSize:  14.sp,
                                                  fontWeight: FontWeight.w300,
                                                )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : state.isLoading == true
                                  ? Container(
                                      width: w,
                                      height: h / 4,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Center(
                                              child:
                                                  listLoader(context: context)),
                                        ],
                                      ))
                                  : Container(
                                      width: w,
                                      height: h / 4,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: Container(
                                              width: w,
                                              height: h / 10,
                                              child: const Text(""),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                          Expanded(
                            child: Container(
                                width: w,
                                height: h / 1.5849,
                                child: ScrollConfiguration(
                                  behavior: MyBehavior(),
                                  child: SingleChildScrollView(

                                      controller: _controller,
                                      physics: BouncingScrollPhysics(
                                          parent:
                                              AlwaysScrollableScrollPhysics()),
                                      child: Column(
                                        children: [
                                           SizedBox(
                                            height: 10.h,
                                          ),

                                          Showcase(
                                            key: _key1,
                                            description:
                                                'Ask a friend for their unique code, or type in their username',
                                            showArrow: true,
                                            overlayPadding:
                                                 EdgeInsets.only(bottom: 4.h),
                                            showcaseBackgroundColor:
                                                Colors.transparent,
                                            textColor: Colors.white,
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: w / 1.27,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                          '  Share My Friend Code',
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: _TextTheme
                                                              .headlineLarge!
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                              fontSize:  14.sp,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic)),
                                                      const Text(""),
                                                      const Text(""),
                                                    ],
                                                  ),
                                                ),
                                                 SizedBox(
                                                  height: 5.h,
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    await Clipboard.setData(
                                                        ClipboardData(
                                                            text: state
                                                                .ProfileDate!
                                                                .user!
                                                                .serial
                                                                .toString()));
                                                    FindBLOC.add(
                                                        OpenCopyMessage());
                                                  },
                                                  child: Container(
                                                    width: w / 1.3,
                                                    height: h / 13.8,
                                                    decoration:
                                                         BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                            topLeft: Radius.circular( h/90.5),
                                                            topRight:Radius.circular( h/90.5),
                                                            bottomLeft: Radius.circular( h/90.5),
                                                            bottomRight:Radius.circular( h/90.5),
                                                      ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Color.fromRGBO(
                                                                0, 0, 0, 0.25),
                                                            offset: Offset(0, 0),
                                                            blurRadius: 9)
                                                      ],
                                                      color: Color.fromRGBO(
                                                          207, 109, 56, 1),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        'Copy Code',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            _TextTheme.headline1!.copyWith(
                                                              fontWeight:
                                                              FontWeight.w600,
                                                           fontSize:  16.sp,
                                                              letterSpacing: 0.5
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                           SizedBox(
                                            height: 10.h,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              state.success!
                                                  ? await FlutterEmailSender.send(
                                                      email!)
                                                  : print("Success");
                                            },
                                            child: Container(
                                              width: w / 1.3,
                                              height: h / 13.8,
                                              decoration:  BoxDecoration(
                                                  borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular( h/90.5),
                                                    topRight:Radius.circular( h/90.5),
                                                    bottomLeft: Radius.circular( h/90.5),
                                                    bottomRight:Radius.circular( h/90.5),
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 0.25),
                                                        offset: Offset(0, 0),
                                                        blurRadius: 9)
                                                  ],
                                                  color: Color(0xff606060)),
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        width: w / 7,
                                                        child: SvgPicture.asset(
                                                          "Assets/images/Group 91.svg",
                                                          width: w / 20,
                                                        )),
                                                    Container(
                                                      width: w / 4,
                                                      child: Text(
                                                        'Via Email',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                        _TextTheme.headline1!.copyWith(
                                                          fontWeight:
                                                          FontWeight.w600,
                                                          fontSize:  16.sp,
                                                            letterSpacing: 0.5
                                                        ),
                                                      ),
                                                    ),
                                                    Text(""),
                                                    Text(""),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                           SizedBox(
                                            height: 10.h,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              String Message =
                                                  "Hey! 👋  Wondering what's happening around you right now? Download the app and get into the bubble!  https://bit.ly/bubbles.app You can find me with username ${state.ProfileDate!.user!.serial.toString()} Spread the news! Early sign up rewards available now.";
                                              state.success!
                                                  ? _onShareWithResult(
                                                      context, Message.toString())
                                                  : print("Clicked");
                                            },
                                            child: Container(
                                              width: w / 1.3,
                                              height: h / 13.8,
                                              decoration:  BoxDecoration(
                                                  borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular( h/90.5),
                                                    topRight:Radius.circular( h/90.5),
                                                    bottomLeft: Radius.circular( h/90.5),
                                                    bottomRight:Radius.circular( h/90.5),
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 0.25),
                                                        offset: Offset(0, 0),
                                                        blurRadius: 9)
                                                  ],
                                                  color: Color(0xff606060)),
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: w / 7,
                                                      child: Icon(
                                                        Icons.more_horiz,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Container(
                                                      width: w / 4,
                                                      child: Text(
                                                        'More',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                        _TextTheme.headline1!.copyWith(
                                                          fontWeight:
                                                          FontWeight.w600,
                                                          fontSize:  16.sp,
                                                          letterSpacing: 0.5,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(""),
                                                    Text(""),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                           SizedBox(
                                            height: 17.h,
                                          ),

                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Row(
                                                children: [
                                                  Text('Add a friend ',
                                                      textAlign: TextAlign.left,
                                                      style: _TextTheme
                                                          .headlineLarge!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight.w300,
                                                          fontSize:  14.sp,
                                                              fontStyle: FontStyle
                                                                  .italic)),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          _controller.animateTo(
                                                            _controller.position
                                                                .minScrollExtent,
                                                            duration: Duration(
                                                                milliseconds: 2),
                                                            curve: Curves.easeIn,
                                                          );
                                                          WidgetsBinding.instance
                                                              .addPostFrameCallback(
                                                            (_) => ShowCaseWidget
                                                                    .of(context)
                                                                .startShowCase(
                                                              [
                                                                _key1,
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                        child: Container(
                                                          width: w / 20,
                                                          height: h / 50,
                                                          child: SvgPicture.asset(
                                                              "Assets/images/Vector22.svg",
                                                              width: 10.w,
                                                              color: ColorS
                                                                  .onTertiary),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const Text(""),
                                              const Text(""),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Container(
                                              width: w / 1.3,
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                      color:
                                                          ColorS.primaryVariant,
                                                      offset: const Offset(0, 0),
                                                      blurRadius: 2)
                                                ],
                                              ),
                                              child: Form(
                                                autovalidateMode: AutovalidateMode
                                                    .onUserInteraction,
                                                key: _formkey1,
                                                child: TextFormField(
                                                  keyboardAppearance:
                                                      Brightness.dark,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  controller: _SearchController,
                                                  // inputFormatters: [
                                                  //   FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))
                                                  // ],
                                                  onChanged: (value) {},
                                                  onFieldSubmitted: (value) {
                                                    if (value != null) {
                                                      FindBLOC.add(AddFrined(
                                                          (b) => b
                                                            ..serial =
                                                                _SearchController
                                                                    .text));
                                                      _SearchController.clear();
                                                      diditonce2 = true;
                                                    }
                                                  },
                                                  cursorColor: Colors.black,
                                                  style: TextStyle(
                                                      fontSize:  19.sp,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.black
                                                  ,height: 0.9.h
                                                  ),
                                                  decoration: InputDecoration(
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.white),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                h/200.5)
                                                      ),
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.white),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                h/200.5)
                                                      ),
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 12),
                                                      hintText: "#Friend Code",
                                                      hintStyle: _TextTheme
                                                          .headline6!
                                                          .copyWith(
                                                          fontSize:  22.sp,

                                                              color: Color(
                                                                  0xff606060))),
                                                  keyboardType:
                                                      TextInputType.text,
                                                  // obscureText: SecureInput_pass,
                                                ),
                                              )),
                                          SizedBox(
                                            height: 18.h,
                                          ),

                                          contactsLoaded
                                              ? Column(children: [
                                                  ListView.separated(
                                                    shrinkWrap: true,
                                                    padding: EdgeInsets.zero,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    itemCount: ShownLength1,
                                                    separatorBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return SizedBox(
                                                        height: 10,
                                                      );
                                                    },
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      String Message =
                                                          "Hey! 👋  Wondering what's happening around you right now? Download the app and get into the bubble!  https://bit.ly/bubbles.app You can find me with username ${state.ProfileDate!.user!.serial.toString()} Spread the news! Early sign up rewards available now.";

                                                      List<String> Contactss = [
                                                        contacts[index]
                                                                    .phones!
                                                                    .length >=
                                                                1
                                                            ? contacts[index]
                                                                .phones!
                                                                .elementAt(0)
                                                                .value
                                                                .toString()
                                                            : "",
                                                        ""
                                                      ];

                                                      return InkWell(
                                                        onTap: () {
                                                          print(contacts[index]
                                                              .phones!
                                                              .elementAt(0)
                                                              .value
                                                              .toString());
                                                          _sendSMS(
                                                              Message, Contactss);
                                                        },
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              margin:
                                                                  EdgeInsets.only(
                                                                      right:
                                                                          h / 40,
                                                                      left:
                                                                          h / 40),
                                                              width: w / 1.3,
                                                              height: h / 14,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: ColorS
                                                                    .background,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                      topLeft: Radius.circular( h/90.5),
                                                                      topRight:Radius.circular( h/90.5),
                                                                      bottomLeft: Radius.circular( h/90.5),
                                                                      bottomRight:Radius.circular( h/90.5),
                                                                ),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                      color: ColorS
                                                                          .primaryVariant,
                                                                      offset:
                                                                          Offset(
                                                                              0,
                                                                              0),
                                                                      blurRadius:
                                                                          5)
                                                                ],
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .center,
                                                                        children: [
                                                                          Text(
                                                                              "  "),
                                                                          CircleAvatar(
                                                                            radius:
                                                                                20,
                                                                          ),
                                                                          Text(
                                                                              "    "),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Expanded(
                                                                    flex: 2,
                                                                    child: Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceAround,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(""),
                                                                        Text(
                                                                          contacts[index]
                                                                              .displayName
                                                                              .toString(),
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: TextStyle(
                                                                              color: ColorS
                                                                                  .inverseSurface,
                                                                              fontFamily:
                                                                                  'Sofia Pro',
                                                                              fontSize:  20.sp,
                                                                              letterSpacing:
                                                                                  1,
                                                                              fontWeight:
                                                                              FontWeight.w600,
                                                                              height: 1),
                                                                        ),
                                                                        Text(
                                                                          "",
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Container(
                                                                        width: w / 10,
                                                                        height: h / 20,
                                                                        child: Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Text(
                                                                                "   "),
                                                                            SvgPicture.asset(
                                                                                "Assets/images/Frame(1).svg",
                                                                                width: w / 7,
                                                                                height: h / 30,
                                                                                color: ColorS.onBackground),
                                                                          ],
                                                                        )),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  ShownLength1 != contacts.length
                                                      ? Column(
                                                          children: [
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                print(
                                                                    ShownLength1);
                                                                print(contacts
                                                                    .length);
                                                                if (ShownLength1 !=
                                                                    contacts
                                                                        .length) {
                                                                  if (ShownLength1 <
                                                                      10) {
                                                                    ShownLength1 =
                                                                        contacts
                                                                            .length;
                                                                  } else if (ShownLength1 >
                                                                          10 &&
                                                                      ShownLength1 <
                                                                          50) {
                                                                    ShownLength1 +=
                                                                        (contactsLength /
                                                                                10)
                                                                            .floor();
                                                                  } else if (ShownLength1 >
                                                                          50 &&
                                                                      ShownLength1 <
                                                                          500) {
                                                                    ShownLength1 +=
                                                                        (contactsLength /
                                                                                10)
                                                                            .floor();
                                                                  }
                                                                  setState(() {});
                                                                }
                                                              },
                                                              child: Container(
                                                                height: h / 20,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceAround,
                                                                  children: [
                                                                    Text(""),
                                                                    Text(""),
                                                                    Text(
                                                                      "Show More",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .blue,
                                                                          fontSize:  0.22.sp,
                                                                          fontWeight:
                                                                              FontWeight.w700),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : Text(""),
                                                ])
                                              : Showcase(
                                                  key: _key2,
                                                  description:
                                                      'Friends that have also synced their contacts can be added to your friend list',
                                                  showArrow: true,
                                                  overlayPadding:
                                                      const EdgeInsets.only(
                                                          bottom: 4, top: 4),
                                                  showcaseBackgroundColor:
                                                      Colors.transparent,
                                                  textColor: Colors.white,
                                                  child: Container(
                                                    width: w / 1.27,
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text('  Sync Contacts to find friends! ',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: _TextTheme.headlineLarge!.copyWith(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w300,
                                                                        fontSize:  14.sp,
                                                                        fontStyle:FontStyle.italic,



                                                                    )),
                                                                InkWell(
                                                                  onTap: () {
                                                                    WidgetsBinding
                                                                        .instance
                                                                        .addPostFrameCallback(
                                                                      (_) => ShowCaseWidget.of(
                                                                              context)
                                                                          .startShowCase(
                                                                        [
                                                                          _key2,
                                                                        ],
                                                                      ),
                                                                    );
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    width: w / 20,
                                                                    height:
                                                                        h / 50,
                                                                    child: SvgPicture.asset(
                                                                        "Assets/images/Vector22.svg",
                                                                        width: 10.w,
                                                                        color: ColorS
                                                                            .onTertiary),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const Text(""),
                                                            const Text(""),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            FindBLOC.add(
                                                                OpenContactMessage());
                                                            FindBLOC.add(
                                                                GetContactList());
                                                            diditonce = true;
                                                          },
                                                          child: Container(
                                                            width: w / 1.3,
                                                            height: h / 13.8,
                                                            decoration:
                                                                 BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                    topLeft: Radius.circular( h/90.5),
                                                                    topRight:Radius.circular( h/90.5),
                                                                    bottomLeft: Radius.circular( h/90.5),
                                                                    bottomRight:Radius.circular( h/90.5),
                                                              ),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.25),
                                                                    offset:
                                                                        Offset(
                                                                            0, 0),
                                                                    blurRadius: 9)
                                                              ],
                                                              color: Color(
                                                                  0xffA83063),
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                SvgPicture.asset(
                                                                    "Assets/images/IMAGE.svg"),
                                                                Center(
                                                                  child: Text(
                                                                    'Sync Contacts',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style:
                                                                    _TextTheme.headline1!.copyWith(
                                                                      fontSize:  16.sp,
                                                                      fontWeight: FontWeight.w600,
                                                                      letterSpacing: 0.5
                                                                    ),
                                                                  ),
                                                                ),
                                                                Text("")
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                          SizedBox(
                                            height: 6.h,
                                          ),

                                          // Row(
                                          //   mainAxisAlignment:
                                          //       MainAxisAlignment.spaceAround,
                                          //   children: [
                                          //     Text(
                                          //         '   Invite Friends to bubbles!',
                                          //         textAlign: TextAlign.left,
                                          //         style: _TextTheme.headlineLarge!
                                          //             .copyWith(
                                          //                 fontWeight:
                                          //                     FontWeight.w300,
                                          //                 fontSize: 15,
                                          //                 fontStyle:
                                          //                     FontStyle.italic)),
                                          //     const Text(""),
                                          //     const Text(""),
                                          //   ],
                                          // ),
                                          // SizedBox(
                                          //   height: 5,
                                          // ),
                                          // InkWell(
                                          //   onTap: () {
                                          //     // if (recipents.isNotEmpty) {
                                          //     //   String message =
                                          //     //       "Hey! 👋  Wondering what's happening around you right now? Download the app and get into the bubble!  https://bit.ly/bubbles.app You can find me with username {alias} Spread the news! Early sign up rewards available now.";
                                          //     //   _sendSMS(message, recipents);
                                          //     // } else {
                                          //     //   Future.delayed(Duration.zero, () {
                                          //     //     CommingSoonPopup(
                                          //     //         context, h, w, "Sync Contacts First so you could send them sms",
                                          //     //         "Sounds good!", 18);
                                          //     //     //   // Page2().method(_scaffoldKey.currentContext!, "Friend request is successfully sent",
                                          //     //     //   //     state.AddNewFriend!.msg!, "Back");
                                          //     //   });
                                          //       // Future.delayed(Duration.zero, () {
                                          //       //   Page2().method(
                                          //       //       _scaffoldKey
                                          //       //           .currentContext!,
                                          //       //       "Error",
                                          //       //       "Sync Contacts First so you could send them sms",
                                          //       //       "Back");
                                          //       // });
                                          //    // }
                                          //   },
                                          //   child: Container(
                                          //     width: w / 1.3,
                                          //     height: h / 13.8,
                                          //     decoration: const BoxDecoration(
                                          //       borderRadius: BorderRadius.only(
                                          //         topLeft: Radius.circular(5),
                                          //         topRight: Radius.circular(5),
                                          //         bottomLeft: Radius.circular(5),
                                          //         bottomRight: Radius.circular(5),
                                          //       ),
                                          //       boxShadow: [
                                          //         BoxShadow(
                                          //             color: Color.fromRGBO(
                                          //                 0, 0, 0, 0.25),
                                          //             offset: Offset(0, 0),
                                          //             blurRadius: 9)
                                          //       ],
                                          //       color: Color.fromRGBO(
                                          //           207, 109, 56, 1),
                                          //     ),
                                          //     child: Row(
                                          //       mainAxisAlignment:
                                          //           MainAxisAlignment.spaceAround,
                                          //       children: [
                                          //         SvgPicture.asset(
                                          //             "Assets/images/Group 92.svg"),
                                          //         Center(
                                          //           child: Text(
                                          //             'Send Invite Link',
                                          //             textAlign: TextAlign.center,
                                          //             style: _TextTheme.headline1,
                                          //           ),
                                          //         ),
                                          //         Text("")
                                          //       ],
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      )),
                                )),
                          ),

                        ],
                      ),
                 
                ),
                state.IsContactLoadedd!
                    ? Positioned(
                        left: h / 7,
                        right: h / 7,
                        top: h / 2,
                        child: Container(
                          width: w / 2.7,
                          height: h / 6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.285714149475098.r),
                              topRight: Radius.circular(8.285714149475098.r),
                              bottomLeft: Radius.circular(8.285714149475098.r),
                              bottomRight: Radius.circular(8.285714149475098.r),
                            ),
                            color: Color.fromRGBO(147, 147, 147, 1),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                listLoader2(context: context),
                                Text(
                                  'Syncing',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color.fromRGBO(234, 234, 234, 1),
                                      fontFamily: 'Sofia Pro',
                                      fontSize:  25.sp,

                                      letterSpacing:
                                          0,
                                      fontWeight: FontWeight.w400,
                                      height: 1),
                                ),
                                SizedBox(
                                  height: 1.h,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    : Text(""),
                state.IsCompletMessage!
                    ? Positioned(
                        left: h / 7,
                        right: h / 7,
                        top: h / 2,
                        child: Container(
                          width: w / 2.7,
                          height: h / 6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.285714149475098.r),
                              topRight: Radius.circular(8.285714149475098.r),
                              bottomLeft: Radius.circular(8.285714149475098.r),
                              bottomRight: Radius.circular(8.285714149475098.r),
                            ),
                            color: Color.fromRGBO(147, 147, 147, 1),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SvgPicture.asset("Assets/images/llol2.svg"),
                                Text(
                                  'Complete',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color.fromRGBO(234, 234, 234, 1),
                                      fontFamily: 'Sofia Pro',
                                      fontSize:  25.sp,
                                      letterSpacing:
                                          0,
                                      fontWeight: FontWeight.w400,
                                      height: 1),
                                ),
                                SizedBox(
                                  height: 1,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    : Text(""),
                state.ISCopyMessage!
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Container(
                              width: w / 2.1,
                              height: h / 6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8.285714149475098.r),
                                  topRight: Radius.circular(8.285714149475098.r),
                                  bottomLeft:
                                      Radius.circular(8.285714149475098.r),
                                  bottomRight:
                                      Radius.circular(8.285714149475098.r),
                                ),
                                color: Color.fromRGBO(147, 147, 147, 1),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    SvgPicture.asset("Assets/images/llol2.svg"),
                                    SizedBox(
                                      height: 1,
                                    ),
                                    Text(
                                      'Copied!',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(234, 234, 234, 1),
                                          fontFamily: 'Sofia Pro',
                                          fontSize:  25.sp,
                                          letterSpacing:
                                              0.7,
                                          fontWeight: FontWeight.w400,
                                          height: 1),
                                    ),
                                    SizedBox(
                                      height: 1,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Text(""),
                state.FreindAddlOADING == true
                    ? Center(child: listLoader(context: context))
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Container(
                              child: const Text(""),
                            ),
                          ),
                        ],
                      ),
              ]),
            ),
          );
        });
  }

  Widget listLoader({context}) {
    return SpinKitThreeBounce(
      color: Colors.blue,
      size: 30.0.w,
    );
  }

  Widget listLoader2({context}) {
    return SpinKitThreeBounce(
      color: Colors.white,
      size: 30.0.w,
    );
  }

  Widget ShowWidget() {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Positioned(
      left: h / 7,
      right: h / 7,
      bottom: h / 3,
      child: Container(
        width: w / 2.7,
        height: h / 6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.285714149475098),
            topRight: Radius.circular(8.285714149475098),
            bottomLeft: Radius.circular(8.285714149475098),
            bottomRight: Radius.circular(8.285714149475098),
          ),
          color: Color.fromRGBO(147, 147, 147, 1),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SvgPicture.asset("Assets/images/llol2.svg"),
              Text(
                'Complete',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(234, 234, 234, 1),
                    fontFamily: 'Sofia Pro',
                    fontSize:  25.sp,
                    letterSpacing:
                        0,
                    fontWeight: FontWeight.w500,
                    height: 1),
              ),
              SizedBox(
                height: 1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
