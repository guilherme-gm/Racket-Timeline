#lang racket/gui
(require racket/gui/base)

; ============ Layout Geral ============
; Define o Frame
(define frame
    (new frame%
        [label "GJ Book"]
        [width 800]
        [height 600]
    )
)

; Divisor horizontal
(define horiz-panel
    (new horizontal-panel%	 
   	 	[parent frame]
        [alignment '(left top)]
    )
)

; Perfil
(define prof-panel
    (new vertical-panel%
        [parent horiz-panel]
        [alignment '(left top)]
    )
)

; Área de conteúdo
(define cont-panel
    (new vertical-panel%
        [parent horiz-panel]
    )
)

; Postar
(define post-panel
    (new vertical-panel%
        [parent cont-panel]
        [alignment '(right top)]
    )
)

; Timeline
(define timeline-panel
    (new vertical-panel%
        [parent cont-panel]
        [min-height 450]
    )
)

; =============== Perfil ================
(define prof-horiz
    (new panel%
        [parent prof-panel]
        [alignment '(left top)]
    )
)
(new message%
    [parent prof-panel]
    [label "👨"]
)
(new text-field%
    [parent prof-panel]
    [label ""]
    [init-value "John Doe"]
)

; ============== Postar =================
; Nova mensagem
(new text-field%
    [parent post-panel]
    [label "Mensagem"]
    [style '(multiple)]
)
(new button%
    [parent post-panel]
    [label "Postar"]
)

; ============ Timeline =================
; Nova mensagem
(define post)
(new message%
    [parent timeline-panel]
    [label "Mensagem"]
)
(new message%
    [parent timeline-panel]
    [label "Mensagem"]
)
(new message%
    [parent timeline-panel]
    [label "Mensagem"]
)
(new message%
    [parent timeline-panel]
    [label "Mensagem"]
)
(new message%
    [parent timeline-panel]
    [label "Mensagem"]
)
(new message%
    [parent timeline-panel]
    [label "Mensagem"]
)

(send frame show #t)