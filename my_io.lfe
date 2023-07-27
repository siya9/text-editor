(defmodule my-io
  (export (format 2)))

(defun format (FormatStr Args)
  (io_lib:format FormatStr Args))

