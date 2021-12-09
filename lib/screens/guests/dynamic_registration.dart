import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:weddingrsvp/component/background.dart';
import 'package:weddingrsvp/providers/current_user.dart';
import 'package:weddingrsvp/providers/loading_form_bloc.dart';

class DynamicRegistration extends StatelessWidget {
  const DynamicRegistration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: BackgroundCore(
        child: ListFieldsForm(),
      ),
    );
  }
}

class ListFieldsForm extends StatefulWidget {
  @override
  State<ListFieldsForm> createState() => _ListFieldsFormState();
}

class _ListFieldsFormState extends State<ListFieldsForm> {
  bool initialContact = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ListFieldFormBloc(context.read<CurrentUserData>().guestsData),
      child: Builder(
        builder: (context) {
          final formBloc = context.watch<ListFieldFormBloc>();
          return Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                    // borderRadius: BorderRadius.circular(20),
                    ),
              ),
            ),
            child: FormBlocListener<ListFieldFormBloc, String, String>(
              onSubmitting: (context, state) {
                LoadingDialog.show(context);
              },
              onSuccess: (context, state) {
                LoadingDialog.hide(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: SingleChildScrollView(
                      child: Text(
                        state.successResponse!,
                      ),
                    ),
                    duration: Duration(
                      milliseconds: 1500,
                    ),
                  ),
                );
              },
              onFailure: (context, state) {
                LoadingDialog.hide(context);

                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.failureResponse!)));
              },
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    Card(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TextFieldBlocBuilder(
                            textFieldBloc: formBloc.initialGuest,
                            isEnabled: false,
                            decoration: InputDecoration(
                              labelText: 'Initial Guest Name',
                              prefixIcon: Icon(Icons.person),
                            ),
                          ),
                          SwitchFieldBlocBuilder(
                            booleanFieldBloc: formBloc.initialGuestContactType,
                            body: const Text('Email or Phone'),
                          ),
                          TextFieldBlocBuilder(
                            textFieldBloc: formBloc.initialContact,
                            decoration: InputDecoration(
                              labelText: formBloc.initialGuestContactType.value
                                  ? 'Phone'
                                  : 'Email',
                              prefixIcon: Icon(
                                  formBloc.initialGuestContactType.value
                                      ? Icons.phone
                                      : Icons.email),
                            ),
                          ),
                        ],
                      ),
                    )),
                    BlocBuilder<ListFieldBloc<MemberFieldBloc, dynamic>,
                        ListFieldBlocState<MemberFieldBloc, dynamic>>(
                      bloc: formBloc.additionalGuests,
                      builder: (context, state) {
                        if (state.fieldBlocs.isNotEmpty) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.fieldBlocs.length,
                            itemBuilder: (context, i) {
                              return MemberCard(
                                memberIndex: i,
                                memberField: state.fieldBlocs[i],
                                onRemoveMember: () => formBloc.removeMember(i),
                              );
                            },
                          );
                        }
                        return Container();
                      },
                    ),
                    ElevatedButton(
                      onPressed: formBloc.submit,
                      child: Text('RSVP'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class MemberCard extends StatefulWidget {
  final int memberIndex;
  final MemberFieldBloc memberField;

  final VoidCallback onRemoveMember;

  const MemberCard({
    Key? key,
    required this.memberIndex,
    required this.memberField,
    required this.onRemoveMember,
  }) : super(key: key);

  @override
  State<MemberCard> createState() => _MemberCardState();
}

class _MemberCardState extends State<MemberCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      // color: Colors.blue[100],
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Guest #${widget.memberIndex + 1}',
                    style: TextStyle(fontSize: 20),
                  ),
                ),

                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: widget.onRemoveMember,
                ),
              ],
            ),
            SwitchFieldBlocBuilder(
              booleanFieldBloc: widget.memberField.dependant,
              body: const Text('Dependant or Independent'),
            ),
            TextFieldBlocBuilder(
              textFieldBloc: widget.memberField.firstName,
              decoration: InputDecoration(
                labelText: 'First Name',
              ),
            ),
            TextFieldBlocBuilder(
              textFieldBloc: widget.memberField.lastName,
              decoration: InputDecoration(
                labelText: 'Last Name',
              ),
            ),
            widget.memberField.dependant.value
                ? SwitchFieldBlocBuilder(
                    booleanFieldBloc: widget.memberField.contactType,
                    body: const Text('Email or Phone'),
                  )
                : SizedBox(height: 1,),
            widget.memberField.dependant.value
                ? TextFieldBlocBuilder(
                    textFieldBloc: widget.memberField.contact,
                    decoration: InputDecoration(
                      labelText: widget.memberField.contactType.value
                          ? 'Phone'
                          : 'Email',
                      prefixIcon: Icon(widget.memberField.contactType.value
                          ? Icons.phone
                          : Icons.email),
                    ),
                  )
                : SizedBox(height: 1,),
          ],
        ),
      ),
    );
  }
}

class LoadingDialog extends StatelessWidget {
  static void show(BuildContext context, {Key? key}) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => LoadingDialog(key: key),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          child: Container(
            width: 80,
            height: 80,
            padding: EdgeInsets.all(12.0),
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
  SuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.tag_faces, size: 100),
            SizedBox(height: 10),
            Text(
              'Success',
              style: TextStyle(fontSize: 54, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => ListFieldsForm())),
              icon: Icon(Icons.replay),
              label: Text('AGAIN'),
            ),
          ],
        ),
      ),
    );
  }
}
