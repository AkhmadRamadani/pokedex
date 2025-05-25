import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rama_poke_app/modules/detail/controllers/detail_controller.dart';
import 'package:rama_poke_app/modules/detail/views/detail_view.dart';

@RoutePage()
class DetailWrapperPage extends StatelessWidget {
  const DetailWrapperPage({super.key, @PathParam('id') required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DetailController()..getPokemon(id),
      child:  DetailView(id: id,),
    );
  }
}
