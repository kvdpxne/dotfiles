-- lua/options.lua

vim.opt.number = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Ustawienie domyślnego rejestru schowka na systemowy (unnamedplus).
-- Celem jest zintegrowanie wewnętrznego bufora edytora z globalnym schowkiem
-- systemowym, co umożliwia wykonywanie operacji kopiowania (y) i wklejania (p)
-- bezpośrednio pomiędzy Neovim a innymi aplikacjami, bez konieczności
-- ręcznego odwoływania się do rejestru "+".
-- Decyzja o zastosowaniu tego rozwiązania została podjęta w celu uproszczenia
-- przepływu pracy podczas przenoszenia fragmentów kodu. Umożliwia to
-- korzystanie z jednego, wspólnego schowka dla wszystkich operacji.
-- Przyjęto to tymczasowo, na etapie bieżącej konfiguracji środowiska,
-- aby usprawnić wymianę danych między edytorem a zewnętrznymi narzędziami.
vim.opt.clipboard = "unnamedplus"
