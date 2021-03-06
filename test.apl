#!/usr/bin/env apl --script
)COPY 5 FILE_IO.apl

⍝ Clear logfile with given filename.
∇test∆clear_log filename;handle;_
  handle←'w' FIO∆fopen filename
  _←FIO∆fclose handle
∇

⍝ )COPY file relative to current directory.
∇test∆copy_relative path;_
  _←⍎ ')COPY ',test¯pwd,'/',path
∇

⍝ Write logfile with given filename to stderr as UTF-8.
∇test∆show_log filename;cr
  cr←⎕UCS 10
  test¯warn cr,'***** TEST LOG *****',cr,cr
  test¯warn test¯read_unicode filename
∇

⍝ Evaluate APL code (as string).
⍝ Returns 2-element vector:
⍝ [1] Boolean (1 if error, 0 if not).
⍝ [2] Error message if error; original result if not.
∇z←test∆try apl_string;response;is_error;result
  response←⎕EC apl_string
  is_error←0=1⊃response
  result←3⊃response
  →(~is_error)/return
  result←result[1;]
  return: z←is_error result
∇

⍝ private

⍝ Return current directory as a string.
∇pwd←test¯pwd
  pwd←FIO∆getcwd
∇

⍝ Read a UTF-8 file into a Unicode character vector.
∇unicode←test¯read_unicode filename
  unicode←19⎕CR FIO∆read_file filename
∇

⍝ Write string to stderr.
∇test¯warn string;_
  _←FIO∆fprintf_stderr '%s' string
∇
