;;; uevil.el --- A minimal implementation of vi emulation in emacs -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2020 Yul3n
;;
;; Author: Yul3n <http://github/Yul3n>
;; Maintainer: Yul3n <yul3n.falx@protonmail.com>
;; Created: August 01, 2020
;; Modified: August 01, 2020
;; Version: 0.0.1
;; Keywords:
;; Homepage: https://github.com/Yul3n/uevil
;; Package-Requires: ((emacs 26.3) (cl-lib "0.5"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;
;;
;;; Code:

(defvar uevil-normal-map (make-sparse-keymap)
  "The keymap of normal state.")
(defvar uevil-insert-map (make-sparse-keymap)
  "The keymap of insert state.")
(defvar uevil-insert-state-p nil
  "Check if uevil is in insert state.")
(defvar uevil-normal-state-p nil
  "Check if uevil is in normal state.")

;;; States:

;; Normal state:
(defun uevil-normal-state ()
  "Set up the uevil normal state AKA \"command state\"."
  (interactive)
  (message "hello")
  (unless uevil-normal-state-p
    (use-local-map uevil-normal-map)
    (read-only-mode)
    (setq uevil-insert-state-p nil)
    (setq uevil-normal-state-p t)))

;; Insert state:
(defun uevil-insert-state ()
  "Set up the uevil insert state."
  (interactive)
  (unless uevil-insert-state-p
    (read-only-mode -1)
    (use-local-map uevil-insert-map)
    (setq uevil-insert-state-p t)
    (setq uevil-normal-state-p nil)))

;;; Keymaps:

;; Normal state:
(define-key uevil-normal-map "i" 'uevil-insert-state)

;; Insert state:
(define-key uevil-insert-map (kbd "<escape>") 'uevil-normal-state)

;;; Main function:
(define-minor-mode uevil-mode
  "A major mode to provide vi-like keybindings."
  :lighter uevil
  (uevil-normal-state))

(provide 'uevil-mode)
;;; uevil.el ends here