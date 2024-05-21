//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <biometric_storage/biometric_storage_plugin.h>
#include <desktop_window/desktop_window_plugin.h>
#include <irondash_engine_context/irondash_engine_context_plugin.h>
#include <objectbox_flutter_libs/objectbox_flutter_libs_plugin.h>
#include <super_native_extensions/super_native_extensions_plugin.h>
#include <url_launcher_linux/url_launcher_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) biometric_storage_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "BiometricStoragePlugin");
  biometric_storage_plugin_register_with_registrar(biometric_storage_registrar);
  g_autoptr(FlPluginRegistrar) desktop_window_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "DesktopWindowPlugin");
  desktop_window_plugin_register_with_registrar(desktop_window_registrar);
  g_autoptr(FlPluginRegistrar) irondash_engine_context_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "IrondashEngineContextPlugin");
  irondash_engine_context_plugin_register_with_registrar(irondash_engine_context_registrar);
  g_autoptr(FlPluginRegistrar) objectbox_flutter_libs_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "ObjectboxFlutterLibsPlugin");
  objectbox_flutter_libs_plugin_register_with_registrar(objectbox_flutter_libs_registrar);
  g_autoptr(FlPluginRegistrar) super_native_extensions_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "SuperNativeExtensionsPlugin");
  super_native_extensions_plugin_register_with_registrar(super_native_extensions_registrar);
  g_autoptr(FlPluginRegistrar) url_launcher_linux_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "UrlLauncherPlugin");
  url_launcher_plugin_register_with_registrar(url_launcher_linux_registrar);
}
