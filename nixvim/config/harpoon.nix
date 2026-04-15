{ pkgs, lib, config, ... }:
{
  plugins.harpoon2 = {
    enable = true;
    package = pkgs.vimPlugins.harpoon2;
    settings = {
      "compile_commands" = let
      create_term = ''
          local command = nil
          local shell = vim.o.shell
          if (type(cmd)=="string") then
            command = cmd
          else
            command = cmd.command
            shell = cmd.shell
          end
          local _buf = vim.api.nvim_create_buf(true,true);
          vim.api.nvim_win_set_buf(0,_buf);
          vim.fn.termopen(shell);
          local _channel = vim.bo.channel;
          return {
            value = command,
            context = {
              buf = _buf,
              channel = _channel,
              initcmd = cmd,
            },
          }'';
      in {
        create_list_item = lib.nixvim.mkRaw ''function(config,cmd)
        ${create_term}
        end'';
        select = lib.nixvim.mkRaw ''function(list_item, list, options)
          if (vim.fn.bufwinnr(list_item.context.buf) == -1) then
            vim.api.nvim_win_set_buf(0,list_item.context.buf);
          end
          if (options == true) then
            vim.api.nvim_chan_send(list_item.context.channel, list_item.value .. "\n")
          end
        end'';
        display = lib.nixvim.mkRaw ''function(list_item)
          return list_item.value:gsub("\n"," \\n ")
        end'';
        encode = lib.nixvim.mkRaw ''function(obj)
          return vim.json.encode(obj.context.initcmd)
        end'';
        decode = lib.nixvim.mkRaw ''function(str)
          local cmd = vim.json.decode(str)
          ${create_term}
        end'';
      };
    };
  };
  extraConfigLua = lib.mkIf config.plugins.harpoon2.enable ''
  vim.api.nvim_create_user_command("AddCompileCommand", function(args) 
    local cmd = table.concat(args.fargs," "):gsub("\\n","\n")
    local arg = {shell = vim.o.shell, command = cmd }
    local item = require"harpoon":list("compile_commands").config:create_list_item(arg)
    require"harpoon":list("compile_commands"):add(item)
  end, {nargs = '+'})
  vim.api.nvim_create_user_command("AddCompileCommandWithShell", function(args) 
    local cmd = table.concat(args.fargs," ",2):gsub("\\n","\n")
    local arg = {shell = args.fargs[1], command = cmd }
    local item = require"harpoon":list("compile_commands").config:create_list_item(arg)
    require"harpoon":list("compile_commands"):add(item)
  end, {nargs = '+'})
  '';
  keymaps = let 
  mkHarpoon = { key, arg, action ? "select", list ? null }:
    {
      key = "<leader>${key}";
      action = lib.nixvim.mkRaw "function() require('harpoon'):list(${if isNull list then "" else "'${list}'"}):${action}(${arg}) end";
      options.desc = "harpoon ${action} ${arg}";
    };
  in lib.mkIf config.plugins.harpoon2.enable [
    (mkHarpoon { key = "n"; arg = "1"; })
    (mkHarpoon { key = "e"; arg = "2"; })
    (mkHarpoon { key = "o"; arg = "3"; })
    (mkHarpoon { key = "i"; arg = "4"; })
    (mkHarpoon { key = "N"; arg = "1"; action = "replace_at"; })
    (mkHarpoon { key = "E"; arg = "2"; action = "replace_at"; })
    (mkHarpoon { key = "O"; arg = "3"; action = "replace_at"; })
    (mkHarpoon { key = "I"; arg = "4"; action = "replace_at"; })
    {
      key = "<leader>Y";
      action = lib.nixvim.mkRaw "function() require('harpoon').ui:toggle_quick_menu(require('harpoon'):list()) end";
      options.desc = "open harpoon menu";
    }
    (mkHarpoon { key = "l"; arg = "1,true"; list = "compile_commands"; })
    (mkHarpoon { key = ","; arg = "2,true"; list = "compile_commands"; })
    (mkHarpoon { key = "."; arg = "3,true"; list = "compile_commands"; })
    (mkHarpoon { key = "-"; arg = "4,true"; list = "compile_commands"; })
    (mkHarpoon { key = "L"; arg = "1,false"; list = "compile_commands"; })
    (mkHarpoon { key = ";"; arg = "2,false"; list = "compile_commands"; })
    (mkHarpoon { key = ":"; arg = "3,false"; list = "compile_commands"; })
    (mkHarpoon { key = "_"; arg = "4,false"; list = "compile_commands"; })
    {
      key = "<leader>K";
      action = lib.nixvim.mkRaw "function() require('harpoon').ui:toggle_quick_menu(require('harpoon'):list('compile_commands')) end";
      options.desc = "open harpoon menu";
    }
  ];
}
