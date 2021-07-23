;;; luka-mode.el --- Major mode for editing luka files -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2020 Oran Simhony
;;
;; Author: Oran Simhony <oran.simhony@gmail.com>
;; Maintainer: Oran Simhony <oran.simhony@gmail.com>
;; Created: August 28, 2020
;; Modified: December 9, 2020
;; Version: 0.0.1
;; Keywords: languages luka luka-lang
;; Homepage: https://github.com/luka-lang/luka-mode
;; Package-Requires: ((emacs 27.1) (cl-lib "0.5"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Luka mode is a major mode for editing luka source files.
;;  Luka mode highlights luka source files based on the syntax of the Luka language.
;;
;;; Code:

(setq luka-font-lock-keywords
      (let* (
             (x-keywords '("fn" "return" "if" "else" "let" "mut" "extern" "while" "break" "as" "struct" "enum" "import" "type" "defer"))
             (x-types '("int" "string" "void" "float" "double" "char" "any" "bool" "s8" "s16" "s32" "s64" "u8" "u16" "u32" "u64" "f32" "f64"))
             (x-constants '("null" "true" "false"))
             (x-events '())
             (x-functions '())

             (x-keywords-regexp (regexp-opt x-keywords 'symbols))
             (x-types-regexp (regexp-opt x-types 'symbols))
            (x-constants-regexp (regexp-opt x-constants 'symbols))
            (x-events-regexp (regexp-opt x-events 'symbols))
            (x-functions-regexp (regexp-opt x-functions 'symbols)))

        `(
          (,x-constants-regexp . font-lock-constant-face)
          (,x-events-regexp . font-lock-builtin-face)
          (,x-functions-regexp . font-lock-function-name-face)
          ("@[A-Za-z_][A-Za-z0-9_]*" . font-lock-builtin-face)
          (,x-keywords-regexp . font-lock-keyword-face)
          (,x-types-regexp . font-lock-type-face)
          ("[A-Za-z_][A-Za-z0-9_]*" . font-lock-variable-name-face)
          ;; note: order above matters, because once colored, that part won't change.
          ;; in general, put longer words first
          )))

;;;###autoload
(define-derived-mode luka-mode c-mode "luka mode"
  "Major mode for editing luka source files"

  ;; code for syntax highlighting
  (setq font-lock-defaults '((luka-font-lock-keywords))))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.luka\\'" . luka-mode))

(provide 'luka-mode)
;;; luka-mode.el ends here
