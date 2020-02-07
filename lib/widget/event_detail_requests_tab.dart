import 'package:collaborate/bloc/auth_bloc.dart';
import 'package:collaborate/bloc/event_bloc.dart';
import 'package:collaborate/model/event_request.dart';
import 'package:collaborate/util/constants.dart';
import 'package:collaborate/util/resources.dart';
import 'package:collaborate/widget/bloc_provider.dart';
import 'package:flutter/material.dart';

class EventDetailRequestsTab extends StatefulWidget {
  final List<EventRequest> requestListForEvent;

  EventDetailRequestsTab(this.requestListForEvent);

  @override
  _EventDetailRequestsTabState createState() => _EventDetailRequestsTabState();
}

class _EventDetailRequestsTabState extends State<EventDetailRequestsTab>
    with TickerProviderStateMixin {
  TabController _tabController;
  EventBloc eventBloc;
  AuthBloc authBloc;

  bool _initDone = false;
  bool _approveOrRejectInProgress = false;
  @override
  void didChangeDependencies() {
    if (!_initDone) {
      eventBloc = BlocProvider.of<EventBloc>(context);
      authBloc = BlocProvider.of<AuthBloc>(context);
    }
    _initDone = true;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  List<EventRequest> get _pendingRequestsMembers {
    return widget.requestListForEvent.where((request) {
      return request.status == "REQUESTED";
    }).toList();
  }

  List<EventRequest> get _approvedRequestsMembers {
    return widget.requestListForEvent.where((request) {
      return request.status == "ACCEPTED";
    }).toList();
    //REQUESTED
  }

  handleApproveOrRejectEvent(
      {int status,
      int requestId,
      int userId,
      String token,
      int eventId}) async {
    setState(() {
      _approveOrRejectInProgress = true;
    });

    final payload = {
      'userId': userId,
      'requestId': requestId,
      'statusId': status,
      'eventId': eventId,
    };

    try {
      await eventBloc.approveOrRejectEvent(payload, token);
      setState(() {
        _approveOrRejectInProgress = false;
      });
      final String snackBarText = status == 1 ? 'ACCEPTED' : 'REJECTED';
      kSnackBar('Request successfully $snackBarText');
    } catch (err) {
      print('Error while approve or reject- $err');
      setState(() {
        _approveOrRejectInProgress = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _approveOrRejectInProgress
        ? CircularProgressIndicator(
            backgroundColor: Theme.of(context).primaryColor,
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ListTile(
                title: Text('Members Detail'),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black54),
                    color: Theme.of(context).primaryColor),
                child: TabBar(
                  unselectedLabelColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 2,
                  controller: _tabController,
                  indicatorColor: Colors.white,
                  labelColor: Colors.white,
                  labelPadding:
                      EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  isScrollable: true,
                  tabs: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 3.0),
                          child: Text(
                            ContentString.pending_requests,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Icon(Icons.layers),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 3.0),
                          child: Text(
                            ContentString.approved_requests,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Icon(Icons.check_box),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                child: TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.only(top: 2),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
                          ),
                          child: ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.all(10),
                            leading:
                                Text(_pendingRequestsMembers[index].userName),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                IconButton(
                                  onPressed: () {
                                    handleApproveOrRejectEvent(
                                        token: authBloc.token,
                                        requestId:
                                            _pendingRequestsMembers[index]
                                                .requestId,
                                        userId: _pendingRequestsMembers[index]
                                            .userId,
                                        status: 1,
                                        eventId: _pendingRequestsMembers[index]
                                            .eventId);
                                  },
                                  color: Colors.lightGreen[900],
                                  icon: Icon(Icons.check),
                                  iconSize: 32,
                                ),
                                IconButton(
                                  onPressed: () {
                                    handleApproveOrRejectEvent(
                                        token: authBloc.token,
                                        requestId:
                                            _pendingRequestsMembers[index]
                                                .requestId,
                                        userId: _pendingRequestsMembers[index]
                                            .userId,
                                        status: 2,
                                        eventId: _pendingRequestsMembers[index]
                                            .eventId);
                                  },
                                  color: Colors.redAccent,
                                  icon: Icon(Icons.cancel),
                                  iconSize: 32,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: _pendingRequestsMembers.length,
                    ),
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.only(top: 2),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
                          ),
                          child: ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.all(10),
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                _approvedRequestsMembers[index].userName,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: _approvedRequestsMembers.length,
                    )
                  ],
                ),
              )
            ],
          );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
