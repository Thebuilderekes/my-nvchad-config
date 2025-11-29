; This file defines how to handle code injections within htmldjango files.
; Crucially, this allows Tree-sitter's structural motions (like ]m and [m)
; to correctly match the HTML tags by ignoring the template delimiters.

; The 'template' grammar is often a generic one used to recognize Jinja/Django
; delimiters if a specific 'django' parser is not available.

; Inject template variable expressions (e.g., {{ user.name }})
(template_variable
(interpolation_start) @template.start
(interpolation_end) @template.end
(expression) @injection.content
(#set! injection.language "python") ; Treat content as Python for basic highlighting/LSP
(#offset! @template.start 0 2) ; Exclude '{{'
(#offset! @template.end 0 -2)  ; Exclude '}}'
)

; Inject template statement expressions (e.g., {% for item in items %})
(template_statement
(statement_start) @template.start
(statement_end) @template.end
(content) @injection.content
(#set! injection.language "python") ; Treat content as Python
(#offset! @template.start 0 2) ; Exclude '{%'
(#offset! @template.end 0 -2)  ; Exclude '%}'
)

; Inject comments (e.g., {# comment #})
(comment) @injection.content
(#set! injection.language "python")
(#offset! @injection.content 0 2) ; Exclude '{#'
(#offset! @injection.content 0 -2) ; Exclude '#}'
