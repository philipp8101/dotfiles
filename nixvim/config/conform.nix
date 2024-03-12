{
    plugins.conform-nvim = {
        enable = true;
        formatOnSave = {
            lspFallback = true;
            timeoutMs = 500;
        };
        formattersByFt = {
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
