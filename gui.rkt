#lang racket/gui
(require racket/trace)
(require racket/gui/base)
(require "Trab1.rkt")

(disableConsole)

; ============ Layout Geral ============
; Define o Frame
(define frame
    (new frame%
        [label "GJ Book"]
        [width 800]
        [height 600]
    )
)

; Divisor vertical geral
(define vert-panel1
    (new vertical-panel%
        [parent frame]
    )

)

; Perfil
(define prof-panel
    (new horizontal-panel%
        [parent vert-panel1]
        [alignment '(left top)]
    )
)

; Divisor horizontal
(define horiz-panel
    (new horizontal-panel%	 
   	 	[parent vert-panel1]
        [alignment '(left top)]
    )
)

; Área de ignorados
(define ignore-panel
    (new vertical-panel%
        [parent horiz-panel]
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
        [stretchable-width 100]
        [style '(vscroll)]
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
(new message%
    [parent prof-panel]
    [label nome]
)

; ============== Ignorados ==============
(define autor-ignorado
    (new list-box%
        [parent ignore-panel]
        [label "Autores Ignorados\n"]
        [choices autorIgnorado]
    )
)

(new button%
    [parent ignore-panel]
    [label "✓"]
    [callback (λ (button event) (designorarAutor (send autor-ignorado get-data (car (send autor-ignorado get-selections)))) (listar))]
)

(define cat-ignorada
    (new list-box%
        [parent ignore-panel]
        [label "Categorias Ignoradas"]
        [choices catIgnorada]
    )
)

(new button%
    [parent ignore-panel]
    [label "✓"]
    [callback (λ (button event) (designorarCat (send cat-ignorada get-data (car (send cat-ignorada get-selections)))) (listar))]
)

; ============== Postar =================
; Nova mensagem
(define msg
    (new text-field%
        [parent post-panel]
        [label "Mensagem"]
        [style '(multiple)]
    )
)

(new button%
    [parent post-panel]
    [label "Postar"]
    [callback (λ (button event) (cria-post (send msg get-value)))]
)

; ============ Timeline =================
; Nova mensagem
(define (cria-post post)
    (postar post)
    (listar)
)

; Listar posts
(define (listar)
    (send timeline-panel change-children (λ(x) (foldl formata-post-gui '() (getLista posts))))
    (send autor-ignorado set autorIgnorado)
    (send cat-ignorada set catIgnorada)
    (foldl (λ(x acc) (if (void? (send cat-ignorada set-data acc x)) (add1 acc) (add1 acc))) 0 catIgnorada)
    (foldl (λ(x acc) (if (void? (send autor-ignorado set-data acc x)) (add1 acc) (add1 acc))) 0 autorIgnorado)
)

; Formato - GUI
(define (formata-post-gui item acc)
    (define p
        (new vertical-panel%
            [parent timeline-panel]
            [style '(border)]
        )
    )
    (define p1
        (new horizontal-panel%
            [parent p]
        )
    )
    (define p2
        (new horizontal-panel%
            [parent p]
        )
    )
    (define p3
        (new horizontal-panel%
            [parent p]
        )
    )
    
    (new message%
        [parent p1]
        [label (autor item)]
    )
    (new button%
        [parent p1]
        [label "🛇"]
        [callback (λ (button event) (ignorarAutor (autor item)) (listar)) ]
    )
    
    (define p11 (new horizontal-panel% [parent p1] [alignment '(right top)]))
    (new message%
        [parent p11]
        [label (number->string (dia item))]
    )

    (new message%
        [parent p2]
        [label (texto item)]
    )

    (new button%
        [parent p3]
        [label (string-join (list "👍 " (number->string (likes item))) "")]
        [callback (λ (button event) (like (id item)) (listar)) ]
    )
    (define p33 (new horizontal-panel% [parent p3] [alignment '(right top)]))
    (if (equal? (categoria item) "Desconhecido")
        ;then
        (new combo-field%
            [parent p33]
            [label ""]
            [init-value "Escolha a Categoria"]
            [choices '("Tecnologia" "Cultura" "História" "Saúde" "Diversão")]
            [callback (λ (button event) (seta-categoria (id item) (send button get-value)) (listar))]
        )
        ; else
        (begin 
            (new message% [parent p33] [label (categoria item)])
            (new button%
                [parent p33]
                [label "🛇"]
                [callback (λ (button event) (ignorarCat (categoria item)) (listar)) ]
            )
            
        )
    )
    (cons p acc)
)


; Inicialização
(send frame show #t)
(listar)