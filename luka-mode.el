;;; luka-mode.el --- Major mode for editing luka files -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2020 Oran Simhony
;;
;; Author: Oran Simhony <oran.simhony@gmail.com>
;; Maintainer: Oran Simhony <oran.simhony@gmail.com>
;; Created: August 28, 2020
;; Modified: July 23, 2021
;; Version: 0.0.1
;; Keywords: languages, luka, luka-lang
;; Homepage: https://github.com/luka-lang/luka-mode
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Luka mode is a major mode for editing luka source files.
;;  Luka mode highlights luka source files based on the syntax of the Luka language.
;;
;;; Code:

(defgroup luka nil
  "Support for Luka code."
  :group 'languages)

(defcustom luka-ident-offset 4
  "Number of spaces for Luka code indenetation."
  :type 'integer
  :group 'luka
  :safe #'integerp)

(defconst luka-keywords
  '("fn" "return" "if" "else" "let" "mut" "extern" "while" "break"
    "as" "struct" "enum" "import" "type" "defer"))

(defconst luka-types
  '("int" "string" "void" "float" "double" "char" "any" "bool"
    "s8" "s16" "s32" "s64" "u8" "u16" "u32" "u64"
    "f32" "f64"))

(defconst luka-constants
  '("null" "true" "false"))

(defconst luka-re-identifier "[[:word:]_][[:word:]_[:digit:]]*")

(defvar luka-font-lock-keywords
  (append
   `(
     (,(concat "@" luka-re-identifier) . font-lock-builtin-face)
     (,(regexp-opt luka-keywords 'symbols) . font-lock-keyword-face)
     (,(regexp-opt luka-constants 'symbols) . font-lock-constant-face)
     (,(regexp-opt luka-types 'symbols) . font-lock-type-face))))

(defconst luka-mode-syntax-table
  (let ((table (make-syntax-table)))
    (dolist (i '(?+ ?- ?* ?/ ?% ?& ?= ?! ?< ?>))
      (modify-syntax-entry i "." table))

    (modify-syntax-entry ?\" "\"" table)
    (modify-syntax-entry ?/ ". 12" table)
    (modify-syntax-entry ?\n ">" table)
    table))

(defconst luka-electric-indent-chars
  '(?, ?} ?\) ?\] ?\;))

;;;###autoload
(define-derived-mode luka-mode c-mode "Luka"
  "Major mode for editing luka source files"
  :group 'luka
  :syntax-table luka-mode-syntax-table
  (setq-local comment-start "// ")
  (setq-local comment-end "")
  (setq-local electric-indent-chars
              (append luka-electric-indent-chars
                      (and (boundp 'electric-indent-chars)
                           electric-indent-chars)))
  ;; code for syntax highlighting
  (setq font-lock-defaults '(luka-font-lock-keywords)))


;;;###autoload
(add-to-list 'auto-mode-alist '("\\.luka\\'" . luka-mode))

(provide 'luka-mode)
;;; luka-mode.el ends here
