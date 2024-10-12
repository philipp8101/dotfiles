{
    plugins.conform-nvim = {
        enable = true;
        settings.format_on_save = {
            lspFallback = true;
            timeoutMs = 500;
        };
        formatters_by_bt = {
            javascript = [ "prettier" ];
            typescript = [ "prettier" ];
            css = [ "prettier" ];
            html = [ "prettier" ];
            json = [ "prettier" ];
            yaml = [ "prettier" ];
            markdown = [ "prettier" ];
            graphql = [ "prettier" ];
            lua = [ "stylua" ];
            python = [ "black" ];
            bash = [ "beautysh" ];
            sh = [ "beautysh" ];
            zsh = [ "beautysh" ];
            latex = [ "latexindent" ];
            cmake = [ "cmakelang" ];
        };
    };
}
