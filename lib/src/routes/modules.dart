import 'package:flutter/material.dart';
import 'package:getx_core/getx_core.dart';
import 'package:getx_instance/getx_instance.dart';

import '../router_report.dart';

class Dependencies {
  void lazyPut<S>(
    InstanceBuilderCallback<S> builder, {
    String? tag,
    bool fenix = false,
  }) {
    Get.lazyPut<S>(builder, tag: tag, fenix: fenix);
  }

  S call<S>() {
    return find<S>();
  }

  void spawn<S>(
    InstanceBuilderCallback<S> builder, {
    String? tag,
    bool permanent = true,
  }) => Get.spawn<S>(builder, tag: tag, permanent: permanent);

  S find<S>({String? tag}) => Get.find<S>(tag: tag);

  S put<S>(
    S dependency, {
    String? tag,
    bool permanent = false,
    InstanceBuilderCallback<S>? builder,
  }) => Get.put<S>(dependency, tag: tag, permanent: permanent);

  Future<bool> delete<S>({String? tag, bool force = false}) async =>
      Get.delete<S>(tag: tag, force: force);

  Future<void> deleteAll({bool force = false}) async =>
      Get.deleteAll(force: force);

  void reloadAll({bool force = false}) => Get.reloadAll(force: force);

  void reload<S>({String? tag, String? key, bool force = false}) =>
      Get.reload<S>(tag: tag, key: key, force: force);

  bool isRegistered<S>({String? tag}) => Get.isRegistered<S>(tag: tag);

  bool isPrepared<S>({String? tag}) => Get.isPrepared<S>(tag: tag);

  void replace<P>(P child, {String? tag}) {
    final info = Get.getInstanceInfo<P>(tag: tag);
    final permanent = (info.isPermanent ?? false);
    delete<P>(tag: tag, force: permanent);
    put(child, tag: tag, permanent: permanent);
  }

  void lazyReplace<P>(
    InstanceBuilderCallback<P> builder, {
    String? tag,
    bool? fenix,
  }) {
    final info = Get.getInstanceInfo<P>(tag: tag);
    final permanent = (info.isPermanent ?? false);
    delete<P>(tag: tag, force: permanent);
    lazyPut(builder, tag: tag, fenix: fenix ?? permanent);
  }
}

abstract class Module extends StatefulWidget {
  const Module({super.key});

  Widget view(BuildContext context);

  void dependencies(Dependencies i);

  @override
  ModuleState createState() => ModuleState();
}

class ModuleState extends State<Module> {
  @override
  void initState() {
    RouterReportManager.instance.reportCurrentRoute(this);
    widget.dependencies(Dependencies());
    super.initState();
  }

  @override
  void dispose() {
    RouterReportManager.instance.reportRouteDispose(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.view(context);
  }
}
