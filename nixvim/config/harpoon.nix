{ pkgs, helpers, lib, config, ... }:
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
          if (vim.fn.bufwinnr(list_item.context.buf) == -1) then
            vim.api.nvim_win_set_buf(0,list_item.context.buf);
          end
          if (options == true) then
            vim.api.nvim_chan_send(list_item.context.channel, list_item.value .. "\n")
          end
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
  keymaps = lib.mkIf config.plugins.harpoon2.enable [
    {
      key = "<leader>l";
      action = helpers.mkRaw "function() require('harpoon'):list():add() end";
      options.desc = "add current buffer to harpoon";
    }
    {
      key = "<leader>L";
      action = helpers.mkRaw "function() require('harpoon').ui:toggle_quick_menu(require('harpoon'):list()) end";
      options.desc = "open harpoon menu";
    }
    {
      key = "<leader>n";
      action = helpers.mkRaw "function() require('harpoon'):list():select(1) end";
      options.desc = "open harpoon entry 1";
    }
    {
      key = "<leader>e";
      action = helpers.mkRaw "function() require('harpoon'):list():select(2) end";
      options.desc = "open harpoon entry 2";
    }
    {
      key = "<leader>o";
      action = helpers.mkRaw "function() require('harpoon'):list():select(3) end";
      options.desc = "open harpoon entry 3";
    }
    {
      key = "<leader>i";
      action = helpers.mkRaw "function() require('harpoon'):list():select(4) end";
      options.desc = "open harpoon entry 4";
    }
    {
      key = "<leader>C";
      action = helpers.mkRaw "function() require('harpoon').ui:toggle_quick_menu(require('harpoon'):list('compile_commands')) end";
      options.desc = "open harpoon menu";
    }
    {
      key = "<leader>N";
      action = helpers.mkRaw "function() require('harpoon'):list('compile_commands'):select(1, true) end";
      options.desc = "run harpoon compile command 1";
    }
    {
      key = "<leader>E";
      action = helpers.mkRaw "function() require('harpoon'):list('compile_commands'):select(2, true) end";
      options.desc = "run harpoon compile command 2";
    }
    {
      key = "<leader>O";
      action = helpers.mkRaw "function() require('harpoon'):list('compile_commands'):select(3, true) end";
      options.desc = "run harpoon compile command 3";
    }
    {
      key = "<leader>I";
      action = helpers.mkRaw "function() require('harpoon'):list('compile_commands'):select(4, true) end";
      options.desc = "run harpoon compile command 4";
    }
    {
      key = "<leader><C-n>";
      action = helpers.mkRaw "function() require('harpoon'):list('compile_commands'):select(1, false) end";
      options.desc = "run harpoon compile command 1";
    }
    {
      key = "<leader><C-e>";
      action = helpers.mkRaw "function() require('harpoon'):list('compile_commands'):select(2, false) end";
      options.desc = "run harpoon compile command 2";
    }
    {
      key = "<leader><C-o>";
      action = helpers.mkRaw "function() require('harpoon'):list('compile_commands'):select(3, false) end";
      options.desc = "run harpoon compile command 3";
    }
    {
      key = "<leader><C-i>";
      action = helpers.mkRaw "function() require('harpoon'):list('compile_commands'):select(4, false) end";
      options.desc = "run harpoon compile command 4";
    }
  ];
  # TODO fix this
  # ] ++ (builtins.map ({key, list ? null, id, args ? null}: {
  #     inherit key;
  #     action = helpers.mkRaw "function() require('harpoon'):list('${lib.optionalString (!builtins.isNull list) list}'):select(${builtins.toString id}${lib.optionalString (!builtins.isNull args) ",${builtins.toString args}"}) end";
  #     # options.desc = "open harpoon entry ${builtins.toString id} on list ${builtins.toString list ? "default"} with args: ${builtins.toString args ? "empty"}";
  # }) [
  #   { key = "<leader>n"; id = 1; }
  #   { key = "<leader>e"; id = 2; }
  #   { key = "<leader>o"; id = 3; }
  #   { key = "<leader>i"; id = 4; }
  #   { key = "<leader>N"; id = 1; list = "compile_commands"; args = true; }
  #   { key = "<leader>E"; id = 2; list = "compile_commands"; args = true; }
  #   { key = "<leader>O"; id = 3; list = "compile_commands"; args = true; }
  #   { key = "<leader>I"; id = 4; list = "compile_commands"; args = true; }
  #   { key = "<leader><C-n>"; id = 1; list = "compile_commands"; args = false; }
  #   { key = "<leader><C-e>"; id = 2; list = "compile_commands"; args = false; }
  #   { key = "<leader><C-o>"; id = 3; list = "compile_commands"; args = false; }
  #   { key = "<leader><C-i>"; id = 4; list = "compile_commands"; args = false; }
  # ]));
}
