{
  config = {
    enableMan = true;
    opts = {
      termguicolors = true;
      relativenumber = true;
      number = true;
      tabstop = 4;
      expandtab = true;
      shiftwidth = 4;
      showcmd = true;
      hlsearch = true;
      smartcase = true;
      mouse = "a";
      scrolloff = 8;
      signcolumn = "yes";
      undofile = true;
      nrformats = "bin,hex,alpha";
      linebreak = true;
      breakindent = true;
      foldlevel = 99;
      updatetime = 250;
      timeoutlen = 300;
    };
    extraConfigLua = ''
      vim.opt.undodir = os.getenv("HOME") .. "/.cache/nvimundo";
    '';
    globals.mapleader = " ";
  };
}
