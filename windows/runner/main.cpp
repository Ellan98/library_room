#include <flutter/dart_project.h>
#include <flutter/flutter_view_controller.h>
#include <windows.h>

#include "flutter_window.h"
#include "utils.h"

#include "sparkchain.h" // 用你的SDK头文件名替换

class WindowsSDKPlugin : public flutter::Plugin {
public:
    static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar) {
        auto channel = std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
                registrar->messenger(), "com.example.windows_sdk_channel",
                        &flutter::StandardMethodCodec::GetInstance());

        auto plugin = std::make_unique<WindowsSDKPlugin>();

        channel->SetMethodCallHandler(
                [plugin_pointer = plugin.get()](const auto &call, auto result) {
                    plugin_pointer->HandleMethodCall(call, std::move(result));
                });

        registrar->AddPlugin(std::move(plugin));
    }

    WindowsSDKPlugin() {}

    virtual ~WindowsSDKPlugin() {}

private:
    void HandleMethodCall(const flutter::MethodCall<flutter::EncodableValue> &call,
                          std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
        if (call.method_name().compare("callWindowsSDK") == 0) {
            // 调用Windows SDK的代码
            std::string sdk_result = CallSdkFunction();
            result->Success(flutter::EncodableValue(sdk_result));
        } else {
            result->NotImplemented();
        }
    }

    std::string CallSdkFunction() {
        // 调用SDK的函数，并返回结果
        int result = sdk_function(); // 用你的SDK函数替换
        return std::to_string(result);
    }
};


int APIENTRY wWinMain(_In_ HINSTANCE instance, _In_opt_ HINSTANCE prev,
                      _In_ wchar_t *command_line, _In_ int show_command) {
  // Attach to console when present (e.g., 'flutter run') or create a
  // new console when running with a debugger.
  if (!::AttachConsole(ATTACH_PARENT_PROCESS) && ::IsDebuggerPresent()) {
    CreateAndAttachConsole();
  }

  // Initialize COM, so that it is available for use in the library and/or
  // plugins.
  ::CoInitializeEx(nullptr, COINIT_APARTMENTTHREADED);

  flutter::DartProject project(L"data");

  std::vector<std::string> command_line_arguments =
      GetCommandLineArguments();

  project.set_dart_entrypoint_arguments(std::move(command_line_arguments));

  FlutterWindow window(project);
  Win32Window::Point origin(10, 10);
  Win32Window::Size size(1280, 720);
  if (!window.Create(L"library_room", origin, size)) {
    return EXIT_FAILURE;
  }
  window.SetQuitOnClose(true);

  ::MSG msg;
  while (::GetMessage(&msg, nullptr, 0, 0)) {
    ::TranslateMessage(&msg);
    ::DispatchMessage(&msg);
  }

  ::CoUninitialize();
  return EXIT_SUCCESS;
}
