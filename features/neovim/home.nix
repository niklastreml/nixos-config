{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myFeatures.neovim;
in
{
  config = lib.mkIf cfg.enable {
    programs.nixvim = {
    enable = true;

    # ── Global Variables ─────────────────────────────────────────
    globals = {
      mapleader = " ";
      maplocalleader = "\\";
    };

    # ── Editor Options ───────────────────────────────────────────
    opts = {
      number = true;
      relativenumber = true;
      scrolloff = 10;
      mouse = "a";
      hlsearch = true;
      shiftwidth = 4;
      smarttab = true;
      expandtab = true;
      tabstop = 8;
      softtabstop = 0;
      cmdheight = 1;
      conceallevel = 1;
      linebreak = true;
      colorcolumn = "100";
      clipboard = "unnamedplus";
      breakindent = true;
      undofile = true;
      ignorecase = true;
      smartcase = true;
      signcolumn = "yes";
      updatetime = 250;
      timeoutlen = 300;
      completeopt = "menuone,noselect";
      termguicolors = true;
    };

    # ── Keymaps ──────────────────────────────────────────────────
    keymaps = [
      # File explorer
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>Oil<CR>";
        options.desc = "File Explorer";
      }

      # LSP
      {
        mode = "n";
        key = "K";
        action.__raw = "vim.lsp.buf.hover";
        options.desc = "Hover";
      }
      {
        mode = "n";
        key = "gD";
        action.__raw = "vim.lsp.buf.declaration";
        options.desc = "[G]oto [D]eclaration";
      }
      {
        mode = "n";
        key = "<leader>lr";
        action.__raw = "vim.lsp.buf.rename";
        options.desc = "[R]ename";
      }
      {
        mode = "n";
        key = "<leader>la";
        action.__raw = "vim.lsp.buf.code_action";
        options.desc = "Code [A]ction";
      }
      {
        mode = "n";
        key = "<leader>lf";
        action.__raw = "vim.lsp.buf.format";
        options.desc = "[F]ormat";
      }
      {
        mode = "n";
        key = "<leader>li";
        action.__raw = "vim.lsp.buf.implementation";
        options.desc = "[I]mplementation";
      }
      {
        mode = "n";
        key = "<leader>lc";
        action.__raw = "vim.lsp.buf.incoming_calls";
        options.desc = "Incoming [C]alls";
      }
      {
        mode = "n";
        key = "<leader>lR";
        action.__raw = "vim.lsp.buf.references";
        options.desc = "[R]eferences";
      }
      {
        mode = "n";
        key = "<leader>lh";
        action.__raw = "function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end";
        options.desc = "Toggle Inlay [H]ints";
      }

      # Diagnostics
      {
        mode = "n";
        key = "<leader>ld";
        action.__raw = "vim.diagnostic.open_float";
        options.desc = "Open floating [d]iagnostic message";
      }
      {
        mode = "n";
        key = "<leader>ll";
        action.__raw = "vim.diagnostic.setloclist";
        options.desc = "Open diagnostics [l]ist in this buffer";
      }
      {
        mode = "n";
        key = "<leader>lD";
        action.__raw = "vim.diagnostic.setqflist";
        options.desc = "Open [D]iagnostics list";
      }

      # Telescope
      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<CR>";
        options.desc = "Find Files";
      }
      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>Telescope live_grep<CR>";
        options.desc = "File Grep";
      }
      {
        mode = "n";
        key = "<leader>fr";
        action = "<cmd>Telescope resume<CR>";
        options.desc = "Find resume";
      }
      {
        mode = "n";
        key = "<leader>fd";
        action = "<cmd>Telescope diagnostics<CR>";
        options.desc = "Find Diagnostics";
      }
      {
        mode = "n";
        key = "<leader>fG";
        action = "<cmd>Telescope git_files<CR>";
        options.desc = "Find Git Files";
      }
      {
        mode = "n";
        key = "gd";
        action = "<cmd>Telescope lsp_definitions<CR>";
        options.desc = "Go to Definition";
      }
      {
        mode = "n";
        key = "gr";
        action = "<cmd>Telescope lsp_references<CR>";
        options.desc = "Go to References";
      }
      {
        mode = "n";
        key = "gI";
        action = "<cmd>Telescope lsp_implementations<CR>";
        options.desc = "Go to Implementations";
      }
      {
        mode = "n";
        key = "<leader>gt";
        action = "<cmd>Telescope lsp_type_definitions<CR>";
        options.desc = "Go to Type Definitions";
      }
      {
        mode = "n";
        key = "<leader>ls";
        action = "<cmd>Telescope lsp_document_symbols<CR>";
        options.desc = "Symbols";
      }
      {
        mode = "n";
        key = "<leader>lS";
        action = "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>";
        options.desc = "Workspace Symbols";
      }

      # Undotree
      {
        mode = "n";
        key = "<leader>u";
        action = "<cmd>UndotreeToggle<CR>";
        options.desc = "UndoTree";
      }

      # Oil additional
      {
        mode = "n";
        key = "-";
        action = "<cmd>Oil<CR>";
        options.desc = "Open parent directory";
      }

      # Neogit and other git stuff
      {
        mode = "n";
        key = "<leader>gg";
        action = "<cmd>Neogit<CR>";
        options = {
          desc = "Open Neogit";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>gc";
        action = "<cmd>Neogit commit<CR>";
        options = {
          desc = "Neogit Commit";
          silent = true;
        };
      }

      {
        mode = "v"; # 'v' for visual mode selection
        key = "<leader>gs";
        action = "<cmd>Gitsigns stage_hunk<CR>";
        options.desc = "Stage Selected Lines";
      }

      # Tab management
      {
        mode = "n";
        key = "<leader>tc";
        action = "<cmd>tabclose<CR>";
        options = {
          desc = "[T]ab [C]lose";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>tn";
        action = "<cmd>tabn<CR>";
        options = {
          desc = "[T]ab [N]ext";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>tp";
        action = "<cmd>tabp<CR>";
        options = {
          desc = "[T]ab [P]revious";
          silent = true;
        };
      }

      # DAP - Debugging
      {
        mode = "n";
        key = "<leader>db";
        action.__raw = "require('dap').toggle_breakpoint";
        options.desc = "Toggle [B]reakpoint";
      }
      {
        mode = "n";
        key = "<F9>";
        action.__raw = "require('dap').toggle_breakpoint";
        options.desc = "Toggle Breakpoint";
      }
      {
        mode = "n";
        key = "<leader>dB";
        action.__raw = "function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end";
        options.desc = "Breakpoint with condition";
      }
      {
        mode = "n";
        key = "<leader>dc";
        action.__raw = "require('dap').continue";
        options.desc = "[C]ontinue";
      }
      {
        mode = "n";
        key = "<F5>";
        action.__raw = "require('dap').continue";
        options.desc = "Continue";
      }
      {
        mode = "n";
        key = "<leader>di";
        action.__raw = "require('dap').step_into";
        options.desc = "Step [I]nto";
      }
      {
        mode = "n";
        key = "<F11>";
        action.__raw = "require('dap').step_into";
        options.desc = "Step Into";
      }
      {
        mode = "n";
        key = "<leader>do";
        action.__raw = "require('dap').step_over";
        options.desc = "Step [O]ver";
      }
      {
        mode = "n";
        key = "<F10>";
        action.__raw = "require('dap').step_over";
        options.desc = "Step Over";
      }
      {
        mode = "n";
        key = "<leader>dO";
        action.__raw = "require('dap').step_out";
        options.desc = "Step O[u]t";
      }
      {
        mode = "n";
        key = "<S-F11>";
        action.__raw = "require('dap').step_out";
        options.desc = "Step Out";
      }
      {
        mode = "n";
        key = "<leader>dr";
        action.__raw = "require('dap').repl.open";
        options.desc = "Open [R]EPL";
      }
      {
        mode = "n";
        key = "<leader>dt";
        action.__raw = "require('dap').terminate";
        options.desc = "[T]erminate";
      }
      {
        mode = "n";
        key = "<leader>du";
        action.__raw = "require('dapui').toggle";
        options.desc = "Toggle DAP [U]I";
      }
      {
        mode = "n";
        key = "<leader>de";
        action.__raw = "require('dapui').eval";
        options.desc = "[E]valuate expression";
      }
      {
        mode = "v";
        key = "<leader>de";
        action.__raw = "require('dapui').eval";
        options.desc = "[E]valuate selection";
      }
    ];

    performance.byteCompileLua.enable = true;
    # ── Plugins ──────────────────────────────────────────────────
    plugins = {
      markdown-preview = {
        enable = true;
        settings = {
          port = "8888";
          echo_preview_url = 1;
        };
      };
      # ── Telescope ──────────────────────────────────────────
      telescope.enable = true;
      # ── GitSigns ──────────────────────────────────────────
      gitsigns = {
        enable = true;
        settings = {
          signcolumn = true;
          current_line_blame = true;
        };
      };

      # ── Neogit ──────────────────────────────────────────
      neogit = {
        enable = true;

        settings = {
          integrations = {
            diffview = true;
          };
          disable_insert_after_commit = false;
        };
      };

      # ── Blink.cmp ──────────────────────────────────────────
      blink-cmp = {
        enable = true;
        settings = {
          keymap = {
            preset = "default";
            "<Tab>" = [
              "select_next"
              "fallback"
            ];
            "<S-Tab>" = [
              "select_prev"
              "fallback"
            ];
            "<CR>" = [
              "accept"
              "fallback"
            ];
          };
          # appearance.nerd_font_variant = "mono";
          completion = {
            documentation.auto_show = false;
            accept.auto_brackets.enabled = true;
          };
          sources.default = [
            "lsp"
            "path"
            "snippets"
            "buffer"
          ];
          signature.enabled = true;
        };
      };

      # ── LSP ────────────────────────────────────────────────
      lsp = {
        enable = true;
        servers = {
          markdown_oxide.enable = true;
          yamlls.enable = true;
          helm_ls.enable = true;
          gitlab_ci_ls.enable = true;
          dockerls.enable = true;
          clangd.enable = true;
          bashls.enable = true;

          nil_ls.enable = true;
          lua_ls.enable = true;
          rust_analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
          ols = {
            enable = true;
          };
          jsonls.enable = true;
          gopls = {
            enable = true;
            settings.gopls.hints = {
              assignVariableTypes = true;
              compositeLiteralFields = true;
              compositeLiteralTypes = true;
              constantValues = true;
              functionTypeParameters = true;
              ignoredError = true;
              parameterNames = true;
              rangeVariableTypes = true;
            };
          };
          html = {
            enable = true;
            filetypes = [
              "html"
              "templ"
            ];
          };
          tailwindcss = {
            enable = true;
            filetypes = [
              "html"
              "templ"
              "javascriptreact"
              "typescriptreact"
              "vue"
              "svelte"
            ];
            extraOptions.init_options.userLanguages.templ = "html";
          };
        };
        inlayHints = false;
      };

      # ── Treesitter ─────────────────────────────────────────
      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          bash
          css
          go
          gomod
          gowork
          html
          json
          lua
          markdown
          nix
          odin
          python
          rust
          regex
          toml
          yaml
          javascript
          latex
          scss
          svelte
          templ
          tsx
          typst
          vue
        ];
      };

      # ── Lualine ────────────────────────────────────────────
      lualine = {
        enable = true;
        settings = {
          options = {
            icons_enabled = true;
            theme = "onedark";
            component_separators = {
              left = "";
              right = "";
            };
            section_separators = {
              left = "";
              right = "";
            };
          };
          sections = {
            lualine_a = [ "mode" ];
            lualine_b = [
              "branch"
              "diff"
              "diagnostics"
            ];
            lualine_c = [
              {
                __unkeyed = "filename";
                path = 4;
              }
            ];
            lualine_x = [
              "encoding"
              "fileformat"
              "filetype"
            ];
            lualine_y = [ "progress" ];
            lualine_z = [ "location" ];
          };
        };
      };

      # ── Which-key ──────────────────────────────────────────
      which-key = {
        enable = true;
        settings.spec = [
          {
            __unkeyed = "<leader>f";
            group = "Find";
          }
          {
            __unkeyed = "<leader>t";
            group = "Tabs";
          }
          {
            __unkeyed = "<leader>l";
            group = "LSP";
          }
          {
            __unkeyed = "<leader>g";
            group = "Goto";
          }
          {
            __unkeyed = "<leader>a";
            group = "AI✨";
          }
          {
            __unkeyed = "<leader>d";
            group = "Debug";
          }
        ];
      };

      # ── Snacks ─────────────────────────────────────────────
      snacks = {
        enable = true;
        settings = {
          indent.enabled = true;
          image.enabled = false;
          input.enabled = true;
          picker.enabled = true;
          quickfile.enabled = true;
        };
      };

      # ── Oil ────────────────────────────────────────────────
      oil = {
        enable = true;
        settings = {
          default_file_explorer = true;
          view_options.show_hidden = true;
        };
      };

      # ── Nvim-surround ──────────────────────────────────────
      nvim-surround.enable = true;

      # ── Copilot ────────────────────────────────────────────
      copilot-lua = {
        enable = true;
        settings = {
          suggestion = {
            auto_trigger = true;
            keymap = {
              accept = "<C-j>";
              dismiss = "<M-j>";
            };
          };
        };
      };

      # ── Undotree ───────────────────────────────────────────
      undotree.enable = true;

      # ── Diffview ───────────────────────────────────────────
      diffview.enable = true;

      # ── Todo-comments ──────────────────────────────────────
      todo-comments = {
        enable = true;
        keymaps.todoTelescope.key = "<leader>ft";
      };

      # ── Web-devicons ───────────────────────────────────────
      web-devicons.enable = true;

      # ── autpairs ───────────────────────────────────────
      nvim-autopairs = {
        enable = true;
        settings = {
          check_ts = true;
        };
      };

      dap = {
        enable = true;
        signs = {
          dapBreakpoint = {
            text = "🔴";
            texthl = "DiagnosticError";
            numhl = "DiagnosticError";
          };
          dapBreakpointCondition = {
            text = "🟡";
            texthl = "DiagnosticWarn";
            numhl = "DiagnosticWarn";
          };
          dapStopped = {
            text = "▶️";
            texthl = "DiagnosticOk";
            linehl = "Visual";
            numhl = "DiagnosticOk";
          };
          dapBreakpointRejected = {
            text = "⭕";
            texthl = "Comment";
            numhl = "Comment";
          };
        };
      };
      dap-go.enable = true;
      dap-lldb = {
        enable = true;
        settings.codelldb_path = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
      };
      dap-ui = {
        enable = true;
      };

    };

    # ── Extra Plugins (no native nixvim module) ───────────────────
    extraPlugins = with pkgs.vimPlugins; [
      nvim-highlight-colors
      nvim-lightbulb
      vim-wakatime
      render-markdown-nvim
      typst-preview-nvim
      image-nvim
    ];

    # ── Extra Lua Config ──────────────────────────────────────────
    extraConfigLuaPre = ''
      -- Inlay hints off by default
      vim.lsp.inlay_hint.enable(false)

      -- Filetype mappings
      vim.filetype.add({
        extension = { templ = "templ" },
        filename = { ["Tiltfile"] = "starlark" },
      })

      -- Diagnostics
      vim.diagnostic.config({ virtual_text = true })

      -- Custom command: Shrug
      vim.api.nvim_create_user_command("Shrug", function()
        vim.api.nvim_put({ "¯\\_(ツ)_/¯" }, "c", true, true)
      end, {})

      -- Neovide
      if vim.g.neovide then
        vim.o.guifont = "FiraCode Nerd Font:h11"
      end

      -- image.nvim (only on non-WSL)
      if vim.fn.getenv("WSL_DISTRO_NAME") == vim.NIL then
        local ok_img, image = pcall(require, "image")
        if ok_img then
          image.setup()
        end
      end

      -- nvim-highlight-colors
      require("nvim-highlight-colors").setup({
        render = "background",
        enable_tailwind = true,
      })

      -- nvim-lightbulb
      require("nvim-lightbulb").setup({
        autocmd = { enabled = true },
        sign = { enabled = false },
        virtual_text = {
          enabled = true,
          text = "💡",
          pos = "eol",
          hl = "LightBulbVirtualText",
          hl_mode = "combine",
        },
      })
    '';
  };
  };
}
