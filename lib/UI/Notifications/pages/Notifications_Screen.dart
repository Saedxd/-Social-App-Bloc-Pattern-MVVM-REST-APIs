import 'package:bubbles/Injection.dart';
import 'package:bubbles/UI/Notifications/bloc/Notifications_Bloc.dart';
import 'package:bubbles/UI/Notifications/bloc/Notifications_State.dart';
import 'package:bubbles/UI/Notifications/bloc/Notifications_event.dart';
import 'package:bubbles/UI/Profile/Friendlist_Screen/pages/Friendlist_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:bubbles/App/app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/Colors/constants.dart';
import 'package:timeago/timeago.dart' as timeago;
class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late FocusNode FocuseNODE;
  final _NotificationBloc = sl<NotificationsBloc>();

  @override
  void initState() {
    super.initState();
    FocuseNODE = FocusNode();
    _NotificationBloc.add(GetNotifications());


     _NotificationBloc.add(ClearBadge());
    _NotificationBloc.add(GetBadge());
    ISNewNotifications = false;


  }

  Future<void> OnRefresh() async {
    return Future.delayed(const Duration(milliseconds: 2000), () {});
  }
bool diditonce = false;
  @override
  Widget build(BuildContext context) {
    TextTheme _textthem = Theme.of(context).textTheme;
    ColorScheme COLOR = Theme.of(context).colorScheme;
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return BlocBuilder(
        bloc: _NotificationBloc,
        builder: (BuildContext Context, NotificationsState state) {
          // List<String> StringBackGroundColor =[];
          // List<int> intBackGroundColor =[];
          // if (state.success! &&
          // diditonce == true) {
          //   for (int i =0;i<state.Getnotifcations!.notifications!.length;i++){
          //     StringBackGroundColor.add(state.Getnotifcations!.notifications![i].background_color.toString())  ;
          //   }
          //
          //   var myInt = int.parse(value);
          //   BackgroundColor = myInt;
          //   Done = true;
          //   diditonce = false;
          // }
          return Scaffold(
            resizeToAvoidBottomInset: false,
            key: _scaffoldKey,
            body:

              Column(
                    children: [
                      const SizedBox(
                        height: 70,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Notifications',
                            textAlign: TextAlign.left,
                            style: _textthem.headlineLarge!.copyWith(
                                fontWeight: FontWeight.w600, fontSize: 23),
                          ),
                          const Text(""),
                        ],
                      ),

                      const Text(""),
                      (state.success == true)
                          ? state.Getnotifcations!.notifications!.length==0
                              ?       Container(
                        width: w,
                        height: h/1.24,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [


                     Image.asset("Assets/images/Rectangle 257.png"),
                            Text('I’m so sorry..you don’t have any notifications yet', textAlign: TextAlign.center, style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                fontFamily: 'Red Hat Display',
                                fontSize: 17,
                                letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                                fontWeight: FontWeight.w600,
                                height: 1
                            ),),
                            SizedBox(height: h/6,)

                          ],
                        ),
                      )
                               :

                      Container(
                        width: w,
                            height: h/1.24,
                            child:ScrollConfiguration(
                              behavior: MyBehavior(),
                              child:
                              ListView.separated(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                physics: const AlwaysScrollableScrollPhysics(
                                    parent: BouncingScrollPhysics()),
                                scrollDirection: Axis.vertical,
                                itemCount:
                                    state.Getnotifcations!.notifications!.length,
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const SizedBox(height: 7);
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  var BackgroundColor;
                                  try {
                                    String Value = state.Getnotifcations!
                                        .notifications![index].background_color
                                        .toString();
                                    var myInt = int.parse(Value);

                                    BackgroundColor = myInt;
                                  }catch(e){
                                    print(e);
                                  }
                                  DateTime datee = DateTime.parse(state.Getnotifcations!.notifications![index].created_at.toString());
                                  return InkWell(
                                    onTap: () {

                                      if(state.Getnotifcations!.notifications![index].title=="Friend Request")
                                        WidgetsBinding.instance!
                                            .addPostFrameCallback((_) =>     Navigator.push(
                                          context,
                                          MaterialPageRoute(//receiver_id: ,my_ID: ,
                                            builder: (context) => Friendlist(is_WithoutTopBar: true,),),
                                        ));
                                      else if (state .Getnotifcations!.notifications![index] .title=="Accepted Friend")
                                        WidgetsBinding.instance!
                                            .addPostFrameCallback((_) =>     Navigator.push(
                                          context,
                                          MaterialPageRoute(//receiver_id: ,my_ID: ,
                                            builder: (context) => Friendlist(is_WithoutTopBar: true,),),
                                        ));


                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              right: h / 40, left: h / 40),
                                          decoration: BoxDecoration(
                                            color: COLOR.onError,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(5),
                                              bottomRight: Radius.circular(5),
                                              topLeft: Radius.circular(5),
                                              topRight: Radius.circular(5),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: COLOR.primaryVariant,
                                                  offset: Offset(0, 0),
                                                  blurRadius: 5)
                                            ],
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.spaceAround,
                                                  children: [
                                                    Container(
                                                      width: w / 1.3,
                                                      margin: EdgeInsets.only(
                                                          top: h / 50,
                                                          right: h / 50,
                                                          left: h / 20,
                                                          bottom: h / 50),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Flexible(
                                                            child: Text(
                                                              state
                                                                  .Getnotifcations!
                                                                  .notifications![index]
                                                                  .title
                                                                  .toString(),
                                                              style: _textthem
                                                                  .headlineLarge!
                                                                  .copyWith(
                                                                      fontWeight:
                                                                          FontWeight.w600,
                                                                      fontSize: 20),
                                                            ),
                                                          ),
                                                          Hero(
                                                            tag : "Image${index}",
                                                            child:
                                                        Material(
                                                        type: MaterialType.transparency,
                                                        child :
                                                          InkWell(
                                                            onTap: (){
                                                              WidgetsBinding.instance!
                                                                  .addPostFrameCallback((_) =>     Navigator.push(
                                                                context,
                                                                MaterialPageRoute(//receiver_id: ,my_ID: ,
                                                                  builder: (context) => HeroImage(path:  state.Getnotifcations!.notifications![index].avatar.toString(),color: BackgroundColor,id :  index),),
                                                              ));

                                                            },
                                                            child: CachedNetworkImage(
                                                                imageUrl:
                                                              state.Getnotifcations!.notifications![index].avatar.toString(),
                                                                errorWidget: (context, url, error) => Center(child: Text("Error")),
                                                                imageBuilder: (context, imageProvider) => CircleAvatar(
                                                                  radius: 30,
                                                                  backgroundImage: imageProvider,
                                                                  backgroundColor:   Color(BackgroundColor),
                                                                ),
                                                              ),
                                                            ),
                                  )
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                    Container(
                                                      width: w / 1.3,
                                                      margin: EdgeInsets.only(
                                                          top: h / 50,
                                                          right: h / 50,
                                                          left: h / 30,
                                                          bottom: h / 50),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                         Container(
                                                              width: w/1.7,
                                                              child: Text(
                                                                state
                                                                    .Getnotifcations!
                                                                    .notifications![
                                                                        index]
                                                                    .body
                                                                    .toString(),
                                                                overflow: TextOverflow
                                                                    .ellipsis,
                                                                style: _textthem
                                                                    .headlineLarge!
                                                                    .copyWith(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w300,
                                                                        fontSize: 20),
                                                                maxLines: 10,
                                                              ),
                                                            ),
                                                          Flexible(
                                                            child: Text(
                                                              timeago.format(datee),
                                                              overflow: TextOverflow
                                                                  .ellipsis,
                                                              style: _textthem
                                                                  .headlineLarge!
                                                                  .copyWith(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .normal,

                                                                  fontSize: 13),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                    // CircleAvatar(
                                                    //   backgroundImage:
                                                    //       NetworkImage(state
                                                    //           .Getnotifcations!
                                                    //           .notifications![
                                                    //               index]
                                                    //           .avatar
                                                    //           .toString()),
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),)
                          )
                          : state.isLoading == true
                              ? Container(
                                  width: w,
                                  height: h / 3,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                          child: listLoader(context: context)),
                                    ],
                                  ))
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Container(
                                        width: w,
                                        height: h / 10,
                                        child: const Text("Error"),
                                      ),
                                    ),
                                  ],
                                ),
                    ],
                  ),
               );

        });
  }

  Widget listLoader({context}) {
    return const SpinKitThreeBounce(
      color: Colors.blue,
      size: 30.0,
    );
  }
}
class HeroImage extends StatefulWidget {
  HeroImage({Key? key, this.path,this.color,this.id}) : super(key: key);
int? color;
  String? path;
  int? id;


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
    return Scaffold(
      body:  InkWell(
        onTap: (){
          Navigator.pop(context);
        },
        child: Container(
          width: w,
          height: h,
          color: Colors.transparent,
          child: Hero(
            tag: "Image${widget.id}",
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: CachedNetworkImage(
                      imageUrl:
                      widget.path!,
                      errorWidget: (context, url, error) => Center(child: Text("Error")),
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        radius: w/2,
                        backgroundImage: imageProvider,
                        backgroundColor:   Color(widget.color!),
                      ),
                    ),
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
// Container(
//                 width: w/1.1,
//                 height: h/2.5,
//                 child:Image.network(,fit: BoxFit.fill,)
//               ),
