{ pkgs, ... }:
let
  settings = {
    theme = "base16_default";

    editor = {
      line-number = "relative";

      lsp.display-messages = true;

      file-picker.hidden = true;

      cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "underline";
      };
    };
  };
in
{
  programs.helix = {
    inherit settings;

    enable = true;
  };
}
