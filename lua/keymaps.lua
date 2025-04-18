-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have coliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Para comentar usando la API de nvim
vim.keymap.set('n', '<leader>/', function()
  local count = vim.v.count
  vim.cmd('norm ' .. (count > 0 and count or '') .. 'gcc')
end, { desc = 'Toggle Comment' })

vim.keymap.set('v', '<leader>/', function()
  local count = vim.v.count
  vim.cmd('norm ' .. (count > 0 and count or '') .. 'gcc')
end, { desc = 'Toggle Comment' })

vim.keymap.set('o', '<leader>/', function()
  local count = vim.v.count
  vim.cmd.norm((count > 0 and count or '') .. 'gcc')
end, { desc = 'Toggle Comment' })

vim.keymap.set('x', '<leader>/', function()
  local count = vim.v.count
  vim.cmd.norm((count > 0 and count or '') .. 'gcc')
end, { desc = 'Toggle Comment' })

-- { '<leader>/', group = 'Toggle Comment', mode = { 'n', 'x', 'v' }

-- Para irme al dashboard y poder volver al archivo anterior
--
local original_file = ''

-- Mapeo de líder ; para alternar entre dashboard y archivo original
-- vim.api.nvim_set_keymap('n', '<Leader>;', ':lua ToggleDashboard()<CR>', { noremap = true, silent = true })

function ToggleDashboard()
  -- Si aun nunca fui a un dashboard
  if original_file == '' then
    -- Guarda el archivo actual y abre el dashboard
    original_file = vim.fn.expand '%:p'
    Snacks.dashboard() -- Usar un comando de lua `:lua ... "`
  else -- Hay algo en original file, es decir estoy en un dashboard
    -- Vuelve al archivo original
    vim.cmd('edit ' .. original_file)
    original_file = '' -- Y borro para poder usarla de nuevo
  end
end

------------------- Snacks

-- Uso map mejor
local map = vim.keymap.set

-- Resize window using <ctrl> arrow keys
map('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase Window Height' })
map('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease Window Height' })
map('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease Window Width' })
map('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase Window Width' })

-- Move Lines
map('n', '<A-S-j>', "<cmd>execute 'move .+' . v:count1<cr>==", { desc = 'Move Down' })
map('n', '<A-S-k>', "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = 'Move Up' })
map('i', '<A-S-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move Down' })
map('i', '<A-S-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move Up' })
map('v', '<A-S-j>', ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = 'Move Down' })
map('v', '<A-S-k>', ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = 'Move Up' })

-- buffers
map('n', '<S-h>', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
map('n', '<S-l>', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
map('n', '[b', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
map('n', ']b', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
map('n', '<leader>bb', '<cmd>e #<cr>', { desc = 'Switch to Other Buffer' })
map('n', '<leader>`', '<cmd>e #<cr>', { desc = 'Switch to Other Buffer' })
map('n', '<leader>bd', function()
  Snacks.bufdelete()
end, { desc = 'Delete Buffer' })
map('n', '<leader>bo', function()
  Snacks.bufdelete.other()
end, { desc = 'Delete Other Buffers' })
map('n', '<leader>bD', '<cmd>:bd<cr>', { desc = 'Delete Buffer and Window' })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map('n', 'n', "'Nn'[v:searchforward].'zv'", { expr = true, desc = 'Next Search Result' })
map('x', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next Search Result' })
map('o', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next Search Result' })
map('n', 'N', "'nN'[v:searchforward].'zv'", { expr = true, desc = 'Prev Search Result' })
map('x', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev Search Result' })
map('o', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev Search Result' })

-- better indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- save file
map({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save File' })

--keywordprg
map('n', '<leader>K', '<cmd>norm! K<cr>', { desc = 'Keywordprg' })

-- location list
map('n', '<leader>xl', function()
  local success, err = pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
  if not success and err then
    vim.notify(err, vim.log.levels.ERROR)
  end
end, { desc = 'Location List' })

-- quickfix list
map('n', '<leader>xq', function()
  local success, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
  if not success and err then
    vim.notify(err, vim.log.levels.ERROR)
  end
end, { desc = 'Quickfix List' })

map('n', '[q', vim.cmd.cprev, { desc = 'Previous Quickfix' })
map('n', ']q', vim.cmd.cnext, { desc = 'Next Quickfix' })

-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go { severity = severity }
  end
end
map('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Line Diagnostics' })
map('n', ']d', diagnostic_goto(true), { desc = 'Next Diagnostic' })
map('n', '[d', diagnostic_goto(false), { desc = 'Prev Diagnostic' })
map('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = 'Next Error' })
map('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = 'Prev Error' })
map('n', ']w', diagnostic_goto(true, 'WARN'), { desc = 'Next Warning' })
map('n', '[w', diagnostic_goto(false, 'WARN'), { desc = 'Prev Warning' })

-- -- toggle options
-- Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>us'
-- Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>uw'
-- Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>uL'
-- Snacks.toggle.diagnostics():map '<leader>ud'
-- Snacks.toggle.line_number():map '<leader>ul'
-- Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = 'Conceal Level' }):map '<leader>uc'
-- Snacks.toggle.option('showtabline', { off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2, name = 'Tabline' }):map '<leader>uA'
-- Snacks.toggle.treesitter():map '<leader>uT'
-- Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map '<leader>ub'
-- Snacks.toggle.dim():map '<leader>uD'
-- Snacks.toggle.animate():map '<leader>ua'
-- Snacks.toggle.indent():map '<leader>ug'
-- Snacks.toggle.scroll():map '<leader>uS'
-- Snacks.toggle.profiler():map '<leader>dpp'
-- Snacks.toggle.profiler_highlights():map '<leader>dph'
--
-- -- inlay hints toggle
-- if vim.lsp.inlay_hint then
--   Snacks.toggle.inlay_hints():map '<leader>uh'
-- end
--
-- -- lazygit
-- if vim.fn.executable 'lazygit' == 1 then
--   map('n', '<leader>gg', function()
--     Snacks.lazygit { cwd = LazyVim.root.git() }
--   end, { desc = 'Lazygit (Root Dir)' })
--   map('n', '<leader>gG', function()
--     Snacks.lazygit()
--   end, { desc = 'Lazygit (cwd)' })
--   map('n', '<leader>gf', function()
--     Snacks.picker.git_log_file()
--   end, { desc = 'Git Current File History' })
--   map('n', '<leader>gl', function()
--     Snacks.picker.git_log { cwd = LazyVim.root.git() }
--   end, { desc = 'Git Log' })
--   map('n', '<leader>gL', function()
--     Snacks.picker.git_log()
--   end, { desc = 'Git Log (cwd)' })
-- end
--
-- map('n', '<leader>gb', function()
--   Snacks.picker.git_log_line()
-- end, { desc = 'Git Blame Line' })
-- map({ 'n', 'x' }, '<leader>gB', function()
--   Snacks.gitbrowse()
-- end, { desc = 'Git Browse (open)' })
-- map({ 'n', 'x' }, '<leader>gY', function()
--   Snacks.gitbrowse {
--     open = function(url)
--       vim.fn.setreg('+', url)
--     end,
--     notify = false,
--   }
-- end, { desc = 'Git Browse (copy)' })

-- quit
map('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit All' })

-- highlights under cursor
map('n', '<leader>ui', vim.show_pos, { desc = 'Inspect Pos' })
map('n', '<leader>uI', function()
  vim.treesitter.inspect_tree()
  vim.api.nvim_input 'I'
end, { desc = 'Inspect Tree' })

-- LazyVim Changelog
map('n', '<leader>L', function()
  LazyVim.news.changelog()
end, { desc = 'LazyVim Changelog' })

-- floating terminal
-- map('n', '<leader>fT', function()
--   Snacks.terminal()
-- end, { desc = 'Terminal (cwd)' })
-- map('n', '<leader>ft', function()
--   Snacks.terminal(nil, { cwd = LazyVim.root() })
-- end, { desc = 'Terminal (Root Dir)' })
-- map('n', '<c-/>', function()
--   Snacks.terminal(nil, { cwd = LazyVim.root() })
-- end, { desc = 'Terminal (Root Dir)' })
-- map('n', '<c-_>', function()
--   Snacks.terminal(nil, { cwd = LazyVim.root() })
-- end, { desc = 'which_key_ignore' })

-- Terminal Mappings
map('t', '<C-/>', '<cmd>close<cr>', { desc = 'Hide Terminal' })
map('t', '<c-_>', '<cmd>close<cr>', { desc = 'which_key_ignore' })

-- windows
map('n', '<leader>-', '<C-W>s', { desc = 'Split Window Below', remap = true })
map('n', '<leader>|', '<C-W>v', { desc = 'Split Window Right', remap = true })
map('n', '<leader>wd', '<C-W>c', { desc = 'Delete Window', remap = true })
-- Snacks.toggle.zoom():map('<leader>wm'):map '<leader>uZ'
-- Snacks.toggle.zen():map '<leader>uz'
--
-- tabs
map('n', '<leader><tab>l', '<cmd>tablast<cr>', { desc = 'Last Tab' })
map('n', '<leader><tab>o', '<cmd>tabonly<cr>', { desc = 'Close Other Tabs' })
map('n', '<leader><tab>f', '<cmd>tabfirst<cr>', { desc = 'First Tab' })
map('n', '<leader><tab><tab>', '<cmd>tabnew<cr>', { desc = 'New Tab' })
map('n', '<leader><tab>]', '<cmd>tabnext<cr>', { desc = 'Next Tab' })
map('n', '<leader><tab>d', '<cmd>tabclose<cr>', { desc = 'Close Tab' })
map('n', '<leader><tab>[', '<cmd>tabprevious<cr>', { desc = 'Previous Tab' })

-- vim: ts=2 sts=2 sw=2 et
