import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:bubbles/UI/Bubbles/InBubble/EventChat/pages/GroupChat_Screen.dart';
import 'package:bubbles/UI/Bubbles/InBubble/FlowChat/bloc/FlowsChat_Bloc.dart';
import 'package:bubbles/UI/Bubbles/InBubble/FlowChat/bloc/FlowsChat_event.dart';
import 'package:bubbles/UI/Bubbles/InBubble/FlowChat/bloc/FlowsChat_state.dart';
import 'package:bubbles/UI/Bubbles/Sprints/DirectChat/pages/SprintChat.dart';
import 'package:bubbles/core/Classes/Classes.dart';
import 'package:bubbles/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:bubbles/App/app.dart';
import 'package:bubbles/Injection.dart';
import 'package:bubbles/UI/DirectMessages/ChatDirect_Screen/pages/ChatUi_screen.dart';
import 'package:bubbles/UI/Home/Home_Screen/pages/HomeScreen.dart';
import 'package:bubbles/UI/NavigatorTopBar_Screen/pages/NavigatorTopBar.dart';
import 'package:bubbles/core/theme/ResponsiveText.dart';
import 'package:bubbles/core/widgets/OwnMessgaeCrad.dart';
import 'package:bubbles/core/widgets/RecordView.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_questions/conditional_questions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:swipe_to/swipe_to.dart';
import 'package:voice_message_package/voice_message_package.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
// ignore: library_prefixes
import 'package:http/http.dart' as http;

class FlowsChat extends StatefulWidget {
  FlowsChat({Key? key,
    this.plan_Title,
    this.MY_ID,required
    this.Plan_Description,
    required this.flow,
    required this.bubble_id,
    this.Message_id
  }) : super(key: key);
  String? plan_Title = "";
  String? Plan_Description = "";
  int? MY_ID;
  int bubble_id;
  int? Message_id;
  FlowData flow;


  @override
  State<FlowsChat> createState() => _FlowsChatState();
}

class _FlowsChatState extends State<FlowsChat>{
  FlowData  flow = FlowData();
  final PanelController PanelControllerr = PanelController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _SendMessageController = TextEditingController();
  final TextEditingController _SearchController = TextEditingController();
  late FocusNode FocuseNODE;
  final ScrollController _controller = ScrollController();
  final _FlowsChat_Bloc = sl<FlowsBloc>();
  final _formkey3 = GlobalKey<FormState>();
  FocusNode _focus = FocusNode();
  Dio dio = Dio();
  late FocusNode FoucesNodeFlowTitle;
  late FocusNode FoucesNodeFlowDescription;

  List<String> records = [];
  String base64Image = "";
  bool DIditonce2 = false;
  bool Diditonces = false;
  bool Diditoncess = false;
  late Directory appDirectory;
  bool SelectedChat = false;
  bool is_base64 = true;
  File? image;
  int idd = 0;
  int index = 0;
  int  Message_id  = 0;
  int HisBackgroundColor = 0;
  int MYbackGroundColor = 0;
  String MyAlias = "";
  String HisAlias = "";
  String MyAvatar = "";
  String HisAvatar = "";
  Timer? timer;
  String? base64String;
  Uint8List? Image1;
  Uint8List? Image122;
  File? filee;
  String? path;
  String? type;

  Future<String> _createFileFromString(String Base64) async {
    final encodedStr = Base64;
    Uint8List bytes = base64.decode(encodedStr);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File(
        "$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".aac");
    await file.writeAsBytes(bytes);
    return file.path;
  }

  void ListenForWhoJoinedBUbble() async {
    socket!.on("join_message_bubble", (msg) {
      print("Listenting");
      print(msg);
      print(msg["username"]);
      if (MyAlias ==msg["username"]){
        print("set to true");
      }
    });
  }

  void ListenForWhoLeftBUbble() async {
    socket!.on("leave_message_bubble", (msg) {
      print("Listenting");
      print(msg);
      print(msg["username"]);
      print(msg["username"].toString().substring(17));

      if (MyAlias==msg["username"].toString().substring(17)){

      }
    });
  }




  @override
  void initState() {
    super.initState();

    print("widget.Message_id ${widget.flow.FlowMessage_id}");

  ListenForWhoJoinedBUbble();
  ListenForWhoLeftBUbble();
    sendIJoinedFlowMessage(widget.bubble_id,widget.flow.FlowMessage_id!);
  DIditonce2 = false;
  Diditonces = true;
  Diditoncess = true;
    _focus = FocusNode();
    FocuseNODE = FocusNode();
    FoucesNodeFlowDescription = FocusNode();
    FoucesNodeFlowTitle = FocusNode();

  // ListenForWhoJoinedBUbble();
  // ListenForWhoLeftBUbble();
  _FlowsChat_Bloc.add(GetOldMessages((b) =>
  b
    ..message_id = widget.flow.FlowMessage_id
  ));

    _FlowsChat_Bloc.add(GetAlias((b) => b..My_ID = widget.MY_ID));

    _controller.addListener(() {
      if (_controller.position.atEdge){
        _FlowsChat_Bloc.add(ShowFloatingActionButton((b) =>
        b..status = false
        ));

      }else {
        _FlowsChat_Bloc.add(ShowFloatingActionButton((b) =>
        b..status = true
        ));
      }



    });

    _SendMessageController.addListener(() {
      _FlowsChat_Bloc.add(SendStatus((b) => b
        ..Status =
            _SendMessageController.text.isNotEmpty)); //prevent empty messages
      if (_SendMessageController.text.isNotEmpty) {
        _FlowsChat_Bloc.add(
            KetbaordStatus((b) => b..status = true)); //toggle ui view
      } else {
        _FlowsChat_Bloc.add(KetbaordStatus((b) => b..status = false));
      }
    });


  }


  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _SendMessageController.dispose();
    _SearchController.dispose();
    FocuseNODE.dispose();
    _focus.dispose();
    sendILeftFlowMessage(widget.bubble_id,widget.flow.FlowMessage_id!);
  }


  @override
  Widget build(BuildContext context) {
    TextTheme _TextTheme = Theme.of(context).textTheme;
    TextTheme _textthem = Theme.of(context).textTheme;
    ColorScheme ColorS = Theme.of(context).colorScheme;
    ColorScheme COLOR = Theme.of(context).colorScheme;
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return BlocBuilder(
        bloc: _FlowsChat_Bloc,
        builder: (BuildContext Context, FlowsChatState state) {

          alreatDialogBuilder2(
              BuildContext Context,
              double h,
              double w,
              int Frined_id,
              int index,
              ) async {
            return showDialog(
                context: Context,
                   barrierDismissible: true,
                builder: (Context) {
                  return AlertDialog(
                    backgroundColor: Colors.transparent,
                    insetPadding: EdgeInsets.all(h/50),
                    content:
                    Container(
                      width: w/1.1,
                      height: h/4.2,
                      decoration: BoxDecoration(
                        borderRadius : BorderRadius.only(
                          topLeft: Radius.circular(8.285714149475098.r),
                          topRight:  Radius.circular(8.285714149475098.r),
                          bottomLeft:  Radius.circular(8.285714149475098.r),
                          bottomRight:  Radius.circular(8.285714149475098.r),
                        ),
                        color : Color.fromRGBO(47, 47, 47, 1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: h/50,top: h/50),
                            child: Text('Are you sure you want to remove this user from your friendlist?',
                              textAlign: TextAlign.left, style: TextStyle(
                                  color: Color.fromRGBO(234, 234, 234, 1),
                                  fontFamily: 'Sofia Pro',
                                  fontSize: 20.sp,
                                  letterSpacing: 0.5 ,
                                  fontWeight: FontWeight.normal,
                                  height: 1
                              ),),
                          ),
                          Text(""),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [

                              InkWell(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: Container(
                                    width: w/3,
                                    height: h/15,
                                    decoration: BoxDecoration(
                                      borderRadius : BorderRadius.only(
                                        topLeft: Radius.circular(4.142857074737549.r),
                                        topRight:  Radius.circular(4.142857074737549.r),
                                        bottomLeft:  Radius.circular(4.142857074737549.r),
                                        bottomRight:  Radius.circular(4.142857074737549.r),
                                      ),
                                      boxShadow : [BoxShadow(
                                          color: Color.fromRGBO(0, 0, 0, 0.25),
                                          offset: Offset(0,0),
                                          blurRadius: 6.628571510314941
                                      )],
                                      color : Color.fromRGBO(207, 109, 56, 1),
                                    ),
                                    child: Center(
                                      child:
                                      Text('No', textAlign: TextAlign.center, style: TextStyle(
                                          color: Color.fromRGBO(234, 234, 234, 1),
                                          fontFamily: 'Sofia Pro',
                                          fontSize: 19.571428298950195.sp,
                                          letterSpacing: 0.5 ,
                                          fontWeight: FontWeight.w500,
                                          height: 1
                                      ),),
                                    )
                                ),
                              ),

                              InkWell(
                                onTap: (){
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  // _GroupChatBloc.add(RemoveFriend((b) => b
                                  //   ..friend_id = Frined_id
                                  //   ..index = index
                                  // ));
                                },
                                child: Container(
                                  width: w/3,
                                  height: h/15,
                                  decoration: BoxDecoration(
                                    borderRadius : BorderRadius.only(
                                      topLeft:  Radius.circular(4.142857074737549.r),
                                      topRight:  Radius.circular(4.142857074737549.r),
                                      bottomLeft:  Radius.circular(4.142857074737549.r),
                                      bottomRight: Radius.circular(4.142857074737549.r),
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
                                    Text('Yes', textAlign: TextAlign.center, style: TextStyle(
                                        color: Color.fromRGBO(234, 234, 234, 1),
                                        fontFamily: 'Sofia Pro',
                                        fontSize: 19.571428298950195.sp,
                                        letterSpacing: 0.5 ,
                                        fontWeight: FontWeight.w500,
                                        height: 1
                                    ),),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
          }


          alreatDialogBuilder3(
              BuildContext Context,
              double h,
              double w,
              bool is_frined,
              bool is_me,
              int frined_id,
              int myINdex,
              FrinedsData UserData
              ) async {
            return showDialog(
                context: Context,
                   barrierDismissible: true,
                builder: (Context) {



                  var myInt = int.parse(UserData.Background_Color.toString());
                  var BackgroundColor= myInt;


                  return AlertDialog(
                      backgroundColor: Colors.transparent,
                      insetPadding: EdgeInsets.all(h/50),
                      content:GestureDetector(
                        onTap: (){
                          Navigator.pop(context,true);
                        },
                        child: Container(
                          color: Colors.transparent,
                          width: w,
                          height: h,
                          child :
                          Stack(
                              children:[

                                Center(
                                  child: Container(
                                    width: w/1.1,
                                    decoration: BoxDecoration(
                                      borderRadius : BorderRadius.only(
                                        topLeft: Radius.circular(8.285714149475098.r),
                                        topRight:Radius.circular(8.285714149475098.r),
                                        bottomLeft: Radius.circular(8.285714149475098.r),
                                        bottomRight: Radius.circular(8.285714149475098.r),
                                      ),
                                      color : Color.fromRGBO(47, 47, 47, 1),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 5.h),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                            children:  [


                                              Container(
                                                margin: EdgeInsets.only(left: h/60),
                                                child: CircleAvatar(
                                                  backgroundImage: NetworkImage(UserData.Avatar.toString()),
                                                  radius:35.w,

                                                  backgroundColor:Color(BackgroundColor),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(left: h/60),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                          UserData.Alias
                                                              .toString(),
                                                          overflow: TextOverflow.ellipsis,
                                                          style: _TextTheme.headline6!.copyWith(
                                                              color: Color(
                                                                  0xffEAEAEA),
                                                              fontWeight:
                                                              FontWeight
                                                                  .w400,
                                                              fontSize:
                                                              20.sp)),
                                                    ),
                                                    Row(
                                                      children: [

                                                        Text(
                                                            UserData.Serial!,
                                                            textAlign: TextAlign.left,
                                                            style: _TextTheme
                                                                .headline6!
                                                                .copyWith(
                                                                color: Color(
                                                                    0xffEAEAEA),
                                                                fontWeight:
                                                                FontWeight
                                                                    .w300,
                                                                fontSize:
                                                                13.sp)),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: h/6,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      //  color: Colors.pink,
                                                      child: IconButton(
                                                        onPressed: (){
                                                          Navigator.pop(context,true);
                                                        },
                                                        icon: Icon(Icons.clear),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                                margin: EdgeInsets.only(left: 20.w),
                                                child:
                                                Text(UserData.boi.toString(), textAlign: TextAlign.left, style: TextStyle(
                                                    color: Color.fromRGBO(255, 255, 255, 1),
                                                    fontFamily: 'Red Hat Text',
                                                    fontSize: 12.sp,
                                                    letterSpacing: 0 ,
                                                    fontWeight: FontWeight.w300,
                                                    height: 1.4166666666666667
                                                ),)
                                            ),
                                          ],
                                        ),
                                        Text(""),
                                        Row(
                                          mainAxisAlignment:
                                          is_me?    MainAxisAlignment.center:
                                          MainAxisAlignment.spaceAround,
                                          children: [
                                            is_me
                                                ?Text("")
                                                :InkWell(
                                              onTap: (){
                                                //DirectChat
                                                WidgetsBinding.instance
                                                    .addPostFrameCallback((_) =>     Navigator.push(
                                                  context,
                                                  MaterialPageRoute(//receiver_id: ,my_ID: ,
                                                    builder: (context) => Sprints(my_ID: id, IS_sprints: false, receiver_id: UserData.ID!,His_Alias:UserData.Alias!,Send_by: "dm",),),   ));
                                              },

                                              child: Container(
                                                  width: w/3,
                                                  height: h/15,
                                                  decoration: BoxDecoration(
                                                    borderRadius : BorderRadius.only(
                                                      topLeft: Radius.circular(4.142857074737549.r),
                                                      topRight: Radius.circular(4.142857074737549.r),
                                                      bottomLeft: Radius.circular(4.142857074737549.r),
                                                      bottomRight: Radius.circular(4.142857074737549.r),
                                                    ),
                                                    boxShadow:[
                                                      BoxShadow(
                                                          color: Color.fromRGBO(0, 0, 0, 0.25),
                                                          offset: Offset(0,0),
                                                          blurRadius: 6.628571510314941
                                                      )
                                                    ],
                                                    color : Color.fromRGBO(207, 109, 56, 1),
                                                  ),
                                                  child: Center(
                                                      child:
                                                      SvgPicture.asset("Assets/images/Vector2.svg",width: w/12,)

                                                  )
                                              ),
                                            ),
                                            is_me
                                                ?Text("")
                                                :
                                            InkWell(
                                              onTap: (){
                                                if (id== UserData.ID!) {
                                                  if (!is_frined) {
                                                    Navigator.pop(context);
                                                    // _GroupChatBloc.add(
                                                    //     AddFrined((b) =>
                                                    //     b
                                                    //       ..serial =UserData
                                                    //           .Serial.toString()
                                                    //       ..index = myINdex
                                                    //     ));
                                                  } else {
                                                    alreatDialogBuilder2(
                                                        context, h, w,
                                                        frined_id, myINdex);
                                                  }
                                                }

                                              },
                                              child: Container(
                                                width: w/3,
                                                height: h/15,
                                                decoration: BoxDecoration(
                                                  borderRadius : BorderRadius.only(
                                                    topLeft: Radius.circular(4.142857074737549.r),
                                                    topRight: Radius.circular(4.142857074737549.r),
                                                    bottomLeft:Radius.circular(4.142857074737549.r),
                                                    bottomRight: Radius.circular(4.142857074737549.r),
                                                  ),
                                                  boxShadow : [BoxShadow(
                                                      color: Color.fromRGBO(0, 0, 0, 0.25),
                                                      offset: Offset(0,0),
                                                      blurRadius: 6.628571510314941
                                                  )],
                                                  color : is_frined?Color(0xff939393):Color.fromRGBO(168, 48, 99, 1),
                                                ),
                                                child: Center(
                                                    child:
                                                    //
                                                    //   SvgPicture.asset(
                                                    // "Assets/images/Add_friend.svg",
                                                    // color: Colors.white,
                                                    // width: h / 26,
                                                    // )

                                                    is_frined
                                                        ? SvgPicture.asset(
                                                      "Assets/images/True_Mark.svg",
                                                      color: Colors.white,
                                                      width: h / 26,
                                                    )
                                                        :SvgPicture.asset("Assets/images/Add_friend.svg",color: Colors.white,width:  w/12,)


                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 7.h,),
                                      ],
                                    ),
                                  ),
                                ),

                              ]
                          ),

                        ),
                      )

                  );
                });
          }

          void ListenForMessages() async {
            socket!.on("receive_dm_message_in_bubble", (msg) {
              print("Listenting");
              print(msg);
              if (msg["user_id"].toString()!=widget.MY_ID.toString()) {
                //image
                if (msg["type"]=="text") {
                  setHisMessage(
                      msg["message"], msg["user_id"], msg["message_id"],
                      msg["avatar"], msg["username"], msg["color"]);
                }


                if(msg["type"]=="image"){
                  SetHisImage(
                      msg["message"], msg["user_id"], msg["message_id"],
                      msg["avatar"], msg["username"], msg["color"]);
                }

                if(msg["type"]=="audio"){
                  SetHisVoiceMessage(
                      msg["message"], msg["user_id"], msg["message_id"],
                      msg["avatar"], msg["username"], msg["color"]);
                }

              }
            });
          }

          void ListenForReplyMessage() async {
            socket!.on("receive_reply_on_nested_messages_in_bubble", (msg) {
              print(msg);
              if (msg["user_id"].toString()!=widget.MY_ID.toString()) {

                if (msg["Hiscolor"].toString().substring(10)=="text"){

                  print("inside text");



                  SetHisReplyMessage(
                    msg["message"],
                    msg["comment"],
                    msg["HisAlias"],
                    msg["Hisavatar"],
                    (msg["Hiscolor"].substring(0,10)),
                    msg["avatar"] ,
                    msg["username"] ,
                    msg["color"],
                    msg["message_id"],
                  );






                }
                else if (
                msg["Hiscolor"].toString().substring(10) == "Backend"
                    ||
                    msg["Hiscolor"].toString().substring(10)=="Uint8List"
                    ||msg["Hiscolor"].toString().substring(10)=="File"
                ) {
                  print(msg["Hiscolor"].toString().substring(10));
                  print("I GOT INNNNNN");


                  SetHisReplyToImage(
                    msg["message"],
                    msg["comment"],
                    msg["HisAlias"],
                    msg["Hisavatar"],
                    msg["Hiscolor"],
                    msg["avatar"] ,
                    msg["username"] ,
                    msg["color"],
                    msg["message_id"],
                  );
                }   else if (msg["Hiscolor"].toString().substring(10)=="ReplyVoice"){

                  print(msg["Hiscolor"].toString().substring(10));
                  print("I GOT INNNNNN ReplyVoice");

                  SetHisReplyToVoice(
                    msg["message"],
                    msg["comment"],
                    msg["HisAlias"],
                    msg["Hisavatar"],
                    msg["Hiscolor"].toString().substring(0,10),
                    msg["avatar"] ,
                    msg["username"] ,
                    msg["color"],
                    msg["message_id"],
                  );
                }
                //
              }
            });
          }


          if (state.AliasISsuccess! && !DIditonce2) {
            ListenForMessages();
            ListenForReplyMessage();

            print("Listeninggggggg");
            MyAlias = state.GetAliasMinee!.friend!.alias.toString();
            MyAvatar = state.GetAliasMinee!.friend!.avatar.toString();
            String Value2 =
            state.GetAliasMinee!.friend!.background_color.toString();
            int myInt2 = int.parse(Value2);
            MYbackGroundColor = myInt2;
            DIditonce2 = true;
          }

          return WillPopScope(
              onWillPop: () async {
                print("hi");
                if (state.KetbaordStatuss == true) {
                  _FlowsChat_Bloc.add(KetbaordStatus((b) => b..status = false));
                  return false;
                }
                return true;
              },
              child: Scaffold(
                key: _scaffoldKey,
                body: SafeArea(
                  child: Stack(
                    children: [
                      Column(
                        children:[

                          SizedBox(
                            height: h / 30,
                          ),
                          state.success!
                              ? Expanded(
                            child:Container(
                              child: ListView.separated(
                                cacheExtent : 500,
                                controller: _controller,
                                shrinkWrap: true,
                                reverse: true,
                                scrollDirection: Axis.vertical,
                                itemCount: state.messages!.length,
                                itemBuilder: (BuildContext context,
                                    int index) {
                                  return SwipeTo(
                                      onRightSwipe: () {
                                        print(AllBubblesStatus);
                                        print(AllBubblesIDS);
                                        bool GetInStatus = false;
                                        for(int j =0;j<AllBubblesIDS!.length;j++){
                                          if (widget.bubble_id==AllBubblesIDS![j]){
                                            if (AllBubblesStatus![j]==1)
                                              GetInStatus = true;
                                          }
                                        }

                                        if ( GetInStatus) {
                                          if (!widget.flow.ISMediaDump!) {
                                            _focus.requestFocus();
                                            SystemChannels.textInput
                                                .invokeMethod(
                                                'TextInput.show');
                                            if (state.messages![index]
                                                .ISreply == false) {
                                              Message_id =  state.messages![index].ID!;



                                              type = state.messages![index]
                                                  .ModelType.toString();

                                              _FlowsChat_Bloc.add(
                                                  ShowReplyWidget((b) =>
                                                  b
                                                    ..Type = state
                                                        .messages![index]
                                                        .ModelType.toString()
                                                    ..Isreply = true
                                                    ..ColorForRepliedTo = state
                                                        .messages![index]
                                                        .background_Color!
                                                        .toString()
                                                    ..RepliedToMessage = state
                                                        .messages![index]
                                                        .message.toString()
                                                    ..AliasForRepliedTo = state
                                                        .messages![index]
                                                        .Alias.toString()
                                                    ..AvatarPathForRepliedTo = state
                                                        .messages![index]
                                                        .Avatar.toString()
                                                    ..Image1 = state
                                                        .messages![index]
                                                        .Image1
                                                    ..File_image = state
                                                        .messages![index]
                                                        .Image2
                                                    ..Image_type = state
                                                        .messages![index]
                                                        .Image_type

                                                  )
                                              );

                                              print(state.messages![index]
                                                  .message.toString());
                                            }


                                            else if (state.messages![index]
                                                .ISreply == true) {
                                              // this is for reply to reply
                                              // idd = state.OldMessages!.messages![index].replies![0].id!;
                                              // _ChatBloc_Bloc.add(ShowReplyWidget((b) =>
                                              // b
                                              //   ..Isreply = true
                                              //   ..ColorForRepliedTo = 0xff4caf50
                                              //   ..RepliedToMessage = messages[index].ReplierMessage.toString()
                                              //   ..AliasForRepliedTo = messages[index].ReplierAlias.toString()
                                              //   ..AvatarPathForRepliedTo =messages[index].ReplierAvatar.toString()
                                              // ));
                                            }
                                          }
                                        }else{
                                          OutsideBubbleAlreat();
                                        }
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(top:index==state.messages!.length-1? h/13:0),
                                        padding: EdgeInsets.only(
                                            left: h / 50),
                                        child:    state.success!
                                            ? state.messages![index].ModelType == "Message"
                                            ? Container(
                                          width:
                                          w / 1.3,
                                          child: Stack(
                                            children: [
                                              Container(
                                                child: Column(
                                                  children: [
                                                    Stack(
                                                        children :[
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  InkWell(
                                                                    onTap: (){
                                                                      //      alreatDialogBuilder(context,h,w,index,state.FilteredInsideBubbleUsers![index].is_frined!,state.FilteredInsideBubbleUsers![index].id==widget.MY_ID,state.FilteredInsideBubbleUsers![index].id!);
                                                                    },
                                                                    child: CircleAvatar(
                                                                      backgroundColor: Color(state
                                                                          .messages![index]
                                                                          .background_Color!),
                                                                      backgroundImage: NetworkImage(state
                                                                          .messages![index]
                                                                          .Avatar
                                                                          .toString()),
                                                                      radius: 20.w,

                                                                    ),
                                                                  ),
                                                                  SizedBox(width: 10,),
                                                                  Container(
                                                                    margin: EdgeInsets.only(bottom: h/50),
                                                                    child: Text(
                                                                      state.messages![index].Alias.toString(),
                                                                      textAlign:
                                                                      TextAlign.left,
                                                                      style:
                                                                      _textthem.headline3!.copyWith(
                                                                        color: COLOR.errorContainer,
                                                                        fontWeight: FontWeight.w400,
                                                                        fontSize: 13.sp,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                      state.messages![index].time!,
                                                                      textAlign: TextAlign.right,
                                                                      style: _textthem.headline2!.copyWith(
                                                                          fontWeight: FontWeight.w300,
                                                                          color:  Color(0xffEAEAEA),
                                                                          fontSize: 9.sp
                                                                      )),
                                                                  SizedBox(width: 10,),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                          Container(
                                                            width: w /  1.4,
                                                            margin: EdgeInsets.only(right: w/100),
                                                            child: Text(
                                                                state.messages![index].message
                                                                    .toString(),
                                                                textAlign:
                                                                TextAlign.left,
                                                                style: GoogleFonts.roboto().copyWith(
                                                                    color: Colors.transparent,
                                                                    fontWeight: FontWeight.w300,
                                                                    fontSize: 11.sp
                                                                )),
                                                          ),
                                                        ]
                                                    ),
                                                    SizedBox(height: 5,),



                                                  ],
                                                ),
                                              ),

                                              Positioned(
                                                bottom: 0,
                                                left: 0,
                                                right: 0,
                                                child: Container(
                                                  width: w /  1.4,
                                                  color: Colors.transparent,
                                                  margin: EdgeInsets.only(bottom: 0,right: 0,top:h/20,left: w/7),
                                                  child:Text(
                                                      state.messages![index].message
                                                          .toString(),
                                                      textAlign:
                                                      TextAlign.left,
                                                      style: GoogleFonts.roboto().copyWith(
                                                          color:  Color(0xffEAEAEA),
                                                          fontWeight: FontWeight.w300,
                                                          fontSize: 11.sp
                                                      )),

                                                  // Text(
                                                  // state.messages![index].message
                                                  //     .toString(),
                                                  // textAlign:
                                                  // TextAlign.left,
                                                  // style: _textthem.headline2!.copyWith(
                                                  //
                                                  //   fontWeight: FontWeight.w300,
                                                  //    fontSize: 0.23.sp
                                                  // )),
                                                ),
                                              ),

                                            ],
                                          ),
                                        )
                                            : state.messages![index].ModelType == "Image"
                                            ? Container(
                                          width:
                                          w / 1.3,
                                          child: Column(
                                            children: [
                                              Stack(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          InkWell(
                                                            onTap: (){
                                                              //      alreatDialogBuilder(context,h,w,index,state.FilteredInsideBubbleUsers![index].is_frined!,state.FilteredInsideBubbleUsers![index].id==widget.MY_ID,state.FilteredInsideBubbleUsers![index].id!);

                                                            },
                                                            child: CircleAvatar(
                                                              backgroundColor: Color(state
                                                                  .messages![index]
                                                                  .background_Color!),
                                                              backgroundImage: NetworkImage(state
                                                                  .messages![index]
                                                                  .Avatar
                                                                  .toString()),
                                                              radius: 20.w,
                                                            ),
                                                          ),
                                                          SizedBox(width: 10,),
                                                          Container(
                                                            margin: EdgeInsets.only(bottom: h/50),
                                                            child: Text(
                                                              state.messages![index].Alias.toString(),
                                                              textAlign:
                                                              TextAlign.left,
                                                              style:
                                                              _textthem.headline3!.copyWith(
                                                                color: COLOR.errorContainer,
                                                                fontWeight: FontWeight.w400,
                                                                fontSize: 13.sp,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                              state.messages![index].time!,
                                                              textAlign: TextAlign.right,
                                                              style: _textthem.headline2!.copyWith(
                                                                  fontWeight: FontWeight.w300,
                                                                  color:  Color(0xffEAEAEA),
                                                                  fontSize: 9.sp
                                                              )),
                                                          SizedBox(width: 10,),
                                                        ],
                                                      )
                                                    ],
                                                  ),


                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  !state.messages![index].MessageSettledWIthID!?
                                                  SpinKitDualRing(
                                                    color: Colors.white,
                                                    size: h/80.0,
                                                  ):Text(""),
                                                  Container(
                                                    margin: EdgeInsets.only(left: h/14),
                                                    child: Row(
                                                      children: [

                                                        state.messages![index].Image_type.toString()=="Uint8List"
                                                            ? Row(
                                                          children: [
                                                            InkWell(
                                                              onTap: (){
                                                                WidgetsBinding.instance
                                                                    .addPostFrameCallback((_) =>     Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(//receiver_id: ,my_ID: ,
                                                                    builder: (context) =>
                                                                        HeroImage( Uint8List2 : state.messages![index].Image1!, Image_Type: 'Uint8List',id: state.messages![index].ID, Message_Time: state.messages![index].time!, Sender_Avatar: state.messages![index].Avatar, Sender_Color: state.messages![index].background_Color, Sender_Alias: state.messages![index].Alias,),),
                                                                ));

                                                              },
                                                              child: Hero(
                                                                  tag: "Image${state.messages![index].ID}",
                                                                  child: Material(
                                                                      type: MaterialType.transparency,
                                                                      child :Container(
                                                                          height: h / 4,
                                                                          child: ClipRRect(
                                                                              child:Image.memory(state.messages![index].Image1!)
                                                                          )))),
                                                            ),
                                                          ],
                                                        )
                                                            : state.messages![index].Image_type.toString()=="Backend"
                                                            ?

                                                        InkWell(
                                                            onTap: (){
                                                              WidgetsBinding.instance
                                                                  .addPostFrameCallback((_) =>     Navigator.push(
                                                                context,
                                                                MaterialPageRoute(//receiver_id: ,my_ID: ,
                                                                  builder: (context) =>
                                                                      HeroImage( path : state.messages![index].message!, Image_Type: 'Backend',id: state.messages![index].ID, Message_Time: state.messages![index].time!, Sender_Avatar: state.messages![index].Avatar, Sender_Color: state.messages![index].background_Color, Sender_Alias: state.messages![index].Alias,),),
                                                              ));

                                                            },
                                                            child: Hero(
                                                              tag: "Image${state.messages![index].ID}",
                                                              child:  Material(
                                                                  type: MaterialType.transparency,
                                                                  child :


                                                                  CachedNetworkImage(
                                                                    imageUrl:state.messages![index].message!,
                                                                    imageBuilder: (context, imageProvider) => Container(
                                                                      height: h / 4,
                                                                      width: w/3,

                                                                      decoration: BoxDecoration(
                                                                        image:DecorationImage(image: imageProvider,
                                                                            fit: BoxFit.fitHeight
                                                                        ),

                                                                      ),

                                                                    ),
                                                                    placeholder: (context, url) => Container(
                                                                        height: h / 4,child: Row(
                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                      children: [
                                                                        CircularProgressIndicator(),
                                                                      ],
                                                                    )),
                                                                    errorWidget: (context, url, error) => Container(
                                                                        height: h / 4,child: Icon(Icons.error)),
                                                                  )),

                                                            )
                                                        )


                                                            :  Row(
                                                          children: [
                                                            InkWell(
                                                                onTap: (){
                                                                  WidgetsBinding.instance
                                                                      .addPostFrameCallback((_) =>     Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(//receiver_id: ,my_ID: ,
                                                                      builder: (context) =>
                                                                          HeroImage( Image : state.messages![index].Image2!, Image_Type: 'File',id: state.messages![index].ID, Message_Time: state.messages![index].time!, Sender_Avatar: state.messages![index].Avatar, Sender_Color: state.messages![index].background_Color, Sender_Alias: state.messages![index].Alias,),),
                                                                  ));

                                                                },
                                                                child: Hero(
                                                                    tag: "Image${state.messages![index].ID}",
                                                                    child: Material(
                                                                        type: MaterialType.transparency,
                                                                        child :Container(
                                                                            height: h / 4,
                                                                            child: ClipRRect(
                                                                                child:Image.file(state.messages![index].Image2!)
                                                                            ))))),
                                                          ],
                                                        )
                                                      ],

                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                            : state.messages![index].ModelType == "Voice"
                                            ? Container(
                                          width:
                                          w / 1.3,
                                          child: Column(
                                            children: [
                                              Stack(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          InkWell(
                                                            onTap: (){
                                                              //      alreatDialogBuilder(context,h,w,index,state.FilteredInsideBubbleUsers![index].is_frined!,state.FilteredInsideBubbleUsers![index].id==widget.MY_ID,state.FilteredInsideBubbleUsers![index].id!);

                                                            },
                                                            child: CircleAvatar(
                                                              backgroundColor: Color(state
                                                                  .messages![index]
                                                                  .background_Color!),
                                                              backgroundImage: NetworkImage(state
                                                                  .messages![index]
                                                                  .Avatar
                                                                  .toString()),
                                                              radius: 20.w,
                                                            ),
                                                          ),
                                                          SizedBox(width: 10,),
                                                          Container(
                                                            margin: EdgeInsets.only(bottom: h/50),
                                                            child: Text(
                                                              state.messages![index].Alias.toString(),
                                                              textAlign:
                                                              TextAlign.left,
                                                              style:
                                                              _textthem.headline3!.copyWith(
                                                                color: COLOR.errorContainer,
                                                                fontWeight: FontWeight.w400,
                                                                fontSize: 13.sp,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                              state.messages![index].time!,
                                                              textAlign: TextAlign.right,
                                                              style: _textthem.headline2!.copyWith(
                                                                  fontWeight: FontWeight.w300,
                                                                  color:  Color(0xffEAEAEA),
                                                                  fontSize: 9.sp
                                                              )),
                                                          SizedBox(width: 10,),
                                                        ],
                                                      )
                                                    ],
                                                  ),

                                                ],
                                              ),
                                              Container(
                                                width: w / 1.2,
                                                margin: EdgeInsets.only(left: h/14),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    VoiceMessage(
                                                      audioSrc: state.messages![index].message.toString(),
                                                      played: false,
                                                      me: false,
                                                    ),
                                                    Text(""),
                                                    Text(""),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                            : state .messages![index].ModelType == "ReplyMessage"
                                            ? Container(
                                            width: w / 1.3,
                                            child: Stack(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Container(
                                                        height: h / 25,
                                                        child:  Row(
                                                          children: [
                                                            Container(
                                                              height: w / 400,
                                                              width: h / 34,
                                                            ),
                                                            Container(
                                                              color:  Color(0xffEAEAEA),
                                                              width: w / 400,
                                                              height: h / 50,
                                                              margin: EdgeInsets.only(top: h/105,bottom: h/105),
                                                            ),
                                                            Container(
                                                              color:  Color(0xffEAEAEA),
                                                              height: w / 400,
                                                              width: h / 34,
                                                              margin: EdgeInsets.only(bottom: h/55),
                                                            ),
                                                            Container(
                                                              width:
                                                              w / 1.6,
                                                              height:
                                                              h / 30,
                                                              child:
                                                              Column(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                children: [

                                                                  Flexible(
                                                                    child:    Row(
                                                                      children: [
                                                                        Container(
                                                                          margin: EdgeInsets.only(bottom: h/150),
                                                                          child: Row(
                                                                            children: [
                                                                              CircleAvatar(
                                                                                radius: 10.w,
                                                                                backgroundImage: NetworkImage(state.messages![index].RepliedTOAvatar.toString()),
                                                                                backgroundColor: Color(state.messages![index].ReplieDtobackground_Color!),
                                                                              ),
                                                                              SizedBox(
                                                                                width: 3,
                                                                              ),
                                                                              Text(
                                                                                state.messages![index].RepliedTOAlias.toString()
                                                                                // state.AliasForRepliedTo.toString()
                                                                                ,
                                                                                textAlign: TextAlign.left,
                                                                                style: TextStyle(
                                                                                    color:  Color.fromRGBO(147, 147, 147, 1),
                                                                                    fontFamily: 'Red Hat Text',
                                                                                    fontSize: 9.sp,letterSpacing: 0
                                                                                    ,
                                                                                    fontWeight: FontWeight.w500, height: 1),
                                                                              ),
                                                                              SizedBox(
                                                                                width: 5,
                                                                              ),

                                                                              Container(
                                                                                width: w / 8,
                                                                                height: h / 79,
                                                                                child: Text(
                                                                                    state.messages![index].RepliedTOMessage.toString()
                                                                                    // state.RepliedToMessage.toString()
                                                                                    ,
                                                                                    textAlign: TextAlign.left,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                    style: GoogleFonts.roboto().copyWith(
                                                                                        color:  Color(0xffEAEAEA),
                                                                                        fontWeight: FontWeight.w300,
                                                                                        fontSize: 7.54.sp
                                                                                    )

                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),

                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              InkWell(
                                                                onTap: (){
                                                                  //      alreatDialogBuilder(context,h,w,index,state.FilteredInsideBubbleUsers![index].is_frined!,state.FilteredInsideBubbleUsers![index].id==widget.MY_ID,state.FilteredInsideBubbleUsers![index].id!);

                                                                },
                                                                child:    CircleAvatar(
                                                                  backgroundColor: Color(state.messages![index].Replier_background_Color!),
                                                                  backgroundImage: NetworkImage(state.messages![index].ReplierAvatar.toString()),
                                                                  radius: 20.w,
                                                                ),
                                                              ),
                                                              SizedBox(width: 10,),
                                                              Container(
                                                                margin: EdgeInsets.only(bottom: h/50),
                                                                child: Text(
                                                                  state.messages![index].ReplierAlias.toString(),
                                                                  textAlign:
                                                                  TextAlign.left,
                                                                  style:
                                                                  _textthem.headline3!.copyWith(
                                                                    color: COLOR.errorContainer,
                                                                    fontWeight: FontWeight.w400,
                                                                    fontSize: 13.sp,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  state.messages![index].Repliertime!,
                                                                  textAlign: TextAlign.right,
                                                                  style: _textthem.headline2!.copyWith(
                                                                      fontWeight: FontWeight.w300,
                                                                      color:  Color(0xffEAEAEA),
                                                                      fontSize: 9.sp
                                                                  )),
                                                              SizedBox(width: 10,),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      Container(
                                                        width: w /  1.4,
                                                        color: Colors.transparent,
                                                        margin: EdgeInsets.only(left: h/50),
                                                        child: Text(
                                                            state.messages![index].ReplierMessage.toString(),
                                                            textAlign:
                                                            TextAlign.left,
                                                            style: GoogleFonts.roboto().copyWith(
                                                                color: Colors.transparent,
                                                                fontWeight: FontWeight.w300,
                                                                fontSize: 11.sp
                                                            )),
                                                      )
                                                    ],
                                                  ),
                                                  Container(
                                                    width: w/1.3,
                                                    color: Colors.transparent,
                                                    margin: EdgeInsets.only(bottom: 0,right: 0,top:h/12,left: w/7),
                                                    child:Text(
                                                        state.messages![index].ReplierMessage.toString(),
                                                        textAlign:
                                                        TextAlign.left,
                                                        style: GoogleFonts.roboto().copyWith(
                                                            color:  Color(0xffEAEAEA),
                                                            fontWeight: FontWeight.w300,
                                                            fontSize: 11.sp
                                                        )),
                                                  ),

                                                ]
                                            )
                                        )
                                            : state .messages![index].ModelType == "ReplyVoice"
                                            ? Container(
                                          //  color: Colors.red,
                                            width: w / 1.3,
                                            child: Stack(
                                              children: [
                                                Column(
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Container(
                                                            height: h / 25,
                                                            child:  Row(
                                                              children: [
                                                                Container(
                                                                  height: w / 400,
                                                                  width: h / 34,
                                                                ),
                                                                Container(
                                                                  color:  Color(0xffEAEAEA),
                                                                  width: w / 400,
                                                                  height: h / 50,
                                                                ),
                                                                Container(
                                                                  color:  Color(0xffEAEAEA),
                                                                  height: w / 400,
                                                                  width: h / 34,
                                                                  margin: EdgeInsets.only(bottom: h/55),
                                                                ),
                                                                Container(
                                                                  width:
                                                                  w / 1.5,
                                                                  height:
                                                                  h / 30,
                                                                  child:
                                                                  Column(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [

                                                                      Flexible(
                                                                        child:    Row(
                                                                          children: [
                                                                            SizedBox(width: w/250,),

                                                                            Container(
                                                                              margin: EdgeInsets.only(bottom: h/150),
                                                                              child: Row(
                                                                                children: [
                                                                                  CircleAvatar(
                                                                                    radius: 10.w,
                                                                                    backgroundImage: NetworkImage(state.messages![index].RepliedTOAvatar.toString()),
                                                                                    backgroundColor: Color(state.messages![index].ReplieDtobackground_Color!),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 3,
                                                                                  ),
                                                                                  Text(
                                                                                    state.messages![index].RepliedTOAlias.toString()
                                                                                    // state.AliasForRepliedTo.toString()
                                                                                    ,
                                                                                    textAlign: TextAlign.left,
                                                                                    style: TextStyle(
                                                                                        color:  Color.fromRGBO(147, 147, 147, 1),
                                                                                        fontFamily: 'Red Hat Text',  fontSize: 9.sp,
                                                                                        letterSpacing: 0 , fontWeight: FontWeight.w500, height: 1),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 5,
                                                                                  ),
                                                                                  Container(
                                                                                      width: w / 5,
                                                                                      height: h / 10,
                                                                                      margin: EdgeInsets.only(top: h/100),
                                                                                      child:
                                                                                      Text('Sticker...', textAlign: TextAlign.left, style: TextStyle(
                                                                                          color: Color.fromRGBO(196, 196, 196, 1),
                                                                                          fontFamily: 'Sofia Pro',
                                                                                          fontSize: 7.539999961853027.sp,
                                                                                          letterSpacing: 0 ,
                                                                                          fontWeight: FontWeight.w400,
                                                                                          height: 1
                                                                                      ),)),
                                                                                ],
                                                                              ),
                                                                            ),

                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  InkWell(
                                                                    onTap: (){
                                                                      //      alreatDialogBuilder(context,h,w,index,state.FilteredInsideBubbleUsers![index].is_frined!,state.FilteredInsideBubbleUsers![index].id==widget.MY_ID,state.FilteredInsideBubbleUsers![index].id!);

                                                                    },
                                                                    child:    CircleAvatar(
                                                                      backgroundColor: Color(state.messages![index].Replier_background_Color!),
                                                                      backgroundImage: NetworkImage(state.messages![index].ReplierAvatar.toString()),
                                                                      radius: 20.w,
                                                                    ),
                                                                  ),
                                                                  SizedBox(width: 5,),
                                                                  Container(
                                                                    margin: EdgeInsets.only(bottom: h/50),
                                                                    child: Text(
                                                                      state.messages![index].ReplierAlias.toString(),
                                                                      textAlign:
                                                                      TextAlign.left,
                                                                      style:
                                                                      _textthem.headline3!.copyWith(
                                                                        color: COLOR.errorContainer,
                                                                        fontWeight: FontWeight.w400,
                                                                        fontSize: 13.sp,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                      state.messages![index].Repliertime!,
                                                                      textAlign: TextAlign.right,
                                                                      style: _textthem.headline2!.copyWith(
                                                                          fontWeight: FontWeight.w300,
                                                                          color:  Color(0xffEAEAEA),
                                                                          fontSize: 9.sp
                                                                      )),
                                                                  SizedBox(width: 10,),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),

                                                      Container(
                                                        width: w /  1.4,
                                                        margin: EdgeInsets.only(left: h/100),
                                                        child: Text(
                                                            state.messages![index].ReplierMessage.toString(),
                                                            textAlign:
                                                            TextAlign.left,
                                                            style: GoogleFonts.roboto().copyWith(
                                                                color: Colors.transparent,
                                                                fontWeight: FontWeight.w300,
                                                                fontSize: 11.sp
                                                            )),
                                                      ),
                                                    ]
                                                ),


                                                Container(
                                                  width: w/1.3,
                                                  color: Colors.transparent,
                                                  margin: EdgeInsets.only(bottom: 0,right: 0,top:h/12,left: w/7.5),
                                                  child: Text(
                                                      state.messages![index].ReplierMessage.toString(),
                                                      textAlign:
                                                      TextAlign.left,
                                                      style: GoogleFonts.roboto().copyWith(
                                                          color:  Color(0xffEAEAEA),
                                                          fontWeight: FontWeight.w300,
                                                          fontSize: 11.sp
                                                      )),
                                                )

                                              ],
                                            )
                                        )
                                            : state .messages![index].ModelType == "ReplyImage"
                                            ? Container(
                                            width: w / 1.3,
                                            child: Stack(
                                              children: [
                                                Column(
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Container(
                                                            height: h / 25,
                                                            child:  Row(
                                                              children: [
                                                                Container(
                                                                  height: w / 400,
                                                                  width: h / 34,
                                                                ),
                                                                Container(
                                                                  color:  Color(0xffEAEAEA),
                                                                  width: w / 400,
                                                                  height: h / 50,
                                                                ),
                                                                Container(
                                                                  color:  Color(0xffEAEAEA),
                                                                  height: w / 400,
                                                                  width: h / 34,
                                                                  margin: EdgeInsets.only(bottom: h/55),
                                                                ),
                                                                Container(
                                                                  width:
                                                                  w / 1.5,
                                                                  height:
                                                                  h / 30,
                                                                  child:
                                                                  Column(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [

                                                                      Flexible(
                                                                        child:    Row(
                                                                          children: [
                                                                            SizedBox(width: w/250,),

                                                                            Container(
                                                                              margin: EdgeInsets.only(bottom: h/150),
                                                                              child: Row(
                                                                                children: [
                                                                                  CircleAvatar(
                                                                                    radius: 10.w,
                                                                                    backgroundImage: NetworkImage(state.messages![index].RepliedTOAvatar.toString()),
                                                                                    backgroundColor: Color(state.messages![index].ReplieDtobackground_Color!),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 3,
                                                                                  ),
                                                                                  Text(
                                                                                    state.messages![index].RepliedTOAlias.toString()
                                                                                    // state.AliasForRepliedTo.toString()
                                                                                    ,
                                                                                    textAlign: TextAlign.left,
                                                                                    style: TextStyle(
                                                                                        color:  Color.fromRGBO(147, 147, 147, 1),
                                                                                        fontFamily: 'Red Hat Text', fontSize: 9.sp,
                                                                                        letterSpacing: 0 , fontWeight: FontWeight.w500, height: 1),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 5,
                                                                                  ),
                                                                                  Container(
                                                                                    width: w / 5,
                                                                                    height: h / 10,
                                                                                    child:

                                                                                    state.messages![index].Image_type.toString()=="Uint8List"
                                                                                        ? InkWell(
                                                                                      onTap: (){

                                                                                      },

                                                                                      child: Container(
                                                                                          height: h / 10,
                                                                                          child:
                                                                                          Image.memory(state.messages![index].Image1!,)
                                                                                      ),
                                                                                    )
                                                                                        : state.messages![index].Image_type.toString()=="Backend"
                                                                                        ?Row(
                                                                                      children: [
                                                                                        InkWell(
                                                                                            onTap: (){

                                                                                            },
                                                                                            child:
                                                                                            Container(
                                                                                                height: h / 10,
                                                                                                child:
                                                                                                Image.network(state.messages![index].RepliedTOMessage!,)


                                                                                            )),
                                                                                      ],
                                                                                    )
                                                                                        :Row(
                                                                                      children: [
                                                                                        InkWell(
                                                                                            onTap: (){

                                                                                            },
                                                                                            child:
                                                                                            Container(
                                                                                                height: h / 10,
                                                                                                child:Image.file(state.messages![index].Image2!,)
                                                                                            )
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),

                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  InkWell(
                                                                    onTap: (){
                                                                      //      alreatDialogBuilder(context,h,w,index,state.FilteredInsideBubbleUsers![index].is_frined!,state.FilteredInsideBubbleUsers![index].id==widget.MY_ID,state.FilteredInsideBubbleUsers![index].id!);

                                                                    },
                                                                    child:    CircleAvatar(
                                                                      backgroundColor: Color(state.messages![index].Replier_background_Color!),
                                                                      backgroundImage: NetworkImage(state.messages![index].ReplierAvatar.toString()),
                                                                      radius: 20.w,
                                                                    ),
                                                                  ),
                                                                  SizedBox(width: 5,),
                                                                  Container(
                                                                    margin: EdgeInsets.only(bottom: h/50),
                                                                    child: Text(
                                                                      state.messages![index].ReplierAlias.toString(),
                                                                      textAlign:
                                                                      TextAlign.left,
                                                                      style:
                                                                      _textthem.headline3!.copyWith(
                                                                          color: COLOR.errorContainer,
                                                                          fontWeight: FontWeight.w400,
                                                                          fontSize: 13.sp
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                      state.messages![index].Repliertime!,
                                                                      textAlign: TextAlign.right,
                                                                      style: _textthem.headline2!.copyWith(
                                                                          fontWeight: FontWeight.w300,
                                                                          color:  Color(0xffEAEAEA),
                                                                          fontSize: 9.sp
                                                                      )),
                                                                  SizedBox(width: 10,),
                                                                ],
                                                              )
                                                            ],
                                                          ),

                                                        ],
                                                      ),
                                                      Container(
                                                        width: w /  1.4,
                                                        margin: EdgeInsets.only(left: h/100),
                                                        child: Text(
                                                            state.messages![index].ReplierMessage.toString(),
                                                            textAlign:
                                                            TextAlign.left,
                                                            style: GoogleFonts.roboto().copyWith(
                                                                color: Colors.transparent,
                                                                fontWeight: FontWeight.w300,
                                                                fontSize: 11.sp
                                                            )),

                                                      ),
                                                    ]
                                                ),
                                                Container(
                                                  width: w/1.3,
                                                  color: Colors.transparent,
                                                  margin: EdgeInsets.only(bottom: 0,right: 0,top:h/12,left: w/7.5),
                                                  child: Text(
                                                      state.messages![index].ReplierMessage.toString(),
                                                      textAlign:
                                                      TextAlign.left,
                                                      style: GoogleFonts.roboto().copyWith(
                                                          color:  Color(0xffEAEAEA),
                                                          fontWeight: FontWeight.w300,
                                                          fontSize: 11.sp
                                                      )),
                                                )

                                              ],
                                            )
                                        )
                                            :  Text("")
                                            :  Text("empty"),
                                      ));
                                },
                                separatorBuilder:
                                    (BuildContext context,
                                    int index) {
                                  return SizedBox(
                                    height: h / 50,
                                  );
                                },
                              ),
                            )
                          )
                              : state.isLoading!
                              ?  Expanded(
                                child: Container(
                            
                                width: w,
                                height: h/1.28,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Center(
                                        child: listLoader(
                                            context: context)),
                                  ],
                                )),
                              )
                              :  Expanded(
                                child: Container(
                                      width: w,
                                      height: h / 3,
                                      child: Text("Error"),
                                    ),
                              ),



                                Container(
                                  height:state.Isreply!?h/7: h / 10,
                                  decoration: BoxDecoration(
                                      boxShadow:  [
                                        BoxShadow(
                                          color: Color.fromRGBO(
                                              0, 0, 0, 0.25),
                                          offset: Offset(0, 0),
                                          blurRadius: 2.0,
                                        )
                                      ],
                                      color: Color(0xff303030)
                                  ),
                                  child:     !widget.flow.ISMediaDump!?

                                  Column(
                                    children: [

                                      state.Isreply!
                                          ? ReplyWidgett(state)
                                          :  Container(),

                                      
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: [

                                            !state.KetbaordStatuss!
                                                ? Row(
                                              children: [
                                                RecorderView(
                                                  onSaved: _onRecordComplete,
                                                  bubble_id: widget.bubble_id,
                                                  Want_test: true,
                                                ),
                                                Container(
                                                  width: w / 10,
                                                  child: IconButton(
                                                      onPressed: (){
                                                bool GetInStatus = false;
                                                for(int j =0;j<AllBubblesIDS!.length;j++){
                                                if (widget.bubble_id==AllBubblesIDS![j]){
                                                if (AllBubblesStatus![j]==1)
                                                GetInStatus = true;
                                                    }
                                                }

                                                if ( GetInStatus) {
                                                  PhotoFlowDialog();
                                                }else{
                                                  OutsideBubbleAlreat();
                                                }
                                                      },
                                                      icon: SvgPicture.asset(
                                                        "Assets/images/cAMERA.svg",
                                                        width: w / 16,
                                                      )),
                                                )
                                              ],
                                            )
                                                :  Text(""),
                                            Container(
                                                padding: EdgeInsets.only(
                                                    left: h / 100,top: h/100,bottom: h/100),
                                                width: state.KetbaordStatuss!
                                                    ? w / 1.25
                                                    : w / 1.8,
                                                height: h / 13.5,
                                                child: Form(
                                                    key: _formkey3,
                                                    child: TextFormField(
                                                      controller: _SendMessageController,
                                                      keyboardAppearance: Brightness.dark,
                                                      textInputAction:
                                                      TextInputAction.done,
                                                      focusNode: _focus,

                                                      style : GoogleFonts.roboto().copyWith(
                                                          color: Colors.brown,
                                                          fontSize: 19.sp,
                                                          fontWeight: FontWeight.w500,
                                                          height: 1.h
                                                      ),
                                                      onChanged: (value) {
                                                        if (_SendMessageController.text.isNotEmpty) {
                                                          _FlowsChat_Bloc.add(
                                                              KetbaordStatus((b) => b..status = true)); //toggle ui view
                                                        } else {
                                                          _FlowsChat_Bloc.add(KetbaordStatus((b) => b..status = false));
                                                        }
                                                      },

                                                      onFieldSubmitted: (value)async {
                                                        String Comment =
                                                            _SendMessageController
                                                                .text;
                                                        bool GetInStatus = false;
                                                        for(int j =0;j<AllBubblesIDS!.length;j++){
                                                          if (widget.bubble_id==AllBubblesIDS![j]){
                                                            if (AllBubblesStatus![j]==1)
                                                              GetInStatus = true;
                                                          }
                                                        }


                                                        if ( GetInStatus) {
                                                          if (state.Status!) {
                                                            if (state.Isreply ==
                                                                true &&
                                                                state.type ==
                                                                    "Message" &&
                                                                _SendMessageController
                                                                    .text
                                                                    .isNotEmpty) {
                                                              _FlowsChat_Bloc
                                                                  .add(
                                                                  ShowReplyWidget((
                                                                      b) => b..Isreply = false));

                                                              String message = state
                                                                  .RepliedToMessage!;

                                                              String ALias = state
                                                                  .AliasForRepliedTo!;
                                                              String Avatar = state
                                                                  .AvatarPathForRepliedTo!;
                                                              String Color = state
                                                                  .ColorForRepliedTo!
                                                                  .toString();

                                                              SetmyReplyMessage(
                                                                  message,
                                                                  Comment,
                                                                  ALias,
                                                                  Avatar, Color,
                                                                  Message_id);
                                                              _SendMessageController
                                                                  .clear();
                                                            } else if (state
                                                                .Isreply ==
                                                                true &&
                                                                state.type ==
                                                                    "Image" &&
                                                                _SendMessageController
                                                                    .text
                                                                    .isNotEmpty) {
                                                              _FlowsChat_Bloc
                                                                  .add(
                                                                  ShowReplyWidget((
                                                                      b) => b..Isreply = false));


                                                              // String path= "";


                                                              if (state
                                                                  .Image_type ==
                                                                  "Backend") {
                                                                path =
                                                                state
                                                                    .RepliedToMessage!;
                                                              } else if (state
                                                                  .Image_type ==
                                                                  "File") {
                                                                filee = state
                                                                    .File_image!;
                                                              } else if (state
                                                                  .Image_type ==
                                                                  "Uint8List") {
                                                                Image122 =
                                                                state.Image1!;
                                                              }


                                                              SetMyReplyToImage(
                                                                  Comment, state
                                                                  .AliasForRepliedTo!,
                                                                  state
                                                                      .AvatarPathForRepliedTo!,
                                                                  state
                                                                      .ColorForRepliedTo!,
                                                                  Message_id,
                                                                  state
                                                                      .Image_type!
                                                              );
                                                            }
                                                            else if (state
                                                                .Isreply ==
                                                                true &&
                                                                state.type ==
                                                                    "Voice" &&
                                                                _SendMessageController
                                                                    .text
                                                                    .isNotEmpty) {
                                                              _FlowsChat_Bloc
                                                                  .add(
                                                                  ShowReplyWidget(
                                                                          (b) =>
                                                                      b ..Isreply =  false));



                                                              SetmyReplyToVoice(
                                                                Comment, state
                                                                  .AliasForRepliedTo!,
                                                                state
                                                                    .AvatarPathForRepliedTo!,
                                                                state  .ColorForRepliedTo!
                                                                ,
                                                                Message_id,
                                                              );
                                                              //     SetMyReplyToImage(state.RepliedToMessage!,Comment,state.type!);


                                                            }
                                                            else
                                                            if (_SendMessageController
                                                                .text
                                                                .isNotEmpty &&
                                                                state.Isreply ==
                                                                    false) {
                                                              setMYMessage(
                                                                  _SendMessageController
                                                                      .text, 1,
                                                                  widget
                                                                      .MY_ID!);

                                                              _controller
                                                                  .animateTo(
                                                                _controller
                                                                    .position
                                                                    .minScrollExtent,
                                                                duration: Duration(
                                                                    microseconds: 2),
                                                                curve: Curves
                                                                    .easeIn,
                                                              );
                                                            }
                                                          }
                                                          _SendMessageController.clear();
                                                        }else{
                                                          OutsideBubbleAlreat();
                                                        }




                                                      },
                                                      cursorColor: Colors.black,
                                                      decoration: InputDecoration(
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                30.r)),
                                                        filled: true,
                                                        fillColor:
                                                         Color(0xffEAEAEA),
                                                        contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 12.w,
                                                            vertical: h / 100),
                                                        hintText: 'Sup?..',
                                                        hintStyle:  TextStyle(
                                                            color: Color.fromRGBO(
                                                                96, 96, 96, 1),
                                                            fontFamily: 'Red Hat Text',
                                                            fontSize: 13.sp,
                                                            letterSpacing:
                                                            0 /*percentages not used in flutter. defaulting to zero*/,
                                                            fontWeight: FontWeight.w300,
                                                            height: 1),
                                                      ),
                                                      keyboardType: TextInputType.text,
                                                    ))),
                                            Row(
                                              children: [
                                                Container(
                                                  width: w / 10,
                                                  height: h / 10,
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          child: IconButton(
                                                            icon:  Icon(
                                                              Icons.send,
                                                              size: 30.w,
                                                            ),
                                                            onPressed: ()async{


                                                              String Comment =
                                                                  _SendMessageController
                                                                      .text;
                                                              bool GetInStatus = false;
                                                              for(int j =0;j<AllBubblesIDS!.length;j++){
                                                              if (widget.bubble_id==AllBubblesIDS![j]){
                                                              if (AllBubblesStatus![j]==1)
                                                              GetInStatus = true;
                                                              }
                                                              }


                                                              if ( GetInStatus) {
                                                                if (state.Status!) {
                                                                  if (state.Isreply ==
                                                                      true &&
                                                                      state.type ==
                                                                          "Message" &&
                                                                      _SendMessageController
                                                                          .text
                                                                          .isNotEmpty) {
                                                                    _FlowsChat_Bloc
                                                                        .add(
                                                                        ShowReplyWidget((
                                                                            b) => b..Isreply = false));

                                                                    String message = state
                                                                        .RepliedToMessage!;

                                                                    String ALias = state
                                                                        .AliasForRepliedTo!;
                                                                    String Avatar = state
                                                                        .AvatarPathForRepliedTo!;
                                                                    String Color = state
                                                                        .ColorForRepliedTo!
                                                                        .toString();

                                                                    SetmyReplyMessage(
                                                                        message,
                                                                        Comment,
                                                                        ALias,
                                                                        Avatar, Color,
                                                                        Message_id);
                                                                    _SendMessageController
                                                                        .clear();
                                                                  } else if (state
                                                                      .Isreply ==
                                                                      true &&
                                                                      state.type ==
                                                                          "Image" &&
                                                                      _SendMessageController
                                                                          .text
                                                                          .isNotEmpty) {
                                                                    _FlowsChat_Bloc
                                                                        .add(
                                                                        ShowReplyWidget((
                                                                            b) => b..Isreply = false));


                                                                    // String path= "";


                                                                    if (state
                                                                        .Image_type ==
                                                                        "Backend") {
                                                                      path =
                                                                      state
                                                                          .RepliedToMessage!;
                                                                    } else if (state
                                                                        .Image_type ==
                                                                        "File") {
                                                                      filee = state
                                                                          .File_image!;
                                                                    } else if (state
                                                                        .Image_type ==
                                                                        "Uint8List") {
                                                                      Image122 =
                                                                      state.Image1!;
                                                                    }


                                                                    SetMyReplyToImage(
                                                                        Comment, state
                                                                        .AliasForRepliedTo!,
                                                                        state
                                                                            .AvatarPathForRepliedTo!,
                                                                        state
                                                                            .ColorForRepliedTo!,
                                                                        Message_id,
                                                                        state
                                                                            .Image_type!
                                                                    );
                                                                  }
                                                                  else if (state
                                                                      .Isreply ==
                                                                      true &&
                                                                      state.type ==
                                                                          "Voice" &&
                                                                      _SendMessageController
                                                                          .text
                                                                          .isNotEmpty) {
                                                                    _FlowsChat_Bloc
                                                                        .add(
                                                                        ShowReplyWidget(
                                                                                (b) =>
                                                                            b ..Isreply =  false));



                                                                    SetmyReplyToVoice(
                                                                        Comment, state
                                                                        .AliasForRepliedTo!,
                                                                        state
                                                                            .AvatarPathForRepliedTo!,
                                                                        state  .ColorForRepliedTo!
                                                                          ,
                                                                        Message_id,
                                                                    );
                                                                    //     SetMyReplyToImage(state.RepliedToMessage!,Comment,state.type!);


                                                                  }
                                                                  else
                                                                  if (_SendMessageController
                                                                      .text
                                                                      .isNotEmpty &&
                                                                      state.Isreply ==
                                                                          false) {
                                                                    setMYMessage(
                                                                        _SendMessageController
                                                                            .text, 1,
                                                                        widget
                                                                            .MY_ID!);

                                                                    _controller
                                                                        .animateTo(
                                                                      _controller
                                                                          .position
                                                                          .minScrollExtent,
                                                                      duration: Duration(
                                                                          microseconds: 2),
                                                                      curve: Curves
                                                                          .easeIn,
                                                                    );
                                                                  }
                                                                }
                                                                _SendMessageController.clear();
                                                              }else{
                                                                OutsideBubbleAlreat();
                                                              }



                                                            },
                                                            color:  Color(widget.flow.Color!),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                 SizedBox(
                                                  width: 10,
                                                )
                                              ],
                                            )

                                          ],
                                        ),
                                      ),
                                    ],
                                  ):
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: w,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: w / 7,
                                              child: IconButton(
                                                  onPressed: (){
                                                    bool GetInStatus = false;
                                                    for(int j =0;j<AllBubblesIDS!.length;j++){
                                                      if (widget.bubble_id==AllBubblesIDS![j]){
                                                        if (AllBubblesStatus![j]==1)
                                                          GetInStatus = true;
                                                      }
                                                    }

                                                    if ( GetInStatus) {
                                                      pickImage(ImageSource.camera);
                                                    }else{
                                                      OutsideBubbleAlreat();
                                                    }
                                                  },
                                                  icon: SvgPicture.asset(
                                                    "Assets/images/cAMERA.svg",
                                                    width: w / 7,
                                                    fit: BoxFit.fill,
                                                  )),
                                            ),
                                            SizedBox(width: 10,),
                                            Container(
                                              child: IconButton(
                                                  onPressed: (){
                                                    pickImage(ImageSource.gallery);
                                                  }, icon:
                                              SvgPicture.asset(
                                                "Assets/images/Gallary.svg",
                                                width: w / 9,
                                                color: Colors.white,
                                              )
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                )

                        ],
                      ),
                      SlidingUpPanel(
                          controller: PanelControllerr,
                          color: ColorS.onPrimaryContainer,
                          maxHeight: h/4,
                          minHeight: h/9.5,
                          slideDirection: SlideDirection.DOWN,
                          onPanelOpened: () {

                          },
                          borderRadius:  BorderRadius.only(
                            bottomLeft: Radius.circular(20.r),
                            bottomRight: Radius.circular(20.r),
                          ),
                          panel: Container(
                              decoration:  BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.r),
                                  topRight: Radius.circular(20.r),
                                  bottomLeft: Radius.circular(20.r),
                                  bottomRight: Radius.circular(20.r),
                                ),
                              ),
                              width: w,
                              height: h * 2,
                              child:Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [


                                Container(
                                width: w/1.2,
                                child:
                                Text(widget.flow.Title!, textAlign: TextAlign.left,
                                  style: GoogleFonts.roboto().copyWith(
                                      color: Color.fromRGBO(234, 234, 234, 1),
                                      fontSize: 16,
                                      letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                                      fontWeight: FontWeight.w600,
                                      height: 1
                                  ),),
                                ),
                                  SizedBox(height: 10,),
                                  widget.flow.Flow_type=="TopicFlow"?
                                  Container(
                                    width: w/1.2,
                                    child: Text(widget.flow.Content!, textAlign: TextAlign.left,
                                      style: GoogleFonts.roboto().copyWith(
                                            color: Color.fromRGBO(234, 234, 234, 1),
                                            fontSize: 14,
                                            letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                                            fontWeight: FontWeight.w300,
                                            height: 1

                                  ))):Text(""),
                                  SizedBox(height: h/18,),
                                  Container(
                                    width: w / 3.9,
                                    height: h / 130,
                                    decoration: BoxDecoration(
                                      borderRadius:  BorderRadius.only(
                                        topLeft: Radius.circular(20.r),
                                        topRight: Radius.circular(20.r),
                                        bottomLeft: Radius.circular(20.r),
                                        bottomRight: Radius.circular(20.r),
                                      ),
                                      color: ColorS.onTertiary,
                                    ),
                                    //
                                  ),
                                  SizedBox(
                                    height: h / 70,
                                  ),
                                ],
                              ))),
                      Container(
                        width: w,
                        height: h / 15,
                        decoration:  BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(0),
                            bottomLeft: Radius.circular(20.r),
                            bottomRight: Radius.circular(20.r),
                          ),
                          color: Color(widget.flow.Color!),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                  width: w / 7,
                                  height: h / 30,
                                  child: Row(
                                    children: [
                                       Text("       "),
                                      SvgPicture.asset(
                                          "Assets/images/Frame 11.svg",
                                          width: 30.w,
                                          color: ColorS.surface),
                                    ],
                                  )),
                            ),
                            Flexible(
                              child: Container(
                                child: Text(
                                  widget.plan_Title!,
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.roboto().copyWith(
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                        fontSize: 18.sp,
                                        letterSpacing: 0.2,
                                        fontWeight: FontWeight.w600,
                                        height: 1.h

                                    )
                                ),
                              ),
                            ),
                            Text("        "),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),

                  floatingActionButton: state.ShowFloatingActionButtonn!?Container(

                      margin: EdgeInsets.only(bottom: h/14),
                      child: FloatingActionButton(onPressed: () {
                        _controller.animateTo(
                          _controller.position
                              .minScrollExtent,
                          duration: Duration(
                              milliseconds: 200),
                          curve: Curves.easeIn,
                        );
                      },
                        backgroundColor:Color(widget.flow.Color!),
                        child: Icon(Icons.keyboard_arrow_down,color: Colors.black,size: h/20,),
                      )

                  ):Text("")
              ));
        });
  }


  Future OutsideBubbleAlreat()async{

    return showDialog(
        barrierColor: Colors.white.withOpacity(0),
      builder: (BuildContext context) {
        var h = MediaQuery.of(context).size.height;
        var w = MediaQuery.of(context).size.width;
        return Container(
          child: AlertDialog(
            backgroundColor: Color(0xffEAEAEA),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            content:  Container(
                width: w,
                height: h/3,
                decoration: BoxDecoration(
                  borderRadius : BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  color : Color.fromRGBO(234, 234, 234, 1),
                ),
              child: Column(
                children: [
                  Stack(
                    children: [
                          Container(
                              width: w/3,
                              child: Image.asset("Assets/images/Ellipse 26.png",fit: BoxFit.fill,)
                          ),
                      Positioned(
                        top: h/35,
                          left: h/35,
                          child: Image.asset("Assets/images/Vector.png")
                      )

                    ],
                  ),
                  SizedBox(height: h/40,),
                  Text('WOOPS!', textAlign: TextAlign.center, style: TextStyle(
                      color: Color.fromRGBO(47, 47, 47, 1),
                      fontFamily: 'Red Hat Display',
                      fontStyle: FontStyle.italic,
                      fontSize: 22,
                      letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.bold,
                      height: 1
                  ),),
                  SizedBox(height: h/40,),
                  Text('Looks like you are not in this bubble! Please move closer to activate additional features.', textAlign: TextAlign.center, style: TextStyle(
                      color: Color.fromRGBO(47, 47, 47, 1),
                      fontFamily: 'Red Hat Text',
                      fontSize: 12,
                      letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.w600,
                      height: 1.25
                  ),)


                ],
              ),
            ),

          )
        );
      }, context: context
        );

      }

  void DecodeImage(String path,String type) {
    String decoded = utf8.decode(base64.decode(path));

    print(decoded);
  }

  void encodeImage(File path,String type) {
    Uint8List bytes = path.readAsBytesSync();
    base64Image = base64Encode(bytes);
    print(base64Image);
    if (type =="me") {
      SetMyImage(path);
    }
  }

  Future<void> EncodeVoice(String path,String type) async {
    var Voicepath =path;
    var dir = await getApplicationDocumentsDirectory();
    final uri = Uri.parse(Voicepath);
    File file = File(uri.path);
    List<int> fileBytes = await file.readAsBytes();
    base64String = base64Encode(fileBytes);

    if (type =="me"){
      print(path);

      SetMyVoiceMessage(Voicepath.toString());

    }
  }

  Future<void> DecodeVoice(String path,String type) async {
    String decoded = utf8.decode(base64.decode(path));
    print(decoded);

  }






  Future<void> pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    final imagePath = File(image.path);
    print(imagePath);
    this.image = imagePath;
    encodeImage(imagePath,"me");
  }




  Widget ReplyWidgett(FlowsChatState state) {
    TextTheme _textthem = Theme.of(context).textTheme;
    ColorScheme COLOR = Theme.of(context).colorScheme;
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Container(
      height: h / 28,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                  height: h / 30,
                  // decoration: BoxDecoration(
                  //     boxShadow : [BoxShadow(
                  //         blurRadius: 0.3
                  //     )],
                  //     color: Color(0xff303030)
                  // ),

                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          color:  Color(0xffEAEAEA),
                          width: w / 400,
                          height: h / 50,
                        ),
                      ])),
              Container(
                width: w / 1.27,
                height: h / 30,
                margin: EdgeInsets.only(bottom: h / 500),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                color:  Color(0xffEAEAEA),
                                height: w / 400,
                                width: h / 34,
                              ),
                              CircleAvatar(
                                radius: 10,
                                backgroundImage: NetworkImage(
                                    state.AvatarPathForRepliedTo.toString()),
                                backgroundColor:
                                Color(int.parse(state.ColorForRepliedTo!)),
                              ),
                               SizedBox(
                                width: 3,
                              ),

                              Text(
                                state.AliasForRepliedTo.toString(),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color:
                                     Color.fromRGBO(147, 147, 147, 1),
                                    fontFamily: 'Red Hat Text',
                                    fontSize: 1.7 *
                                        SizeConfig.blockSizeVertical!
                                            .toDouble(),
                                    letterSpacing:
                                    0 /*percentages not used in flutter. defaulting to zero*/,
                                    fontWeight: FontWeight.w500,
                                    height: 1),
                              ),
                               SizedBox(
                                width: 5,
                              ),



                              state.type=="Image"
                                  ?state.Image_type.toString()=="Uint8List"
                                  ?Container(
                                  width: w/5,
                                  height: h/5,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.r),
                                      topRight: Radius.circular(20.r),
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(0),
                                    ),
                                    boxShadow: [
                                      BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.20000000298023224), offset: Offset(0, 1), blurRadius: 11)
                                    ],
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.only(topRight:Radius.circular(10),topLeft:Radius.circular(10),bottomLeft:Radius.circular(10),bottomRight: Radius.circular(10)   ),
                                      child:Image.memory(state.Image1!)
                                  ))
                                  : state.Image_type.toString()=="Backend"
                                  ?Container(
                                  width: w/5,
                                  height: h/5,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.r),
                                      topRight: Radius.circular(20.r),
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(0),
                                    ),
                                    boxShadow: [
                                      BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.20000000298023224), offset: Offset(0, 1), blurRadius: 11)
                                    ],
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.only(topRight:Radius.circular(10),topLeft:Radius.circular(10),bottomLeft:Radius.circular(10),bottomRight: Radius.circular(10)   ),
                                      child:Image.network(state.RepliedToMessage!)
                                  ))
                                  :Container(
                                  width: w/5,
                                  height: h/5,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.r),
                                      topRight: Radius.circular(20.r),
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(0),
                                    ),
                                    boxShadow: [
                                      BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.20000000298023224), offset: Offset(0, 1), blurRadius: 11)
                                    ],
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.only(topRight:Radius.circular(10),topLeft:Radius.circular(10),bottomLeft:Radius.circular(10),bottomRight: Radius.circular(10)   ),
                                      child:Image.file(state.File_image!)
                                  ))



                                  :  state.type=="Message"
                                  ?  Container(
                                width: w / 8,
                                height: h / 79,
                                child: Text(
                                  state.RepliedToMessage.toString(),
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.roboto().copyWith(
                                    color: Color.fromRGBO(196, 196, 196, 1),
                                    fontSize: 10.539999961853027,
                                    letterSpacing:
                                    0 /*percentages not used in flutter. defaulting to zero*/,
                                    fontWeight: FontWeight.w300,
                                )
                                ),
                              )
                                  : state.type=="Voice"
                                  ?  Container(
                                width: w / 5,
                                height: h / 40,
                                child:    VoiceMessage(
                                  audioSrc: state.RepliedToMessage.toString(),
                                  played: true,
                                  me: false,
                                ),
                              )
                                  : Container()

                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
              width: w / 10,
              height: h / 35,
              child: IconButton(
                onPressed: () {
                  _FlowsChat_Bloc.add(
                      ShowReplyWidget((b) => b..Isreply = false));
                },
                icon:  Icon(
                  Icons.clear,
                  size: 25,
                ),
              ))
        ],
      ),
    );
  }











  _onRecordComplete(String path) async {
    //SetMyVoiceMessage(path);
    bool GetInStatus = false;
    for(int j =0;j<AllBubblesIDS!.length;j++){
      if (widget.bubble_id==AllBubblesIDS![j]){
        if (AllBubblesStatus![j]==1)
          GetInStatus = true;
      }
    }
    if (GetInStatus) {
      await EncodeVoice(path, "me");
    }else{

    }
  }

  Widget listLoader({context}) {
    return  SpinKitThreeBounce(
      color: Colors.blue,
      size: 30.0.w,
    );
  }










  Future<void> PhotoFlowDialog() {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    TextTheme _TextTheme = Theme.of(context).textTheme;
    ColorScheme ColorS = Theme.of(context).colorScheme;
    return showModalBottomSheet<void>(
        isDismissible: true,
        context: context,
        shape:  RoundedRectangleBorder(
          // <-- SEE HERE
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10.0),
          ),
        ),
        builder: (BuildContext context) {
          return Container(
            width: w,
            height: h / 3.4,
            decoration:  BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
              ),
              color: Color.fromRGBO(148, 38, 87, 1),
            ),
            child: Column(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      pickImage(ImageSource.camera);
                    },
                    child: Container(
                      width: w,
                      height: h / 7.5,
                      color: Colors.transparent,
                      child: Center(
                        child: Text(
                          'Open Camera',
                          textAlign: TextAlign.center,
                          style: _TextTheme.headline2!.copyWith(
                              fontWeight: FontWeight.w600, fontSize: 30),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: w,
                  height: 1,
                  color: Colors.white,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      pickImage(ImageSource.gallery);
                    },
                    child: Container(
                      width: w,
                      height: h / 7.5,
                      color: Colors.transparent,
                      child: Center(
                        child: Text(
                          'From Library',
                          textAlign: TextAlign.center,
                          style: _TextTheme.headline2!.copyWith(
                              fontWeight: FontWeight.w600, fontSize: 30),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }




  Future<void> OnRefresh() async {

  }
  void sendIJoinedFlowMessage(int Bubble_id,int Flowmessage_id) {
    print("Sent Status  Join FlowMessage");
    socket!.emit("request_join_message_bubble",
        {
          "room": "bubble_message_${Bubble_id}",
          "bubble_id": Bubble_id,
          "message_id": Flowmessage_id,
        }
        );

    //GivethemMyID();
  }



  void sendILeftFlowMessage(int Bubble_id,int Flowmessage_id) {
    print("Sent Status Left FlowMessage");
    socket!.emit("request_leave_message_bubble",
        {
          "room": "bubble_message_${Bubble_id}",
          "bubble_id": Bubble_id,
          "message_id": Flowmessage_id,
        });
  }



  void SetHisReplyToVoice
      (
      String message,
      String Comment,
      String RepliedTOAlias,
      String repliedToAvatar,
      String RepliedTo_BackGroundColor,
      String replierAvatar,
      String ReplierAlias,
      String ReplierColor,
      int ReplyMessage_id,
      ) {
    var Colore1 = int.parse(RepliedTo_BackGroundColor);
    var Colore2 = int.parse(ReplierColor);
    GroupChatFlowsMessage InstanceMessages = GroupChatFlowsMessage();
    InstanceMessages.ISreply = true;
    InstanceMessages.ModelType = "ReplyVoice";

    InstanceMessages.RepliedTOAlias =RepliedTOAlias;
    InstanceMessages.RepliedTOMessage = message;
    InstanceMessages.RepliedTOAvatar =repliedToAvatar;
    InstanceMessages.MessageSettledWIthID =true;

    InstanceMessages.ReplieDtobackground_Color = Colore1;


    InstanceMessages.ReplierAlias = ReplierAlias;
    InstanceMessages.ReplierMessage = Comment;
    InstanceMessages.ReplierAvatar = replierAvatar;
    InstanceMessages.Replier_background_Color = Colore2;

    InstanceMessages.ID = 0;
    InstanceMessages.Repliertime = DateFormat.jm().format(DateTime.now());

    _FlowsChat_Bloc.add(AddModel((b) => b..message = InstanceMessages));
  }

  void SetmyReplyToVoice(
      String Comment,
      String RepliedTOAlias,
      String repliedToAvatar,
      String RepliedTo_BackGroundColor
      ,int ReplyMessage_id,
      ) {

    var Colore = int.parse(RepliedTo_BackGroundColor);
    GroupChatFlowsMessage InstanceMessages = GroupChatFlowsMessage();
    InstanceMessages.ModelType = "ReplyVoice";
    InstanceMessages.ISreply = true;
    InstanceMessages.RepliedTOAlias =  RepliedTOAlias;
    InstanceMessages.RepliedTOMessage = "Sticker..";
    InstanceMessages.RepliedTOAvatar =repliedToAvatar;
    InstanceMessages.MessageSettledWIthID =false;
    InstanceMessages.ReplieDtobackground_Color =Colore;


    InstanceMessages.ReplierAlias = MyAlias;
    InstanceMessages.ReplierMessage = Comment;
    InstanceMessages.ReplierAvatar = MyAvatar;
    InstanceMessages.Replier_background_Color = MYbackGroundColor;
    //
    // InstanceMessages.ID = ReplyMessage_id;
    InstanceMessages.Repliertime = DateFormat.jm().format(DateTime.now());
    print("model added");
    _FlowsChat_Bloc.add(AddModel((b) => b..message = InstanceMessages));


    _FlowsChat_Bloc.add(
        addReply((b) => b
          ..comment =_SendMessageController .text
          ..message_id = widget.flow.FlowMessage_id
          ..Message = "Sticker..."
          ..Bubble_id = widget.bubble_id
          ..RepliedToColor = RepliedTo_BackGroundColor
          ..RepliedToAvatar = repliedToAvatar
          ..RepliedToAlias = RepliedTOAlias
          ..type = "ReplyVoice"
        ));

  }

  void SetMyVoiceMessage(String Path){

    File filee = File(Path);
    Uint8List bytes = filee.readAsBytesSync();
    base64String = base64Encode(bytes);
    GroupChatFlowsMessage messageModel = GroupChatFlowsMessage(
        time: DateFormat.jm().format(DateTime.now()),
        Avatar: MyAvatar,
        Alias: MyAlias,
        ISreply: false);
    messageModel.ModelType = "Voice";
    messageModel.MessageSettledWIthID =false;
    messageModel.ISNOdeJS = true;
    messageModel.background_Color = MYbackGroundColor;
    messageModel.Type = "sender";
    messageModel.message = Path;

    messageModel.ID = 0;
    _FlowsChat_Bloc.add(AddModel((b) => b..message = messageModel));

    _FlowsChat_Bloc.add(
        SendMessage((b) =>
        b
          ..type = "audio"
          ..message = base64String
          ..bubble_id = widget.bubble_id
          ..main_type = 1
          ..FlowMessage_Id =widget.flow.FlowMessage_id
        ));

  }

  void SetHisVoiceMessage(
      String Path,
      String Sender_id,
      int Message_id,
      String Avatar,
      String Alias,
      String Color,)async {

    String file = await _createFileFromString(Path);
    var Colore = int.parse(Color);
    GroupChatFlowsMessage messageModel = GroupChatFlowsMessage(
        time: DateFormat.jm().format(DateTime.now()),
        Avatar: Avatar,
        Alias: Alias,
        ISreply: false);
    messageModel.MessageSettledWIthID =true;
    messageModel.message = file;
    messageModel.ModelType = "Voice";
    messageModel.ISNOdeJS = true;
    messageModel.background_Color = Colore;
    messageModel.Type = "receiver";

    messageModel.ID = Message_id;
    _FlowsChat_Bloc.add(AddModel((b) => b..message = messageModel));
  }

  void SetMyReplyToImage(
      String Comment,
      String RepliedTOAlias,
      String repliedToAvatar,
      String RepliedTo_BackGroundColor
      ,int ReplyMessage_id,
      String type
      ){

    var Colore = int.parse(RepliedTo_BackGroundColor);


    GroupChatFlowsMessage InstanceMessages = GroupChatFlowsMessage();
    InstanceMessages.MessageSettledWIthID =false;
    InstanceMessages.ModelType = "ReplyImage";
    InstanceMessages.ISreply = true;
    InstanceMessages.RepliedTOAlias = RepliedTOAlias;
    InstanceMessages.Image_type = type;


    if (type=="Uint8List") {
      InstanceMessages.Image1 = Image122;
    }else if (type=="File"){
      InstanceMessages.Image2 = filee ;
    }else if (type=="Backend"){
      InstanceMessages.RepliedTOMessage = path;
    }






    InstanceMessages.RepliedTOAvatar =repliedToAvatar;

    InstanceMessages.ReplieDtobackground_Color =Colore;
    InstanceMessages.ReplyMessage_id =ReplyMessage_id;


    InstanceMessages.ReplierAlias = MyAlias;
    InstanceMessages.ReplierMessage = Comment;
    InstanceMessages.ReplierAvatar = MyAvatar;
    InstanceMessages.Replier_background_Color = MYbackGroundColor;

    InstanceMessages.Repliertime = DateFormat.jm().format(DateTime.now());
    print("model added");
    _FlowsChat_Bloc.add(AddModel((b) => b..message = InstanceMessages));


    print(Image122);

    _FlowsChat_Bloc.add(
        addReply((b) => b
          ..comment =_SendMessageController .text
          ..message_id = ReplyMessage_id
          ..Bubble_id = widget.bubble_id
          ..RepliedToColor = RepliedTo_BackGroundColor
          ..RepliedToAvatar = repliedToAvatar
          ..RepliedToAlias = RepliedTOAlias
          ..type = type
          ..Uint8 =Image122
          ..File_file = filee
          ..Message = path
        ));
  }

  void SetHisReplyToImage(
      String message,
      String Comment,
      String RepliedTOAlias,
      String repliedToAvatar,
      String RepliedTo_BackGroundColor,
      String replierAvatar,
      String ReplierAlias,
      String ReplierColor,
      int ReplyMessage_id,
      ){
    GroupChatFlowsMessage InstanceMessages = GroupChatFlowsMessage();
    InstanceMessages.MessageSettledWIthID =true;
    String type =  (RepliedTo_BackGroundColor.substring(10));


    if (type=="Uint8List") {
      Uint8List?  _bytesImage = Base64Decoder().convert(message);
      InstanceMessages.Image1 = _bytesImage;
    }else if (type=="File"){
      Uint8List?  _bytesImage = Base64Decoder().convert(message);
      InstanceMessages.Image1 = _bytesImage;
    }else if (type=="Backend"){
      InstanceMessages.RepliedTOMessage = message;
    }




    var Colore = int.parse(RepliedTo_BackGroundColor.substring(0,10));
    var Color_ = int.parse(ReplierColor);

    InstanceMessages.ISNOdeJS = true;
    InstanceMessages.IsBackEnd = false;
    InstanceMessages.ISreply = true;
    InstanceMessages.ModelType = "ReplyImage";
    InstanceMessages.is_base64 = false;
    InstanceMessages.Image_type =type!="File"? type:"Uint8List";




    InstanceMessages.RepliedTOAlias = RepliedTOAlias;

    InstanceMessages.RepliedTOAvatar =repliedToAvatar;
    InstanceMessages.ReplieDtobackground_Color =Colore;
    InstanceMessages.ReplierMessage = Comment;
    InstanceMessages.ReplierAlias = ReplierAlias;
    InstanceMessages.ReplierAvatar =replierAvatar;
    InstanceMessages.Replier_background_Color = Color_;

    InstanceMessages.ID = 0;
    InstanceMessages.Repliertime = DateFormat.jm().format(DateTime.now());

    _FlowsChat_Bloc.add(AddModel((b) => b..message = InstanceMessages));
  }

  void SetMyImage(
      File Path,
      ){
    GroupChatFlowsMessage messageModel = GroupChatFlowsMessage(
        time: DateFormat.jm().format(DateTime.now()),
        Avatar: MyAvatar,
        Alias: MyAlias,
        ISreply: false);
    messageModel.MessageSettledWIthID =false;
    messageModel.IsBackEnd = false;
    messageModel.Image_type = "File";
    messageModel.ISNOdeJS = false;
    messageModel.ModelType = "Image";
    messageModel.background_Color = MYbackGroundColor;
    messageModel.Type = "sender";
    messageModel.Image2 = Path;
    messageModel.is_base64 = true;
    messageModel.ID = 0;
    _FlowsChat_Bloc.add(AddModel((b) => b..message = messageModel));


    _FlowsChat_Bloc.add(
        SendMessage((b) =>
        b
          ..type = "image"
          ..message = base64Image
          ..bubble_id = widget.bubble_id
          ..main_type = 1
            ..FlowMessage_Id = widget.flow.FlowMessage_id
        ));
  }


  void SetHisImage(
      String Path,
      String Sender_id,
      int Message_id,
      String Avatar,
      String Alias,
      String Color,
      ){
    var Senderr_id = int.parse(Sender_id);
    var Color_ = int.parse(Color);
    Uint8List?  _bytesImage = Base64Decoder().convert(Path);

    // Image.memory(_bytesImage)
    // print(Path);
    // print(decoded);

    GroupChatFlowsMessage messageModel = GroupChatFlowsMessage(
        time: DateFormat.jm().format(DateTime.now()),
        Avatar: Avatar,
        Alias: Alias,
        ISreply: false);
    messageModel.MessageSettledWIthID =true;
    messageModel.IsBackEnd = false;
    messageModel.Image_type = "Uint8List";
    messageModel.ISNOdeJS = true;
    messageModel.is_base64 = true;
    messageModel.Image1 = _bytesImage;
    messageModel.ModelType = "Image";
    messageModel.background_Color = Color_;
    messageModel.Type = "receiver";
    messageModel.User_ID = Senderr_id;

    messageModel.ID = Message_id;
    _FlowsChat_Bloc.add(AddModel((b) => b..message = messageModel));
  }

  void SetmyReplyMessage(
      String message,
      String Comment,
      String RepliedTOAlias,
      String repliedToAvatar,
      String RepliedTo_BackGroundColor,
      int Message_id) {

    var Colore = int.parse(RepliedTo_BackGroundColor);
    GroupChatFlowsMessage InstanceMessages = GroupChatFlowsMessage();
    InstanceMessages.MessageSettledWIthID =false;
    InstanceMessages.ModelType = "ReplyMessage";
    InstanceMessages.ISreply = true;
    InstanceMessages.is_base64 = false;
    InstanceMessages.IsBackEnd = false;
    InstanceMessages.RepliedTOAlias= RepliedTOAlias;
    InstanceMessages.RepliedTOMessage = message;
    InstanceMessages.RepliedTOAvatar =repliedToAvatar;
    InstanceMessages.ID = Message_id;
    InstanceMessages.ReplieDtobackground_Color =Colore;

    InstanceMessages.ISNOdeJS = true;
    InstanceMessages.ReplierAlias = MyAlias;
    InstanceMessages.ReplierMessage = Comment;
    InstanceMessages.ReplierAvatar = MyAvatar;
    InstanceMessages.Replier_background_Color = MYbackGroundColor;
    InstanceMessages.ReplyMessage_id = 0;

    InstanceMessages.Repliertime = DateFormat.jm().format(DateTime.now());
    print("model added");
    _FlowsChat_Bloc.add(AddModel((b) => b..message = InstanceMessages));




    _FlowsChat_Bloc.add(
        addReply((b) => b
          ..comment =_SendMessageController .text
          ..message_id = Message_id
          ..Bubble_id = widget.bubble_id
          ..RepliedToColor = RepliedTo_BackGroundColor
          ..RepliedToAvatar = repliedToAvatar
          ..RepliedToAlias = RepliedTOAlias
          ..Message = message
          ..type ="text"
        ));


  }

  void SetHisReplyMessage(
      String message,
      String Comment,
      String RepliedTOAlias,
      String repliedToAvatar,
      String RepliedTo_BackGroundColor,
      String replierAvatar,
      String ReplierAlias,
      String ReplierColor
      ,int ReplyMessage_id,
      ){

    var Colore = int.parse(RepliedTo_BackGroundColor);
    var Color_ = int.parse(ReplierColor);
    GroupChatFlowsMessage InstanceMessages = GroupChatFlowsMessage();
    InstanceMessages.MessageSettledWIthID =true;
    InstanceMessages.ISreply = true;
    InstanceMessages.IsBackEnd = false;
    InstanceMessages.is_base64 = false;
    InstanceMessages.ModelType = "ReplyMessage";
    InstanceMessages.ISNOdeJS = true;
    InstanceMessages.RepliedTOAlias =RepliedTOAlias;
    InstanceMessages.RepliedTOMessage = message;
    InstanceMessages.RepliedTOAvatar =repliedToAvatar;
    InstanceMessages.ID = 0;
    InstanceMessages.ReplieDtobackground_Color =Colore;



    InstanceMessages.ReplierAlias = ReplierAlias;
    InstanceMessages.ReplierMessage = Comment;
    InstanceMessages.ReplierAvatar = replierAvatar;
    InstanceMessages.Replier_background_Color = Color_;

    InstanceMessages.ReplyMessage_id = ReplyMessage_id;
    InstanceMessages.Repliertime = DateFormat.jm().format(DateTime.now());

    _FlowsChat_Bloc.add(AddModel((b) => b..message = InstanceMessages));
  }




  void setHisMessage(String message,String Sender_id, int Message_id,String Avatar,String Alias,String Color) {
    try {
      print("setHisMessage");
      var Senderr_id = int.parse(Sender_id);
      var Colore = int.parse(Color);
      GroupChatFlowsMessage messageModel = GroupChatFlowsMessage(
          message: message,
          time: DateFormat.jm().format(DateTime.now()),
          Avatar: Avatar,
          Alias: Alias,
          ISreply: false);
      messageModel.MessageSettledWIthID =true;
      messageModel.ISNOdeJS = true;
      messageModel.is_base64 = false;
      messageModel.IsBackEnd = false;
      messageModel.ModelType = "Message";
      messageModel.background_Color = Colore;
      messageModel.Type = "receiver";
      messageModel.User_ID = Senderr_id;
      messageModel.ID = Message_id;





      _FlowsChat_Bloc.add(AddModel((b) => b..message = messageModel));

    }catch(e){
      print(e);
    }
  }


  void setMYMessage(String message,int Message_id,int User_ID) {
    GroupChatFlowsMessage messageModel = GroupChatFlowsMessage(
        message: message,
        time: DateFormat.jm().format(DateTime.now()),
        Avatar: MyAvatar,
        Alias: MyAlias,
        ISreply: false);
    messageModel.ISNOdeJS = true;
    messageModel.is_base64 = false;
    messageModel.ModelType ="Message" ;
    //"Message"
    messageModel.MessageSettledWIthID =false;
    messageModel.background_Color = MYbackGroundColor;
    messageModel.Type = "sender";
    messageModel.User_ID = User_ID;
    messageModel.ID = Message_id;
    _FlowsChat_Bloc.add(AddModel((b) => b..message = messageModel));

    _FlowsChat_Bloc.add( SendMessage((b) => b
      ..type = "text"
      ..message = _SendMessageController.text
      ..bubble_id = widget.bubble_id
        ..FlowMessage_Id =widget.flow.FlowMessage_id
    ));

    // sendMessage(event.message!,
    //     "text",event.bubble_id!, state.SendBubbleMessage!.message_id!.toInt());
    // sendMessage(_SendMessageController.text,
    //     "text",widget.bubble_id, 1);
  }

}

// class UserDATA{
//   int? id;
//   String? Avatar;
//   String? Alias;
//   String? Background_Color;
//   String? Serial_number;
// String? Serial;
//   String? boi;
//   bool? is_frined;
// }
class HeroImage extends StatefulWidget {
  HeroImage({Key? key, this.path, this.Image,required this.Image_Type, this.Uint8List2,this.id,required this.Sender_Alias,required this.Sender_Avatar,required this.Sender_Color,required this.Message_Time}) : super(key: key);
  File? Image;
  String? path;
  String Image_Type;
  Uint8List? Uint8List2;
  int? id;
  String? Sender_Avatar;
  String? Sender_Alias;
  int? Sender_Color;
  String Message_Time;


  @override
  State<HeroImage> createState() => _HeroImageState();
}

class _HeroImageState extends State<HeroImage> {
  @override
  Widget build(BuildContext context) {
    TextTheme _TextTheme = Theme.of(context).textTheme;
    ColorScheme ColorS = Theme.of(context).colorScheme;
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return  Scaffold(
      body: SafeArea(
        child: Hero(
          tag: "Image${widget.id}",
          child:Material(
            type: MaterialType.transparency,
            child :Container(
              color: Colors.black,
              width: w,
              height: h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(
                              left: w / 50),
                          child: IconButton(
                            icon: SvgPicture.asset(
                                "Assets/images/Frame 11.svg",
                                width: 30.w,
                                color: ColorS.surface),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )),
                      Text(""),
                      Text(""),
                    ],
                  ),

                  widget.Image_Type=="Uint8List"
                      ?Container(
                      width: w,
                      height: h/2,
                      child :
                      PhotoView(
                        imageProvider: MemoryImage(widget.Uint8List2!,),
                      ))
                      :widget.Image_Type=="Backend"
                      ?      Container(
                      width: w,
                      height: h/2,
                      child : PhotoView(
                        imageProvider: NetworkImage(widget.path!),
                      ))

                      : Container(
                      width: w,
                      height: h/2,
                      child :  PhotoView(
                        imageProvider: FileImage(widget.Image!),

                      )),

                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [


                          Row(

                            children: [
                              SizedBox(width: 5,),
                              CircleAvatar(
                                backgroundColor:
                                Color(widget.Sender_Color!),
                                backgroundImage:
                                NetworkImage(widget.Sender_Avatar!),
                                radius: 17,
                              ),
                              SizedBox(width: 5,),
                              Text(
                                widget.Sender_Alias!,
                                textAlign: TextAlign.left,
                                style: _TextTheme.headline3!.copyWith(
                                  color: ColorS.errorContainer,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 3.2 * SizeConfig.blockSizeVertical!.toDouble(),
                                ),
                              ),

                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                  widget.Message_Time,
                                  textAlign: TextAlign.right,
                                  style: _TextTheme.headline2!.copyWith(
                                    fontWeight: FontWeight.w300,
                                    color:  Color(0xffEAEAEA),
                                    fontSize:
                                    1.5 * SizeConfig.blockSizeVertical!.toDouble(),
                                  )),
                              SizedBox(width: 5,),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 10,),
                    ],
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );

  }
}



