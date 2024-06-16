require("env/not_to_sysnc")

ENV = {}

if IS_LINUX then
  ENV.im_select = {
    default_im_select = "keyboard-us",
    default_command = "fcitx5-remote",
  }

  ENV.delta_path = "/usr/bin/delta"
else
  ENV.im_select = {
    default_im_select = "com.apple.keylayout.ABC",
    default_command = "im-select",
  }
end
