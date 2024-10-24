{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    vim-dadbod
    vim-dadbod-completion
    vim-dadbod-ui
  ];
  extraConfigVim = ''
    let g:db_ui_auto_execute_table_helpers = 1
    let g:db_ui_use_nerd_fonts = 1
  '';
  autoCmd = [
    {
      event = [ "FileType" ];
      pattern = [ "sql" "mysql" "plsql" ];
      command = ''function() require("cmp").setup.buffer({ sources = {{ name = "vim-dadbod-completion"}}) end'';
    }
  ];
}
