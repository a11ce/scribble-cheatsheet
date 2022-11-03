#lang scribble/manual

@(require 
   (for-label scribble/manual
              racket/base
              racket/list)
   (for-syntax racket/base
               racket/syntax
               syntax/parse
               (prefix-in
                scribble-
                scribble/reader)))

@(define-syntax (selfdoc stx)
   (syntax-parse stx
     [(selfdoc args ...)
      (let* ([string-port (open-input-string
                           (apply string-append
                                  (syntax->datum #'(args ...))))])
        (with-syntax ([(actual-scribble ...)
                       (scribble-read-inside string-port)]
                      [first-arg (car (syntax-e #'(args ...)))]
                      [(code-with-lang ...)
                       (cons "#lang scribble/manual\n" #'(args ...))])
          #'(begin actual-scribble ...
                   (codeblock #:keep-lang-line? #f
                              #:context #'first-arg
                              code-with-lang ...))))]))

@selfdoc|{
  @title[#:tag "scribble-cheatsheet"]{Scribble Cheatsheet}
}|

@selfdoc|{
  @author{a11ce}
}|

@selfdoc|{
  @author[(author+email "Dr. Racket-Emailhaver" "dontemailme@racket-lang.org")]
}|


@selfdoc|{
  @table-of-contents{}
}|


@selfdoc|{
  @section{Section Header}
}|

@selfdoc|{
  @subsection{Subsection Header}
}|

@selfdoc|{
  @subsubsection{Subsubsection header}
}|

@selfdoc|{
  @subsubsub*section{Non-numbered header (doesn't show up in table of contents)}
}|


@section{Documenting code}

Remember that {} converts to a string and [] doesn't.

@subsection{Modules}

@selfdoc|{
  @defmodule[racket/list]
}|

@code{racketblock}s require S-expressions
and normalize terms (including formatting).

@selfdoc|{
  @racketblock[
  (map
  (λ (x)
  (+ 1 x)) '(1 2/4
  3 4 5))
  ]
}|

@subsection[@hash-lang{}]{s}

@selfdoc|{
  @defmodulelang[scribble/manual]
}|

@code{codeblock}s typeset verbatim, allow non-S-expression syntax,
and don't normalize terms.

@selfdoc|{
@codeblock|{
#lang scribble/manual
@italic{me
ow}
}|}|

@subsection{Procedures and Forms}

Names defined with @code{defproc}, @code{defform}, or @code{defthing}
will be linked to from within @code{racket}s.

@subsubsection{Procedures}

@selfdoc|{
  @defproc[#:kind "default is procedure"
           (proc-name [arg arg/c] ...
                      [#:kwarg kwarg-val kwarg/c default])
                      result-type]{
  Within this block, things like @racket[arg] will be typeset to match
  the definition (but will error within @code{code}).
  }
}|

Use @code{defproc*} to describe related procedures or procedures with multiple
calling cases.

@selfdoc|{
  @defproc*[([(multi-proc) result-type-one]
             [(multi-proc (arg arg/c)) result-type-two])]
}|

@subsection{Syntax}

@code{defform} can specify which identifier it's defining,
typeset literals, or include a grammar.

@selfdoc|{
  @defform[#:kind "default is syntax"
           #:id form-name
           #:literals (define)
           (something-special form-name math)
           #:grammar
           [(math (op num num))
            (op plus
                minus)]]
}|

Use @code{defform*} for multiple forms using the same identifier.

@selfdoc|{
  @defform*[((define (proc-name arg ...) body ...+)
             (define var-name body))]
}|

@subsection{Others}

Use @code{defthing} to describe non-procedure identifiers.

@selfdoc|{
  @defthing[horse animal?]{
  Everyone knows what a horse is.
  }
}|

Use @code{deftech} to define vocabulary and @code{tech}
to link to it.

@selfdoc|{
  A @deftech{technical term} is a term that is technical.
  An example of a @tech{technical term} is
  @tech[#:doc '(lib "scribblings/guide/guide.scrbl")]{number}.
}|

@section{Formatting}

@selfdoc|{
  @margin-note{Margin note (not actually in the margin)}
}|

@selfdoc|{
  @margin-note*{Margin note* (actually in the margin)}
}|

@selfdoc|{
  @italic{Italic}
}|
@selfdoc|{
  @bold{Bold}
}|
@selfdoc|{
  @italic{@bold{woah nesting}}
}|

More: @code{subscript}, @code{subscript}, @code{larger}, @code{smaller}.

@selfdoc|{
  @larger{AAA@larger{AAA@larger{AAA@larger{AAA}}}}
}|


@section{Links}

@selfdoc|{
  @link["https://racket-lang.org"]{normal link}
}|

@selfdoc|{
  @seclink["scribble-cheatsheet"]{back to top (section link within the same module)}
}|

@selfdoc|{
  @seclink["first-example" #:doc '(lib "scribblings/scribble/scribble.scrbl")]{
  use @racket[#:doc] to link somewhere else
  }
}|

@code{secref} is like seclink but you can't change the text:
@selfdoc|{
  @secref["first-example" #:doc '(lib "scribblings/scribble/scribble.scrbl")]
}|

@code{tech} links to a term defined with @code{deftech}:
@selfdoc|{
  @tech{technical term}
}|

@code{other-doc} links to the top of a document:
@selfdoc|{
  @other-doc['(lib "scribblings/scribble/scribble.scrbl")]
}|
