# iso-oem - set up display for Latin 1 using an OEM (MS-DOS) font

*Author:* Anders Lindgren<br>
*Version:* 1.0.1<br>
*URL:* [https://github.com/Lindydancer/iso-oem](https://github.com/Lindydancer/iso-oem)<br>

This package sets up the display to show Latin 1 (ISO 8859/1)
characters using an OEM font, i.e. a plain MS-DOS font.

## Usage

Place this file somewhere in Emacs load path and place the
following line in an appropriate init file, e.g. "~/.emacs".

        (require 'iso-oem)
        (standard-display-iso-oem)

The following, more complex code, should conditionally enable this
when an oem font with a standard naming scheme is used:

        (let ((font (cdr-safe (assq 'font (frame-parameters)))))
          (if (and font
                   (or (string-match "-oem-$" font)
                       (string-match "-ms_oemlatin$" font)
                       (string-match "-ms_oemlatin_8$" font)))
              (standard-display-iso-oem)))

Unfortunately, this package modified the global display table.
Hence, it's not possible to mix an oem font and a corrently encoded
Latin 1 font.

Make sure that `standard-display-european` is not called after this
file has been loaded.

See `iso-syntax` (in the standard Emacs distribution) for a syntax
table for Latin 1.

## Emacs version compatibility

This is guaranteed to be compatible with Emacs 22. This is the
version I use under Windows, as later Emacs versions have severe
performance problems.

## Note

This package is NOT designed to be used to edit OEM (ms-dos) files.
Unfortunately, I don't know of any package that provides the
necessary syntax and display tables.


---
Converted from `iso-oem.el` by [*el2markup*](https://github.com/Lindydancer/el2markdown).
