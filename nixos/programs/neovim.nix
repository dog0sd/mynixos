{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      # LSP servers for DevOps
      terraform-ls              # Terraform
      yaml-language-server      # YAML (K8s, Ansible, Docker Compose)
      docker-compose-language-service
      dockerfile-language-server
      bash-language-server      # Shell scripts
      pyright                   # Python
      gopls                     # Go
      lua-language-server       # Lua (for neovim config)
      nil                       # Nix
      nodePackages.vscode-json-languageserver  # JSON
      helm-ls                   # Helm charts

      # Formatters & Linters
      shfmt                     # Shell formatter
      shellcheck                # Shell linter
      yamllint                  # YAML linter
      hadolint                  # Dockerfile linter
      nixpkgs-fmt               # Nix formatter
      stylua                    # Lua formatter
      black                     # Python formatter
      ruff                      # Python linter
      gofumpt                   # Go formatter
      tflint                    # Terraform linter

      # Tools
      ripgrep                   # For telescope
      fd                        # For telescope
      tree-sitter               # Treesitter CLI
    ];

    plugins = with pkgs.vimPlugins; [
      # Theme
      {
        plugin = rose-pine;
        type = "lua";
        config = ''
          require("rose-pine").setup({
            variant = "main",
            dark_variant = "main",
            dim_inactive_windows = false,
            extend_background_behind_borders = true,
            styles = {
              bold = true,
              italic = true,
              transparency = false,
            },
          })
          vim.cmd("colorscheme rose-pine")
        '';
      }

      # File explorer
      {
        plugin = neo-tree-nvim;
        type = "lua";
        config = ''
          require("neo-tree").setup({
            close_if_last_window = true,
            popup_border_style = "rounded",
            filesystem = {
              filtered_items = {
                visible = true,
                hide_dotfiles = false,
                hide_gitignored = false,
              },
              follow_current_file = { enabled = true },
              use_libuv_file_watcher = true,
            },
            window = {
              position = "left",
              width = 35,
            },
          })
          vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle file explorer" })
        '';
      }
      nvim-web-devicons
      plenary-nvim
      nui-nvim

      # Fuzzy finder
      {
        plugin = telescope-nvim;
        type = "lua";
        config = ''
          local telescope = require("telescope")
          telescope.setup({
            defaults = {
              file_ignore_patterns = { "node_modules", ".git/", ".terraform/" },
              mappings = {
                i = {
                  ["<C-j>"] = "move_selection_next",
                  ["<C-k>"] = "move_selection_previous",
                },
              },
            },
          })
          local builtin = require("telescope.builtin")
          vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
          vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
          vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
          vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
          vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent files" })
          vim.keymap.set("n", "<leader>fc", builtin.git_commits, { desc = "Git commits" })
          vim.keymap.set("n", "<leader>fs", builtin.git_status, { desc = "Git status" })
        '';
      }
      telescope-fzf-native-nvim

      # Treesitter for syntax highlighting
      {
        plugin = nvim-treesitter.withPlugins (p: [
          p.bash
          p.c
          p.cpp
          p.css
          p.dockerfile
          p.go
          p.html
          p.javascript
          p.json
          p.lua
          p.markdown
          p.nix
          p.python
          p.rust
          p.terraform
          p.typescript
          p.yaml
        ]);
        type = "lua";
        config = ''
          require("nvim-treesitter.config").setup({
            highlight = { enable = true },
            indent = { enable = true },
            incremental_selection = {
              enable = true,
              keymaps = {
                init_selection = "<C-space>",
                node_incremental = "<C-space>",
                scope_incremental = false,
                node_decremental = "<bs>",
              },
            },
          })
        '';
      }

      # LSP Configuration (using native vim.lsp.config for Neovim 0.11+)
      nvim-lspconfig  # Still needed for filetype detection and cmd paths

      # Autocompletion
      {
        plugin = nvim-cmp;
        type = "lua";
        config = ''
          local cmp = require("cmp")
          local luasnip = require("luasnip")

          cmp.setup({
            snippet = {
              expand = function(args)
                luasnip.lsp_expand(args.body)
              end,
            },
            mapping = cmp.mapping.preset.insert({
              ["<C-b>"] = cmp.mapping.scroll_docs(-4),
              ["<C-f>"] = cmp.mapping.scroll_docs(4),
              ["<C-Space>"] = cmp.mapping.complete(),
              ["<C-e>"] = cmp.mapping.abort(),
              ["<CR>"] = cmp.mapping.confirm({ select = true }),
              ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                  luasnip.expand_or_jump()
                else
                  fallback()
                end
              end, { "i", "s" }),
              ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                  luasnip.jump(-1)
                else
                  fallback()
                end
              end, { "i", "s" }),
            }),
            sources = cmp.config.sources({
              { name = "nvim_lsp" },
              { name = "luasnip" },
              { name = "buffer" },
              { name = "path" },
            }),
            window = {
              completion = cmp.config.window.bordered(),
              documentation = cmp.config.window.bordered(),
            },
          })
        '';
      }
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      luasnip
      cmp_luasnip
      friendly-snippets

      # Git integration
      {
        plugin = gitsigns-nvim;
        type = "lua";
        config = ''
          require("gitsigns").setup({
            signs = {
              add = { text = "│" },
              change = { text = "│" },
              delete = { text = "_" },
              topdelete = { text = "‾" },
              changedelete = { text = "~" },
            },
            on_attach = function(bufnr)
              local gs = package.loaded.gitsigns
              local opts = { buffer = bufnr }
              vim.keymap.set("n", "]c", gs.next_hunk, opts)
              vim.keymap.set("n", "[c", gs.prev_hunk, opts)
              vim.keymap.set("n", "<leader>hs", gs.stage_hunk, opts)
              vim.keymap.set("n", "<leader>hr", gs.reset_hunk, opts)
              vim.keymap.set("n", "<leader>hp", gs.preview_hunk, opts)
              vim.keymap.set("n", "<leader>hb", function() gs.blame_line({ full = true }) end, opts)
            end,
          })
        '';
      }
      vim-fugitive

      # Status line
      {
        plugin = lualine-nvim;
        type = "lua";
        config = ''
          require("lualine").setup({
            options = {
              theme = "rose-pine",
              component_separators = { left = "", right = "" },
              section_separators = { left = "", right = "" },
            },
            sections = {
              lualine_a = { "mode" },
              lualine_b = { "branch", "diff", "diagnostics" },
              lualine_c = { { "filename", path = 1 } },
              lualine_x = { "encoding", "fileformat", "filetype" },
              lualine_y = { "progress" },
              lualine_z = { "location" },
            },
          })
        '';
      }

      # Which-key for keybinding hints
      {
        plugin = which-key-nvim;
        type = "lua";
        config = ''
          local wk = require("which-key")
          wk.setup({
            plugins = { spelling = { enabled = true } },
          })
          wk.add({
            { "<leader>f", group = "Find" },
            { "<leader>g", group = "Git" },
            { "<leader>h", group = "Hunks" },
            { "<leader>c", group = "Code" },
            { "<leader>t", group = "Terminal" },
            { "<leader>u", group = "UI Toggle" },
          })
        '';
      }

      # Autopairs
      {
        plugin = nvim-autopairs;
        type = "lua";
        config = ''
          require("nvim-autopairs").setup({
            check_ts = true,
          })
        '';
      }

      # Indent guides
      {
        plugin = indent-blankline-nvim;
        type = "lua";
        config = ''
          require("ibl").setup({
            indent = { char = "│" },
            scope = { enabled = true },
          })
        '';
      }

      # Commenting
      {
        plugin = comment-nvim;
        type = "lua";
        config = ''
          require("Comment").setup()
        '';
      }

      # Terminal integration
      {
        plugin = toggleterm-nvim;
        type = "lua";
        config = ''
          require("toggleterm").setup({
            size = 15,
            open_mapping = [[<c-\>]],
            direction = "horizontal",
            shade_terminals = true,
          })

          -- Lazygit integration
          local Terminal = require("toggleterm.terminal").Terminal
          local lazygit = Terminal:new({
            cmd = "lazygit",
            direction = "float",
            float_opts = { border = "rounded" },
            hidden = true,
          })
          vim.keymap.set("n", "<leader>gg", function() lazygit:toggle() end, { desc = "Lazygit" })
        '';
      }

      # Terraform specific
      vim-terraform

      # Additional syntax support
      vim-helm                  # Helm charts
      ansible-vim               # Ansible
      vim-nix                   # Nix
    ];

    initLua = ''
      -- General settings
      vim.g.mapleader = " "
      vim.g.maplocalleader = " "

      -- LSP Configuration (native vim.lsp.config for Neovim 0.11+)
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local has_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
      if has_cmp then
        capabilities = cmp_lsp.default_capabilities(capabilities)
      end

      -- LSP keymaps on attach
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf, noremap = true, silent = true }
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, opts)
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
          vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
        end,
      })

      -- Configure LSP servers using vim.lsp.config (Neovim 0.11+)
      vim.lsp.config["terraformls"] = { capabilities = capabilities }
      vim.lsp.config["tflint"] = { capabilities = capabilities }
      vim.lsp.config["yamlls"] = {
        capabilities = capabilities,
        settings = {
          yaml = {
            schemas = {
              ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
              ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "/*.k8s.yaml",
              ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "/docker-compose*.yml",
            },
            validate = true,
            completion = true,
            hover = true,
          },
        },
      }
      vim.lsp.config["dockerls"] = { capabilities = capabilities }
      vim.lsp.config["docker_compose_language_service"] = { capabilities = capabilities }
      vim.lsp.config["bashls"] = { capabilities = capabilities }
      vim.lsp.config["pyright"] = { capabilities = capabilities }
      vim.lsp.config["gopls"] = { capabilities = capabilities }
      vim.lsp.config["lua_ls"] = {
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      }
      vim.lsp.config["nil_ls"] = {
        capabilities = capabilities,
        settings = {
          ["nil"] = {
            formatting = { command = { "nixpkgs-fmt" } },
          },
        },
      }
      vim.lsp.config["jsonls"] = { capabilities = capabilities }
      vim.lsp.config["helm_ls"] = { capabilities = capabilities }

      -- Enable all configured LSP servers
      vim.lsp.enable({
        "terraformls",
        "tflint",
        "yamlls",
        "dockerls",
        "docker_compose_language_service",
        "bashls",
        "pyright",
        "gopls",
        "lua_ls",
        "nil_ls",
        "jsonls",
        "helm_ls",
      })

      -- Diagnostic configuration
      local signs = { Error = " ", Warn = " ", Hint = "󰌵 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      vim.diagnostic.config({
        virtual_text = { prefix = "●" },
        float = { border = "rounded" },
        severity_sort = true,
      })

      local opt = vim.opt

      -- Line numbers
      opt.number = true
      opt.relativenumber = false

      -- Tabs & Indentation
      opt.tabstop = 2
      opt.shiftwidth = 2
      opt.expandtab = true
      opt.autoindent = true
      opt.smartindent = true

      -- Line wrapping
      opt.wrap = false

      -- Search
      opt.ignorecase = true
      opt.smartcase = true
      opt.hlsearch = true
      opt.incsearch = true

      -- Appearance
      opt.termguicolors = true
      opt.signcolumn = "yes"
      opt.cursorline = true
      opt.scrolloff = 8
      opt.sidescrolloff = 8

      -- Behavior
      opt.splitright = true
      opt.splitbelow = true
      opt.clipboard = "unnamedplus"
      opt.undofile = true
      opt.updatetime = 250
      opt.timeoutlen = 300
      opt.mouse = "a"

      -- Hide command line when not in use
      opt.cmdheight = 1

      -- Completion
      opt.completeopt = "menu,menuone,noselect"

      -- General keymaps
      vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
      vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
      vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

      -- Toggle line wrap
      vim.keymap.set("n", "<leader>uw", function()
        vim.opt.wrap = not vim.opt.wrap:get()
        if vim.opt.wrap:get() then
          print("Wrap ON")
        else
          print("Wrap OFF")
        end
      end, { desc = "Toggle line wrap" })

      -- Window navigation
      vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
      vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
      vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
      vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

      -- Resize windows
      vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
      vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
      vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
      vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

      -- Move lines
      vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
      vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

      -- Better indenting
      vim.keymap.set("v", "<", "<gv")
      vim.keymap.set("v", ">", ">gv")

      -- Buffer navigation (without bufferline)
      vim.keymap.set("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
      vim.keymap.set("n", "<S-Tab>", "<cmd>bprev<cr>", { desc = "Previous buffer" })
      vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })

      -- Diagnostic keymaps
      vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostic list" })

      -- Terraform file detection
      vim.filetype.add({
        extension = {
          tf = "terraform",
          tfvars = "terraform",
        },
      })

      -- YAML file detection for Kubernetes
      vim.filetype.add({
        pattern = {
          [".*%.k8s%.yaml"] = "yaml.kubernetes",
          [".*%.k8s%.yml"] = "yaml.kubernetes",
        },
      })
    '';
  };
}

