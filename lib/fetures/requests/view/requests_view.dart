import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehetne_provider/fetures/requests/manager/changeStatus/change_status_cubit.dart';

class RequestsView extends StatefulWidget {
  const RequestsView({super.key});

  @override
  State<RequestsView> createState() => _RequestsViewState();
}

class _RequestsViewState extends State<RequestsView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangeStatusCubit(),
      child: BlocConsumer<ChangeStatusCubit, ChangeStatusState>(
        listener: (context, state) {
          if (state is ChangeStatusSuccess) {
            print(state.message);
          } else if (state is ChangeStatusFailure) {
            print(state.errorMessage);
          }
        },
        builder: (context, state) {
          var cubit = BlocProvider.of<ChangeStatusCubit>(context);
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  const Spacer(),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (state is! ChangeStatusLoading) {
                          BlocProvider.of<ChangeStatusCubit>(context)
                              .changeStatus(lati: 50, long: 60);
                        }
                      },
                      child: Text(!cubit.isActive ? "deActive" : "active"),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
