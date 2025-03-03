lvim.colorscheme = "habamax"
vim.opt.relativenumber = true

vim.g.clipboard = {
    name = 'wl-clipboard',
    copy = {
        ['+'] = 'wl-copy',
        ['*'] = 'wl-copy',
    },
    paste = {
        ['+'] = 'wl-paste --no-newline',
        ['*'] = 'wl-paste --no-newline',
    },
    cache_enabled = 0,
}


-- Горячие клавиши для работы с буферами
vim.keymap.set("n", "<Tab>", ":bnext<CR>")
vim.keymap.set("n", "<S-Tab>", ":bprev<CR>")

-- Настройка Ctrl+S для сохранения
vim.keymap.set("n", "<C-s>", ":w<CR>", { silent = true })  -- В нормальном режиме
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a", { silent = true })  -- В режиме вставки
vim.keymap.set("v", "<C-s>", "<Esc>:w<CR>", { silent = true })  -- В визуальном режиме

-- Копирование
vim.keymap.set("n", "<leader>yf", "va{y", { silent = true })

lvim.plugins = {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
  },
  keys = {
    { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
    { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
    { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
    { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
    { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
  },
  "ThePrimeagen/harpoon",
  "nvim-lua/plenary.nvim",

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter",
  },

  { 'echasnovski/mini.nvim', version = '*' },

{
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      suggestion = {
        enabled = true,  -- Включаем теневой текст
        auto_trigger = true,  -- Автоматическое появление теневого текста
        debounce = 75,  -- Задержка перед отображением
        keymap = {
          accept = "<C-l>",  -- Клавиша для принятия предложения
          next = "<C-j>",    -- Клавиша для перехода к следующему предложению
          prev = "<C-k>",    -- Клавиша для возврата к предыдущему предложению
          dismiss = "<C-h>", -- Клавиша для закрытия предложения
        },
      },
      panel = {
        enabled = false,  -- Отключаем всплывающую панель
      },
    })
  end,
},
}

require("nvim-treesitter.configs").setup({
  textobjects = {
    select = {
      enable = true, -- Включение текстовых объектов
      lookahead = true, -- Автоматически перемещаться к следующему объекту
      keymaps = {
        ["af"] = "@function.outer", -- Вся функция
        ["if"] = "@function.inner", -- Внутреннее содержимое функции
        ["ac"] = "@class.outer",    -- Весь класс
        ["ic"] = "@class.inner",    -- Внутреннее содержимое класса
      },
    },
  },
})


require('mini.ai').setup()
require('mini.comment').setup()
