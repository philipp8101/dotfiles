{ pkgs, helpers, ... }:
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
        create_list_item = helpers.mkRaw ''function(config,cmd)
        ${create_term}
        end'';
        select = helpers.mkRaw ''function(list_item, list, options)
          vim.api.nvim_win_set_buf(0,list_item.context.buf);
          vim.api.nvim_chan_send(list_item.context.channel, list_item.value .. "\n")
        end'';
        display = helpers.mkRaw ''function(list_item)
          return list_item.value:gsub("\n"," \\n ")
        end'';
        encode = helpers.mkRaw ''function(obj)
          return vim.json.encode(obj.context.initcmd)
        end'';
        decode = helpers.mkRaw ''function(str)
          local cmd = vim.json.decode(str)
          ${create_term}
        end'';
      };
    };
  };
  extraConfigLua = ''
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
  keymaps = [
    {
      key = "<leader>l";
      action.__raw = ''function() require("harpoon"):list():add() end'';
      options.desc = "add current buffer to harpoon";
    }
    {
      key = "<leader>L";
      action.__raw = ''function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end'';
      options.desc = "open harpoon menu";
    }
    {
      key = "<leader>n";
      action.__raw = ''function() require("harpoon"):list():select(1) end'';
      options.desc = "open harpoon entry 1";
    }
    {
      key = "<leader>e";
      action.__raw = ''function() require("harpoon"):list():select(2) end'';
      options.desc = "open harpoon entry 2";
    }
    {
      key = "<leader>o";
      action.__raw = ''function() require("harpoon"):list():select(3) end'';
      options.desc = "open harpoon entry 3";
    }
    {
      key = "<leader>i";
      action.__raw = ''function() require("harpoon"):list():select(4) end'';
      options.desc = "open harpoon entry 4";
    }
    {
      key = "<leader>C";
      action.__raw = ''function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list("compile_commands")) end'';
      options.desc = "open harpoon menu";
    }
    {
      key = "<leader>N";
      action.__raw = ''function() require("harpoon"):list("compile_commands"):select(1) end'';
      options.desc = "run harpoon compile command 1";
    }
    {
      key = "<leader>E";
      action.__raw = ''function() require("harpoon"):list("compile_commands"):select(2) end'';
      options.desc = "run harpoon compile command 2";
    }
    {
      key = "<leader>O";
      action.__raw = ''function() require("harpoon"):list("compile_commands"):select(3) end'';
      options.desc = "run harpoon compile command 3";
    }
    {
      key = "<leader>I";
      action.__raw = ''function() require("harpoon"):list("compile_commands"):select(4) end'';
      options.desc = "run harpoon compile command 4";
    }
  ];
}
