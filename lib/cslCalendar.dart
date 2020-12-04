
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:table_calendar/table_calendar.dart'; 
import 'package:intl/intl.dart';

class cslCalendar extends StatefulWidget{
  
  @override
  _cslcalendarPageState createState() => new _cslcalendarPageState();
}

class _cslcalendarPageState extends State<cslCalendar> with TickerProviderStateMixin{
  CalendarController _calendarController;
  DateTime currentDate;
  
  int _currentMonth = 0;
  int _currentYear = 0;
  DateFormat ddmmyyyy = new DateFormat('dd-MM-yyyy');
  /*final Map<DateTime, List> _events = {
                                          
                                          DateTime(2021,01,27) : ['Republic Day', 'Holiuday2'],
                                          DateTime(2021,01,29) : ['Martyr\'s Day'],
                                          DateTime(2021,02,14) : ['Valentine\'s Day'],
                                    };*/
  final Map<DateTime, List> _holidays = {
                                          DateTime(2021,01,09) : ['Second Saturday'],
                                          DateTime(2021,01,03) : ['Sunday'],
                                          DateTime(2021,01,10) : ['Sunday'],
                                          DateTime(2021,01,17) : ['Sunday'],
                                          DateTime(2021,01,24) : ['Sunday'],
                                          DateTime(2021,01,31) : ['Sunday'],
                                          DateTime(2021,01,23) : ['Fourth Saturday'],
                                          DateTime(2021,01,26) : ['Republic Day'],

                                          DateTime(2021,02,13) : ['Second Saturday'],
                                          DateTime(2021,02,14) : ['Sunday'],
                                          DateTime(2021,02,07) : ['Sunday'],
                                          DateTime(2021,02,21) : ['Sunday'],
                                          DateTime(2021,02,28) : ['Sunday'],
                                          DateTime(2021,02,27) : ['Fourth Saturday'],

                                          DateTime(2021,03,13) : ['Second Saturday'],
                                          DateTime(2021,03,07) : ['Sunday'],
                                          DateTime(2021,03,14) : ['Sunday'],
                                          DateTime(2021,03,21) : ['Sunday'],
                                          DateTime(2021,03,28) : ['Sunday'],
                                          DateTime(2021,03,27) : ['Fourth Saturday'],

                                          DateTime(2021,04,01) : ['Maundy Thursday'],
                                          DateTime(2021,04,02) : ['Good Friday'],
                                          DateTime(2021,04,14) : ['Vishu / \n          Dr. B.R. Ambedkar Jayanthi'],
                                          DateTime(2021,04,10) : ['Second Saturday'],
                                          DateTime(2021,04,04) : ['Sunday'],
                                          DateTime(2021,04,11) : ['Sunday'],
                                          DateTime(2021,04,18) : ['Sunday'],
                                          DateTime(2021,04,25) : ['Sunday'],
                                          DateTime(2021,04,24) : ['Fourth Saturday'],

                                          DateTime(2021,05,01) : ['May Day'],
                                          DateTime(2021,05,13) : ['Id-ul-fitr (Ramzan)'],
                                          DateTime(2021,05,08) : ['Second Saturday'],
                                          DateTime(2021,05,02) : ['Sunday'],
                                          DateTime(2021,05,09) : ['Sunday'],
                                          DateTime(2021,05,16) : ['Sunday'],
                                          DateTime(2021,05,23) : ['Sunday'],
                                          DateTime(2021,05,30) : ['Sunday'],
                                          DateTime(2021,05,22) : ['Fourth Saturday'],

                                          DateTime(2021,06,12) : ['Second Saturday'],
                                          DateTime(2021,06,06) : ['Sunday'],
                                          DateTime(2021,06,13) : ['Sunday'],
                                          DateTime(2021,06,20) : ['Sunday'],
                                          DateTime(2021,06,27) : ['Sunday'],
                                          DateTime(2021,06,26) : ['Fourth Saturday'],

                                          DateTime(2021,07,20) : ['Id-ul-Ad\'ha'],
                                          DateTime(2021,07,10) : ['Second Saturday'],
                                          DateTime(2021,07,04) : ['Sunday'],
                                          DateTime(2021,07,11) : ['Sunday'],
                                          DateTime(2021,07,18) : ['Sunday'],
                                          DateTime(2021,07,25) : ['Sunday'],
                                          DateTime(2021,07,24) : ['Fourth Saturday'],

                                          DateTime(2021,08,20) : ['First Onam'],
                                          DateTime(2021,08,21) : ['Second Onam'],
                                          DateTime(2021,08,23) : ['Fourth Onam / \n          Sree Narayana Guru Jayanthi'],
                                          DateTime(2021,08,07) : ['Second Saturday'],
                                          DateTime(2021,08,01) : ['Sunday'],
                                          DateTime(2021,08,08) : ['Sunday'],
                                          DateTime(2021,08,15) : ['Sunday'],
                                          DateTime(2021,08,22) : ['Sunday'],
                                          DateTime(2021,08,29) : ['Sunday'],
                                          DateTime(2021,08,21) : ['Fourth Saturday'],

                                          DateTime(2021,09,11) : ['Second Saturday'],
                                          DateTime(2021,09,05) : ['Sunday'],
                                          DateTime(2021,09,12) : ['Sunday'],
                                          DateTime(2021,09,19) : ['Sunday'],
                                          DateTime(2021,09,26) : ['Sunday'],
                                          DateTime(2021,09,25) : ['Fourth Saturday'],

                                          DateTime(2021,10,02) : ['Gandhi Jayanthi'],
                                          DateTime(2021,10,15) : ['Vijayadasami'],
                                          DateTime(2021,10,09) : ['Second Saturday'],
                                          DateTime(2021,10,03) : ['Sunday'],
                                          DateTime(2021,10,10) : ['Sunday'],
                                          DateTime(2021,10,17) : ['Sunday'],
                                          DateTime(2021,10,24) : ['Sunday'],
                                          DateTime(2021,10,31) : ['Sunday'],
                                          DateTime(2021,10,23) : ['Fourth Saturday'],

                                          DateTime(2021,11,13) : ['Second Saturday'],
                                          DateTime(2021,11,07) : ['Sunday'],
                                          DateTime(2021,11,14) : ['Sunday'],
                                          DateTime(2021,11,21) : ['Sunday'],
                                          DateTime(2021,11,28) : ['Sunday'],
                                          DateTime(2021,11,27) : ['Fourth Saturday'],

                                          DateTime(2021,12,11) : ['Second Saturday'],
                                          DateTime(2021,12,05) : ['Sunday'],
                                          DateTime(2021,12,12) : ['Sunday'],
                                          DateTime(2021,12,19) : ['Sunday'],
                                          DateTime(2021,12,26) : ['Sunday'],
                                          DateTime(2021,12,25) : ['Fourth Saturday'],

  };
  List<DateTime> holidayKeys = [];
  List<String> holidayKeyString = [];
  DateFormat yyyymmdd = DateFormat('yyyy-MM-dd');
  DateTime _selectedDay;
  List  _selectedEvents;
  List _selectedMonthHolidays = [];
  List _calendarHolidayList;
  //Map<DateTime, List> _mapMonthHolidays = {};
  List _lstMonthHolidays = [];
  
  @override 
  initState(){
    super.initState();
    _calendarHolidayList = [];
    _calendarController = CalendarController();
    _selectedDay = DateTime(2021,01,01);
    _currentMonth = _selectedDay.month;
    _currentYear = _selectedDay.year;
      _selectedMonthHolidays = _holidays.keys.toList();
      _lstMonthHolidays =[];
      _selectedMonthHolidays.forEach((element) {
        if(element.month == _selectedDay.month){
          String hols = "";
          _holidays[element].forEach((e) {
            if(!(e.contains('Saturday') || e.contains('Sunday'))){
              if(hols == ""){
                if(element.day % 10 == element.day ){
                  hols = " " + element.day.toString() + "  :  " + e;
                  print("Hi");
                }
                else
                  hols = element.day.toString() + "  :  " + e;
              }
              else
                hols = " ," + e;
            }            
          }); 

          if(hols != "")
            _lstMonthHolidays.add(hols);
          print("_lstMonthHolidays :: " + _lstMonthHolidays.toString());
        }
      }); 

      _calendarHolidayList = _lstMonthHolidays;
  }

  @override
  Widget build(BuildContext context){

    Widget _buildEventsMarker(DateTime date, List events) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: _calendarController.isSelected(date)
              ? Colors.brown[500]
              : _calendarController.isToday(date) ? Colors.brown[300] : Colors.blue[400],
        ),
        width: 16.0,
        height: 16.0,
        child: Center(
          child: Text(
            '${events.length}',
            style: TextStyle().copyWith(
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
        ),
      );
    }

    void _onVisibleDaysChanged(DateTime startDay){
      _currentMonth = startDay.month;
      _currentYear = startDay.year;
      _calendarHolidayList = [];
      _selectedMonthHolidays = _holidays.keys.toList();
      _lstMonthHolidays =[];
      _selectedMonthHolidays.forEach((element) {
        if(element.month == startDay.month){
          String hols = "";
          _holidays[element].forEach((e) {
            if(!(e.contains('Saturday') || e.contains('Sunday'))){
              if(hols == "")
                hols = element.day.toString() + "  :  " + e;
              else
                hols = " ," + e;
            }            
          }); 

          if(hols != "")
            _lstMonthHolidays.add(hols);
          print("_lstMonthHolidays :: " + _lstMonthHolidays.toString());
        }
      }); 

      setState(() {
        _calendarHolidayList = _lstMonthHolidays;
      });
      
      
      //_selectedMonth = day.month;   // Get the selected Month 
      //_selectedMonthHolidays = _holidays.keys.toList();
     // _selectedMonthHolidays.removeWhere((e) => (e.month != _currentMonth));
      //print(_selectedHolidays.toString());
      /*_selectedMonthHolidays.forEach((item) { 
        if(_mapMonthHolidays[item] == null)
          _mapMonthHolidays[item] = [];

        if(_holidays[item].isNotEmpty ){
          _holidays[item].forEach((i) { 
            if(!_holidays[i].contains('Saturday') || !_holidays[i].contains('Sunday'))
            _mapMonthHolidays[item].add(_holidays[i]);
          });
        } 
      });*/
      //print("Month Holidays " + _mapMonthHolidays.toString());
    }
    /*void _onDaySelected(DateTime day, List events, List holidays) {
      print('CALLBACK: _onDaySelected');
      setState(() {
        _selectedEvents = events;
        _selectedHolidays = holidays;
        /*_selectedMonth = day.month;   // Get the selected Month 
        _selectedHolidays = _holidays.keys.toList();
        _selectedHolidays.removeWhere((e) => (e.month == _selectedMonth));*/

        List holsToRemove = [];
        if(_selectedHolidays.length > 0){
            _selectedHolidays.forEach((element) {
              if(element.contains('Saturday') || element.contains('Sunday')){
                holsToRemove.add(element);
              }
            });
            _selectedHolidays.removeWhere((e) => holsToRemove.contains(e));
            print('Date :: ' + day.toString() + ' , ' + _selectedHolidays.toString());
        }

        //_selectedHolidays = _selectedHolidays.where((holiday) => !((holiday.contains('Sunday') || holiday.contains('Saturday'))));
        currentDate = day;
      });
    }*/

    //Build Holiday Marker
    Widget _buildHolidaysMarker() {
      return Icon(
        Icons.add_box,
        size: 20.0,
        color: Colors.blueGrey[800],
      );
    }

    Widget _buildHolidayList() {
      return Column(
              
              //mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                //Padding( padding: EdgeInsets.fromLTRB(5.0,20.0,5.0,5.0), child: Text('Holidays', style: TextStyle(fontSize : 15.0, fontFamily: 'Armata', fontWeight: FontWeight.w900, color: Colors.red),), ),
                
                Row(
                  children: [
                    Container(
                     margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                      child: Text('Holidays', style: TextStyle( fontSize : 15.0, fontFamily: 'Armata', fontWeight: FontWeight.w900, color: Colors.red),),
                ),
                  ],
                ),
                Container(
                  height:150.0,
                  margin: EdgeInsets.only(
                    top: 10.0,
                  ),
                  child:ListView(
                      children: _calendarHolidayList
                          .map((holiday) => Container(
                            width: MediaQuery.of(context).size.width  ,
                                /*decoration: BoxDecoration(
                                  border: Border.all(width: 0.8),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),*/
                                margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                child: Container(
                                  constraints: new BoxConstraints(
                                                  maxWidth: MediaQuery.of(context).size.width - 84),
                                  
                                  child: Row(
                                    children: <Widget>[                                          
                                        Padding( padding: EdgeInsets.fromLTRB(20.0,0.0,20.0,0.0), child: Text(holiday.toString(), style: TextStyle(fontSize: 13.0, fontFamily: 'Armata', fontWeight: FontWeight.w700),))
                                      
                                    ]
                                  )      
                                )                            
                                  /*ListTile(
                                  title: Text(event.toString()),
                                  onTap: () => print('$event tapped!'),
                                ),*/
                          )).toList(),                      
                          
                  ))]
                );
    }

    Widget _returnMonthImages(){
          switch(_currentMonth){
              case 1 : { return Container( child: Image.asset('images/01-JAN.jpg'));}
              break;
              case 2 : { return Container( child: Image.asset('images/02-FEB.jpg'));}
              break;
              case 3 : { return Container( child: Image.asset('images/03-MAR.jpg'));}
              break;
              case 4 : { return Container( child: Image.asset('images/04-APR.jpg'));}
              break;
              case 5 : { return Container( child: Image.asset('images/05-MAY.jpg'));}
              break;
              case 6 : { return Container( child: Image.asset('images/06-JUN.jpg'));}
              break;
              case 7 : { return Container( child: Image.asset('images/07-JUL.jpg'));}
              break;
              case 8 : { return Container( child: Image.asset('images/08-AUG.jpg'));}
              break;
              case 9 : { return Container( child: Image.asset('images/09-SEP.jpg'));}
              break;
              case 10 : { return Container( child: Image.asset('images/10-OCT.jpg'));}
              break;
              case 11 : { return Container( child: Image.asset('images/11-NOV.jpg'));}
              break;
              case 12 : { return Container( child: Image.asset('images/12-DEC.jpg'));}
              break;
          }
    
      return Container();
    }

    Widget _buildEventList() {
    return ListView(
      children: _selectedEvents
          .map((event) => Container(
                width: MediaQuery.of(context).size.width - 70.0,
                decoration: BoxDecoration(
                  border: Border.all(width: 0.8),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: ListTile(
                  title: Text(event.toString()),
                  onTap: () => print('$event tapped!'),
                ),
              ))
          .toList(),
    );
  }

    return Scaffold(
        appBar : PreferredSize(
                                  preferredSize: Size.fromHeight(100.0), 
                                  child: AppBar(      
                                    backgroundColor: Colors.lightBlueAccent,                              
                                    flexibleSpace: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                child: Padding( padding: EdgeInsets.fromLTRB(20.0,35.0, 5.0, 10.0) , child: Container(child: Image.asset('images/csllogo.png', width: 87, height: 87 ))),
                                              ),
                                              Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                                      children:<Widget>[
                                                        Padding(padding: EdgeInsets.fromLTRB(25.0,25.0, 0.0, 0.0),
                                                                child: Text('सी.ऐस.ऐल कैलेंडर', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 23.0, color: Colors.white, ),),),
                                                        Padding(padding: EdgeInsets.fromLTRB(25.0, 5.0,5.0,3.0),
                                                                child: Text('CSL CALENDAR', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25.0, color: Colors.white, ),)),
                                                      ]  
                                                    ),
                                          ])
                                  )
                          ),
        body:SafeArea(
          child: SingleChildScrollView(
          child: Container(
            child: Column(
          mainAxisSize: MainAxisSize.max,
          
          children: <Widget>[
              /*Column(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 10.0,
                      //child: Image.asset('images/bluebar.png')
                      color: Colors.white,
                    )
                ],
              ),*/
            _returnMonthImages(),
            TableCalendar(  
              initialCalendarFormat: CalendarFormat.month,  
              formatAnimation: FormatAnimation.slide,
              initialSelectedDay: DateTime.fromMillisecondsSinceEpoch(1609525800000),
              startDay: DateTime.fromMillisecondsSinceEpoch(1609439400000),
              endDay: DateTime.fromMillisecondsSinceEpoch(1640975400000),
              holidays: _holidays,
              //events: _events,
              
              daysOfWeekStyle: DaysOfWeekStyle(
                
                dowTextBuilder: (date, locale) => DateFormat.E(locale).format(date)[0],
                weekdayStyle: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20.0,                  
                ),
                weekendStyle: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20.0,
                  color: Colors.red
                )
              ),
              calendarStyle: CalendarStyle( 
                  todayColor: Colors.blue,                 
                  selectedColor: Theme.of(context).primaryColor,  
                  todayStyle: TextStyle(  
                      fontWeight: FontWeight.w900,                       
                      fontSize: 30.0,  
                      color: Colors.white),
                  weekendStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 30.0,
                  ),
                  weekdayStyle: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize:30.0
                  ),
                  holidayStyle: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 30.0,
                    color: Colors.red
                  )  
              ),  
              headerStyle: HeaderStyle(
                centerHeaderTitle: true,
                formatButtonVisible: false,
                titleTextBuilder: (date, locale) => DateFormat.yMMMM(locale).format(date).toUpperCase(),
                titleTextStyle: TextStyle(
                  fontSize: 25.0,
                  fontWeight : FontWeight.w900,
                  color: Colors.green
                )
              ),  
              startingDayOfWeek: StartingDayOfWeek.sunday,  
              /*onDaySelected: (date, events) {  
                print(date.toUtc());  
              },*/  
              builders: CalendarBuilders(  
                selectedDayBuilder: (context, date, events) { 
                  if(events != null) print('Events ' + events.toString());
                  print(date.weekday);
                  
                  
                  if(holidayKeyString.contains(yyyymmdd.format(date).toString()) || date.weekday == 7 ){
                   return Container(  
                    margin: const EdgeInsets.all(5.0),  
                    alignment: Alignment.center,  
                    decoration: BoxDecoration(  
                        color:  Colors.lightBlueAccent,
                        borderRadius: BorderRadius.circular(8.0)),  
                    child: Text(  
                      date.day.toString(),  
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 30.0),  
                    ));
                  }
                  else{
                      return Container(  
                        margin: const EdgeInsets.all(5.0),  
                        alignment: Alignment.center,  
                        decoration: BoxDecoration(  
                            color: Theme.of(context).primaryColor,  
                            borderRadius: BorderRadius.circular(8.0)),  
                        child: Text(  
                          date.day.toString(),  
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 30.0),  
                      ));
                    }
                  },                    
               
                todayDayBuilder: (context, date, events) => Container(  
                    margin: const EdgeInsets.all(5.0),  
                    alignment: Alignment.center,  
                    decoration: BoxDecoration(  
                        color: Colors.blue,  
                        borderRadius: BorderRadius.circular(8.0)),  
                    child: Text(  
                      date.day.toString(),  
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 30.0),  
                    )), 

                /*markersBuilder: (context, date, events, holidays) {
                      final children = <Widget>[];
                      
                      if (events.isNotEmpty) {
                        children.add(
                          Positioned(
                            right: 1,
                            bottom: 1,
                            child: _buildEventsMarker(date, events),
                          ),
                        );
                      }

                      /*if (holidays.isNotEmpty) {
                        children.add(
                          Positioned(
                            right: -2,
                            top: -2,
                            child: _buildHolidaysMarker(),
                          ),
                        );
                      }*/

                      print('HOLSSS' + holidays.toString()); 
                      return children;
                }*/
              ),  
              /*onDaySelected: (date, events, holidays) {
                _onDaySelected(date, events, holidays);
              },*/
              onVisibleDaysChanged: (DateTime start, DateTime end, CalendarFormat format){
                start = start.add(new Duration(days: 7));
                _onVisibleDaysChanged(start);
              },
              availableGestures: AvailableGestures.horizontalSwipe,
              onHeaderTapped: (DateTime day){
                print('Yoooo ' + day.toString());
              },
              calendarController: _calendarController,  
            ) ,

            Column(                        
              children:<Widget> [Container(
                width: MediaQuery.of(context).size.width,
                height: 10.0,
                //child: Image.asset('images/bluebar.png')
                color: Colors.lightBlueAccent,
              ),]
            ),

            Padding(padding: EdgeInsets.all(10.0),
              child: Container(
                
                child: Column(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      /*Padding( padding: EdgeInsets.all(10.0,),
                            child: Text('Date : ' + ddmmyyyy.format(currentDate) , style: TextStyle(fontSize : 15.0, fontFamily: 'Roboto', fontWeight: FontWeight.w900),)),*/
                      _buildHolidayList(),    
                    ]
                )
              )
            ),
            
            
            
            
            /*Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                    Padding( padding: EdgeInsets.all(10.0,),
                            child: Text('Date : ' + ddmmyyyy.format(currentDate) , style: TextStyle(fontSize : 15.0, fontFamily: 'Roboto', fontWeight: FontWeight.w900),)),
                    Padding( padding: EdgeInsets.all(5.0,), child: Text('Holiday List', style: TextStyle(fontSize : 15.0, fontFamily: 'Roboto', fontWeight: FontWeight.w900),), ),
                    _buildHolidayList()
                  
                ],
              )
            )
            SingleChildScrollView(
                child: Card(                  
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(75.0),
                            topRight: Radius.circular(75.0),
                            bottomLeft: Radius.circular(75.0),
                            bottomRight: Radius.circular(75.0),
                          ),
                        ),
                  
                        child:  (_selectedHolidays.length ==0)?
                                  Container():
                                  Container(
                                      child: Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Column(
                                        children: <Widget>[
                                            Padding( padding: EdgeInsets.all(10.0,),
                                                    child: Text('Date : ' + ddmmyyyy.format(currentDate) , style: TextStyle(fontSize : 15.0, fontFamily: 'Roboto', fontWeight: FontWeight.w900),)),
                                            Padding( padding: EdgeInsets.all(5.0,), child: Text('Holiday List', style: TextStyle(fontSize : 15.0, fontFamily: 'Roboto', fontWeight: FontWeight.w900),), ),
                                            _buildHolidayList()
                                          
                                        ],
                                      )
                                    )   
                                  )                            
              )
            )*/
        
          ],
        ) 
        )   
      ) 
        )  
    );
  }
}