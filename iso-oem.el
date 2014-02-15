;;; iso-oem.el -- set up display for Latin 1 using an OEM (MS-DOS) font

;; Copyright (C) 1997-1998,2014 Anders Lindgren.

;; Author: Anders Lindgren
;; Created: 1997-12-31
;; Version: 1.0.1
;; URL: https://github.com/Lindydancer/iso-oem

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; This package sets up the display to show Latin 1 (ISO 8859/1)
;; characters using an OEM font, i.e. a plain MS-DOS font.

;; Usage:
;;
;; Place this file somewhere in Emacs load path and place the
;; following line in an appropriate init file, e.g. "~/.emacs".
;;
;;     (require 'iso-oem)
;;     (standard-display-iso-oem)
;;
;; The following, more complex code, should conditionally enable this
;; when an oem font with a standard naming scheme is used:
;;
;;     (let ((font (cdr-safe (assq 'font (frame-parameters)))))
;;       (if (and font
;;                (or (string-match "-oem-$" font)
;;                    (string-match "-ms_oemlatin$" font)
;;                    (string-match "-ms_oemlatin_8$" font)))
;;           (standard-display-iso-oem)))
;;
;; Unfortunately, this package modified the global display table.
;; Hence, it's not possible to mix an oem font and a corrently encoded
;; Latin 1 font.

;;
;; Make sure that `standard-display-european' is not called after this
;; file has been loaded.
;;
;; See `iso-syntax' (in the standard Emacs distribution) for a syntax
;; table for Latin 1.

;; Emacs version compatibility:
;;
;; This is guaranteed to be compatible with Emacs 22. This is the
;; version I use under Windows, as later Emacs versions have severe
;; performance problems.

;; Note:
;;
;; This package is NOT designed to be used to edit OEM (ms-dos) files.
;; Unfortunately, I don't know of any package that provides the
;; necessary syntax and display tables.

;;; Code:

(require 'disp-table)

(defvar iso-oem-alist
  '((146 . "'")     ; apostrophe (used by Windows)
    (160 . " ")     ; NBSP (no-break space)
    (161 . 173)     ; inverted exclamation mark
    (162 . 189)     ; cent sign
    (163 . 156)     ; pound sign
    (164 . 207)     ; general currency sign
    (165 . 190)     ; yen sign
    (166 . 221)     ; broken vertical line
    (167 . 245)     ; section sign
    (168 . 249)     ; diaeresis
    (169 . 184)     ; copyright sign
    (170 . 166)     ; ordinal indicator, feminine
    (171 . 174)     ; left angle quotation mark
    (172 . 170)     ; not sign
    (173 . "-")     ; soft hyphen
    (174 . 169)     ; registered sign
    (175 . 238)     ; macron
    (176 . 248)     ; degree sign
    (177 . 241)     ; plus or minus sign
    (178 . 253)     ; superscript two
    (179 . 252)     ; superscript three
    (180 . 239)     ; acute accent
    (181 . 230)     ; micro sign
    (182 . 244)     ; pilcrow
    (183 . 250)     ; middle dot
    (184 . 247)     ; cedilla
    (185 . 251)     ; superscript one
    (186 . 167)     ; ordinal indicator, masculine
    (187 . 175)     ; right angle quotation mark
    (188 . 172)     ; fraction one-quarter
    (189 . 171)     ; fraction one-half
    (190 . 243)     ; fraction three-quarters
    (191 . 168)     ; inverted question mark
    (192 . 183)     ; A with grave accent
    (193 . 181)     ; A with acute accent
    (194 . 182)     ; A with circumflex accent
    (195 . 199)     ; A with tilde
    (196 . 142)     ; A with diaeresis or umlaut mark
    (197 . 143)     ; A with ring
    (198 . 146)     ; AE diphthong
    (199 . 128)     ; C with cedilla
    (200 . 212)     ; E with grave accent
    (201 . 144)     ; E with acute accent
    (202 . 210)     ; E with circumflex accent
    (203 . 211)     ; E with diaeresis or umlaut mark
    (204 . 222)     ; I with grave accent
    (205 . 214)     ; I with acute accent
    (206 . 215)     ; I with circumflex accent
    (207 . 216)     ; I with diaeresis or umlaut mark
    (208 . 209)     ; D with stroke, Icelandic eth
    (209 . 165)     ; N with tilde
    (210 . 227)     ; O with grave accent
    (211 . 224)     ; O with acute accent
    (212 . 226)     ; O with circumflex accent
    (213 . 228)     ; O with tilde
    (214 . 153)     ; O with diaeresis or umlaut mark
    (215 . 158)     ; multiplication sign
    (216 . 157)     ; O with slash
    (217 . 235)     ; U with grave accent
    (218 . 233)     ; U with acute accent
    (219 . 234)     ; U with circumflex accent
    (220 . 154)     ; U with diaeresis or umlaut mark
    (221 . 237)     ; Y with acute accent
    (222 . 232)     ; capital thorn, Icelandic
    (223 . 225)     ; small sharp s, German
    (224 . 133)     ; a with grave accent
    (225 . 160)     ; a with acute accent
    (226 . 131)     ; a with circumflex accent
    (227 . 198)     ; a with tilde
    (228 . 132)     ; a with diaeresis or umlaut mark
    (229 . 134)     ; a with ring
    (230 . 145)     ; ae diphthong
    (231 . 135)     ; c with cedilla
    (232 . 138)     ; e with grave accent
    (233 . 130)     ; e with acute accent
    (234 . 136)     ; e with circumflex accent
    (235 . 137)     ; e with diaeresis or umlaut mark
    (236 . 141)     ; i with grave accent
    (237 . 161)     ; i with acute accent
    (238 . 140)     ; i with circumflex accent
    (239 . 139)     ; i with diaeresis or umlaut mark
    (240 . 208)     ; d with stroke, Icelandic eth
    (241 . 164)     ; n with tilde
    (242 . 149)     ; o with grave accent
    (243 . 162)     ; o with acute accent
    (244 . 147)     ; o with circumflex accent
    (245 . 228)     ; o with tilde
    (246 . 148)     ; o with diaeresis or umlaut mark
    (247 . 246)     ; division sign
    (248 . 155)     ; o with slash
    (249 . 151)     ; u with grave accent
    (250 . 163)     ; u with acute accent
    (251 . 150)     ; u with circumflex accent
    (252 . 129)     ; u with diaeresis or umlaut mark
    (253 . 236)     ; y with acute accent
    (254 . 231)     ; small thorn, Icelandic
    (255 . 152)))   ; small y with diaeresis or umlaut mark


;; I have, on purpose, not made this into a toggle function (like
;; `standard-display-european') since I don't know what I should
;; toggle back to; ASCII, Pure Latin 1, or OEM.
;;
;; About the namimg of the functions; I decided to not name the
;; function `standard-display-oem' since that name would better suit a
;; function that would set up a pure OEM display table.

;;###autoload
(defun standard-display-iso-oem ()
  "Set up the display to show Latin 1 characters using an oem (ms-dos) font."
  (interactive)
  (let ((lst iso-oem-alist)
        (meta (logand ?д #xff00)))
    (while lst
      (let ((pair (car lst)))
	(standard-display-ascii
         (logior meta (car pair))
         (if (numberp (cdr pair))
             (char-to-string (cdr pair))
           (cdr pair))))
      (setq lst (cdr lst)))))


;; Note: Untested...
(defun standard-display-iso-oem-selected-frame ()
  (interactive)
  (make-variable-frame-local 'standard-display-table)
  (let ((standard-display-table (copy-sequence standard-display-table)))
    (standard-display-iso-oem)
    (set-frame-parameter (selected-frame)
                         'standard-display-table standard-display-table)))

;;; едцедцедц
(provide 'iso-oem)

;; iso-oem.el ends here
