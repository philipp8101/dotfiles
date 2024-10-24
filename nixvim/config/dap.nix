{
  plugins.dap = {
    enable = true;
    # signs = {
    #     dapBreakpoint.linehl = "";
    #     dapBreakpointCondition.linehl = "";
    #     dapBreakpointRejected.linehl = "";
    #     dapLogPoint.linehl = "";
    #     dapStopped.linehl = "";
    # };
    # Error detected while processing /nix/store/4mji873qra4d836frgfrjwayrjcnnkfh-init.lua:
    # E5113: Error while calling lua chunk: Vim:E5248: Invalid character in group name
    # stack traceback:
    #         [C]: in function 'sign_define'
    #         /nix/store/4mji873qra4d836frgfrjwayrjcnnkfh-init.lua:102: in main chunk
    extensions = {
      dap-virtual-text.enable = true;
      dap-python.enable = true;
      dap-go.enable = true;
    };
    adapters.servers = { };
    # https://nix-community.github.io/nixvim/plugins/dap/adapters/servers/index.html
  };
}
