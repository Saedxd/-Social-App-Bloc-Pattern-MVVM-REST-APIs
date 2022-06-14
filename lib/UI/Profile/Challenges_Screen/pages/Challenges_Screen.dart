import 'package:bubbles/App/app.dart';
import 'package:bubbles/Injection.dart';
import 'package:bubbles/UI/Profile/Challenges_Screen/bloc/Challenges_Bloc.dart';
import 'package:bubbles/UI/Profile/Challenges_Screen/bloc/Challenges_Event.dart';
import 'package:bubbles/UI/Profile/Challenges_Screen/bloc/Challenges_State.dart';
import 'package:bubbles/core/Colors/constants.dart';
import 'package:bubbles/core/theme/ResponsiveText.dart';
import 'package:bubbles/models/GetChallengesModel/GetChallengesModel.dart';
import 'package:conditional_questions/conditional_questions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Challenges extends StatefulWidget {
  const Challenges({Key? key}) : super(key: key);

  @override
  State<Challenges> createState() => _ChallengesState();
}

class _ChallengesState extends State<Challenges> {
  final _ChallengesBloc = sl<ChallengesBloc>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    _ChallengesBloc.add(GetChallenges());
  }

  Future<void> OnRefresh() async {
    _ChallengesBloc.add(GetChallenges());
    //todo : implemment fixes
    //  to loading
  }

  @override
  Widget build(BuildContext context) {
    TextTheme _textthem = Theme.of(context).textTheme;
    ColorScheme COLOR = Theme.of(context).colorScheme;
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return BlocBuilder(
        bloc: _ChallengesBloc,
        builder: (BuildContext context, ChallengesState state) {
          alreatDialogBuilder(BuildContext Context, double h, double w,
              ChallengesState state, int index) async {
            int NUMBERSWanted = state.GetChallenges!.values![index];

            return showDialog(
                context: Context,
                barrierDismissible: false,
                builder: (Context) {
                  return AlertDialog(
                    backgroundColor:  Color(0xffC4C4C4),
                    insetPadding: EdgeInsets.all(h / 50),

                    title: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CircleAvatar(
                            radius: 45,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                right: h / 40, left: h / 30),
                            child: Text(
                              state.GetChallenges!.challenges![index].title
                                  .toString(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color.fromRGBO(47, 47, 47, 1),
                                  fontFamily: 'Red Hat Display',
                                  fontSize: 3.6 *
                                      SizeConfig.blockSizeVertical!
                                          .toDouble(),
                                  letterSpacing: 0.1,
                                  fontWeight: FontWeight.w600,
                                  height: 1),
                            ),
                          ),
                          Text(""),
                        ],
                      ),
                    ),
                    content:  Container(
                      width: w/1.4,
                      height: h / 6,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.285714149475098),
                            topRight: Radius.circular(8.285714149475098),
                            bottomLeft: Radius.circular(8.285714149475098),
                            bottomRight: Radius.circular(8.285714149475098),
                          ),
                          color: Color(0xffC4C4C4)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Center(
                              child: Container(
                                width: w / 1.3,
                                margin:
                                EdgeInsets.only(bottom: h / 40),
                                child: Text(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Bibendum potenti posuere nec.',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Color.fromRGBO(47, 47, 47, 1),
                                      fontFamily: 'Red Hat Text',
                                      fontSize: 3 * SizeConfig.blockSizeVertical!,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w300,
                                      height: 1.5),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: h / 30),
                            child: Row(
                              children: [
                                Text(
                                  '$NUMBERSWanted/'
                                      '${state.GetChallenges!.challenges![index].max_number.toString()}',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Color.fromRGBO(96, 96, 96, 1),
                                      fontFamily: 'Red Hat Display',
                                      fontSize: 3.5 *
                                          SizeConfig.blockSizeVertical!,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w600,
                                      height: 1),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                SvgPicture.asset(
                                  "Assets/images/BeCoins(1).svg",
                                  width: w / 10,
                                  height: h / 25,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '${state.GetChallenges!.challenges![index].point.toString()} pts',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Color.fromRGBO(168, 48, 99, 1),
                                      fontFamily: 'Red Hat Display',
                                      fontSize:
                                      3 * SizeConfig.blockSizeVertical!,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w600,
                                      height: 1),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                         if (     state.GetChallenges!
                             .challengesStatus![index] ==
                             1) {
                              _ChallengesBloc.add(GetPoints((b) => b
                              ..ChallengeId = state.GetChallenges!
                                  .challenges![index].id!
                                  .toInt()));
                              _ChallengesBloc.add(GetChallenges());
                              }
                         Navigator.pop(context);

                            },
                            child: Container(
                              width: w / 5,
                              height: h / 20,
                              margin: EdgeInsets.only(right: h / 30),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50),
                                  bottomLeft: Radius.circular(50),
                                  bottomRight: Radius.circular(50),
                                ),
                                color:  state.GetChallenges!
                                    .challengesStatus![index] ==
                                    1
                                    ? Color.fromRGBO(207, 109, 56, 1)
                                    : Color(0xff939393),
                              ),
                              child: Center(
                                child: Text(
                                  'Claim',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color:
                                      Color.fromRGBO(234, 234, 234, 1),
                                      fontFamily: 'Red Hat Text',
                                      fontSize: 16,
                                      letterSpacing: 0.2,
                                      fontWeight: FontWeight.w600,
                                      height: 1),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                  //todo : fix the Create an Account textoverflow
                  //todo :remove the Counter if it has no Count like Login Daily and Create an account
                  //todo : ask backend if user managed to get points twice he will get them doubled? or what happenes
                });
          }

          return Scaffold(
            key: _scaffoldKey,
            body: SafeArea(
                child: Column(
              children: [
                const Text(""),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    const Spacer(),
                    Container(
                        margin: EdgeInsets.only(
                            left: h / 100, right: h / 50),
                        child: IconButton(
                          icon: SvgPicture.asset(
                              "Assets/images/Frame 11.svg",
                              width: 30,
                              color: COLOR.surface),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )),
                    const Spacer(),
                    Text(
                      'You can earn more points  by completing challenges!',
                      textAlign: TextAlign.left,
                      style: _textthem.headlineLarge!
                          .copyWith(fontWeight: FontWeight.w300, fontSize: 23),
                    ),
                    const Spacer(),
                    const Spacer(),
                    const Spacer(),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(""),
                state.success!
                    ? RefreshIndicator(
                        onRefresh: OnRefresh,
                        backgroundColor: Colors.white,
                        color: Colors.blue,
                        child: Container(
                            width: w / 1.1,
                            height: h / 1.2,
                            child: ScrollConfiguration(
                              behavior: MyBehavior(),
                              child: ListView.separated(
                                itemCount:
                                    state.GetChallenges!.challenges!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return
                                    Container(
                                      width: w / 1.1,
                                      height: h / 8,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(50),
                                          topRight: Radius.circular(50),
                                          bottomLeft: Radius.circular(50),
                                          bottomRight: Radius.circular(50),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color.fromRGBO(
                                                  0, 0, 0, 0.4000000059604645),
                                              offset: Offset(0, 0),
                                              blurRadius: 5)
                                        ],
                                        color: Color.fromRGBO(196, 196, 196, 1),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                            child: ListTile(
                                              leading: CircleAvatar(
                                                backgroundColor:
                                                    Color(0xff939393),
                                              ),
                                              title: Text(
                                                state.GetChallenges!
                                                    .challenges![index].title
                                                    .toString(),
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        47, 47, 47, 1),
                                                    fontFamily:
                                                        'Red Hat Display',
                                                    fontSize: 20,
                                                    letterSpacing: 0.2,
                                                    fontWeight: FontWeight.w600,
                                                    height: 1),
                                              ),
                                              subtitle: Text(
                                                '${state.GetChallenges!.challenges![index].point.toString()} points',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        96, 96, 96, 1),
                                                    fontFamily:
                                                        'Red Hat Display',
                                                    fontSize: 15,
                                                    letterSpacing: 0,
                                                    fontWeight: FontWeight.w600,
                                                    height: 1),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: w / 5,
                                            height: h / 20,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(50),
                                                topRight: Radius.circular(50),
                                                bottomLeft: Radius.circular(50),
                                                bottomRight:
                                                    Radius.circular(50),
                                              ),
                                              color: Color.fromRGBO(
                                                  207, 109, 56, 1),
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                print(index);
                                                ( index==2 && state.GetChallenges!.challengesStatus![2]==0)?
                                                state.GetChallenges!.challengesStatus![2]==0?
                                              Page2().method(
                                                    _scaffoldKey.currentContext!,
                                                    "Challenges",
                                                    """it hasn't been 24 yet on your last claim we will be wating for you to come claim it !❤""",
                                                    "Back"):
                                                    print("go on")
                                                    :print("nope");



                                                !( index==2 &&  state.GetChallenges!.challengesStatus![2]==0)?
                                                state.GetChallenges!.challengesStatus![index]!=3
                                                    ? alreatDialogBuilder(context,h,w,state,index)
                                                    : Page2().method(
                                                    _scaffoldKey.currentContext!,
                                                    "Challenges",
                                                    """You have already done this challenge you can come back later when its available🌹""",
                                                    "Back")

                                                    :print("nope");
                                              },
                                              child: Center(
                                                child: Text(
                                                  'Claim',
                                                  //todo: make the color here of Button not text as the message
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          234, 234, 234, 1),
                                                      fontFamily:
                                                          'Red Hat Text',
                                                      fontSize: 16,
                                                      letterSpacing: 0.2,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      height: 1),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      ));

                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(
                                    height: h / 50,
                                  );
                                },
                              ),
                            )))
                    : state.isLoading!
                        ? Container(
                            width: w,
                            height: h / 4,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(child: listLoader(context: context)),
                              ],
                            ))
                        : Container(
                            width: w,
                            height: h / 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
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


              ],
            )),
          );
        });
  }

  Widget listLoader({context}) {
    return SpinKitThreeBounce(
      color: Colors.blue,
      size: 30.0,
    );
  }
}
