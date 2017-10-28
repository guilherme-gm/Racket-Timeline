#lang racket
(require racket/trace)

(provide posts)
(provide id)
(provide texto)
(provide autor)
(provide dia)
(provide categoria)
(provide likes)
(provide getLista)
(provide postar)
(provide like)
(provide seta-categoria)
(provide ignorarCat)
(provide designorarCat)
(provide ignorarAutor)
(provide designorarAutor)
(provide autorIgnorado)
(provide catIgnorada)
(provide nome)
(provide disableConsole)

(define useConsole #t)

(define posts
    ; ID TEXTO AUTOR DATA CATEGORIA LIKES
  '(
    ; Tecnologia
     (1 "TSE quer ajuda do Exército contra crimes cibernéticos nas Eleições 2018  http://bit.ly/2xLLAgU" "IDG Now!" 6 "Tecnologia" 30)
     (2 "Huawei anuncia novo celular Mate 10 com tela Quad HD e chip para IA  http://bit.ly/2gdApC4" "PC WORLD" 10 "Tecnologia" 50)
     (3 "NASA admite que evidências da existência do Planeta Nove são válidas http://canalte.ch/S26P6-22MY" "Canaltech" 4 "Tecnologia" 50)
     (4 "Apple lança novos betas de seus sistemas operacionais para desenvolvedores http://canalte.ch/S26OW-22MQ" "Canaltech" 5 "Tecnologia" 10)

     ; Cultura
     (5 "Pronto pro vestibular? 📑 A @BVLbiblioteca oferece um curso para discutir as obras literárias pedidas nas provas. http://bit.ly/2y9uHfg" "Secretaria Cultura" 6 "Cultura" 5)
     (6 "Magnus Chase e os Deuses de Asgard: último livro da série escrita pelo criador de Percy Jackson chega ao Brasil http://bit.ly/2ifuEYS" "omelete" 3 "Cultura" 10)
     (7 "Hoje, às 22h15, o #RodaViva recebe o ex-jogador de futebol @rai10oficial. Na @TVCultura e no site: https://goo.gl/xUAuxG ." "Roda Viva" 4 "Cultura" 100)
     (8 "Centro de Visitantes das Paineiras bate a marca de 1 milhão de turistas e vai ganhar novas atrações no próximo mês http://abr.ai/2kTwPSX" "Veja" 2 "Cultura" 80)
     (9 "Chiquinha ensanguentada no novo teaser de Stranger Things. Assista: http://bit.ly/2xJ2RSL" "Catraca Livre" 9 "Cultura" 60)

     ; Saúde
     (10 "3 lugares para tomar bons sucos na capital 🍎  http://abr.ai/2kTazZs" "Veja" 10 "Saúde" 30)
     (11 "6 dicas para não sofrer tanto com a chegada do horário de verão http://dlvr.it/Pw062D  via @CatracaSaude" "Catraca Livre" 3 "Saúde" 35)
     (12 "Novo remédio biológico para tratamento de cânceres é aprovado pela @anvisa_oficial. Saiba mais: https://goo.gl/Ws18oX " "Ministério da Saúde" 4 "Saúde" 40)
     (13 "Cientistas desvendam por que leite materno tem moléculas de açúcar que bebês não digerem" "G1" 3 "Saúde" 10)
     (14 "Os três tipos de alimentos que ajudam a controlar o apetite" "Bem Estar" 4 "Saúde" 100)

     ; Internacional 
     (15 "Em clima de ameaças, hotel russo símbolo da União Soviética é esvaziado. https://glo.bo/2yu7aFR" "O Globo" 10 "Internacional" 50)
     (16 "GALERIA: Portugal e Espanha sofrem com incêndios florestais - http://bit.ly/2ysCNiS" "Inter Estadão" 2 "Internacional" 60)
     (17 "Termina nesta segunda-feira prazo para Catalunha responder ao governo da Espanha sobre independência" "G1" 6 "Internacional" 70)
     (18 "Ataque na Somália, o mais letal em uma década, deixa mais de 200 mortos http://bbc.in/2gHf05b" "BBC Brasil" 5 "Internacional" 80) 
     (19 "Ex-procuradora-geral encobriu caso Odebrecht, diz prefeito de Caracas" "Folha Mundo" 5 "Internacional" 90)
     
     ; História
     (20 "Quanto tempo um neandertal mamava? Ciência explica http://dlvr.it/Pw07L0" "Catraca Livre" 7 "História" 110)
     (21 "#MunicipiosPaulistas Esta é uma planta da cidade de Itu, de 1977... https://goo.gl/VLQH6A" "Arquivo Público" 4 "História" 120)
     (22 "CASA DE CLÁUDIO DE SOUZA RECEBE A PEÇA “ A JORNADA DO TREM DAS BORBOLETAS NO BRASIL FOLCLÓRICO”" "Museu Imperial" 1 "História" 130)
     (23 "Livros do século 19 revelam cotidiano social e econômico de escravos - Política e Brasil" "Assoc Nac Historia" 2 "História" 140)
     (24 "Livro convida a releitura da Missão Francesa q chegou ao Brasil há + de 2 séc p/ implantar ensino oficial da arte e deixou marcas na cultura" "Ibram/Minc" 10 "História" 150)

     (25 "Comércio brasileiro já começa a anunciar o iPhone 8: https://blogdoiphone.com/2017/10/comercio-brasileiro-ja-comeca-a-anunciar-o-iphone-8/" "Blog do iPhone" 3 "Tecnologia" 250)

     ; Diversão
     (26 "Ter que eliminar alguém com talento é difícil. Tanto para os participantes como para os nossos chefs: http://bit.ly/2yhyg2r  #MasterChefBR" "MasterChef" 1 "Diversão" 10)
     (27 "Guia completo do mochileiro: tudo que você precisa saber para se tornar um! http://abr.ai/2wWrxbU  😉 🎒" "Viagem e Turismo" 6 "Diversão" 20)
     (28 "Confira 15 lugares para comprar café em São Paulo. Tem grão, pó e cápsula para comprar e preparar em casa http://bit.ly/2zdgxGN " "Paladar" 9 "Diversão" 15)
     (29 "Você apresenta o trabalho para a sala e a professora só rasga elogios! #MasterChefBR" "MasterChef" 12 "Diversão" 300)
     (30 "Dias certos de entrada grátis em 30 museus imperdíveis do mundo: http://abr.ai/2gn7b7C  👏 😉" "Viagem e Turismo" 14 "Diversão" 100)
    )
)

(define nextId 31)
(define nome "John Doe")
(define today 18)

(define (id post) (car post))
(define (texto post) (cadr post))
(define (autor post) (caddr post))
(define (dia post) (cadddr post))
(define (categoria post) (list-ref post 4))
(define (likes post) (list-ref post 5))

(define (categoria-aux cats postId)
  (cond [(null? cats) #f]
        [(not (equal? (member postId (cadar cats)) #f)) (caar cats)]
        [else (categoria-aux (cdr cats) postId)]
   )
)

(define catIgnorada '())
(define autorIgnorado '())

(define (éIgnorado? post)
  (not (and (equal? (member (categoria post) catIgnorada) #f)
           (equal? (member (autor  post) autorIgnorado) #f)
        )
   )
)

(define (getLista posts)
  (let* (
         [lista-ord (sort posts (λ(x y) (< (dia x) (dia y))))]
         [tira-igno (filter (λ(x) (not (éIgnorado? x))) lista-ord)]
         )
    tira-igno)
    
)

; Listar
(define (listar) (if useConsole (display (foldl formata-post "" (getLista posts))) (foldl formata-post "" (getLista posts))))

(define (disableConsole) (set! useConsole #f))

(define (formata-post item acc)
  (string-join (list acc
                     "#" (number->string (id item)) "\n"
                     "  @" (autor item) "\t\t\tdia " (number->string (dia item)) "\n"
                     (texto item) "\n"
                     "(em " (categoria item) ")\n\n"
                     "👍 " (number->string (likes item))
                     "\n------------------------------------\n")
               ""
  )
)

; Ignorar categoria
(define (ignorarCat cat) (begin (set! catIgnorada (append (list cat) catIgnorada)) (listar)))

; Designirar Categoria
(define (designorarCat cat)
  (set! catIgnorada
    (foldl (λ (x acc) (if (equal? x cat) acc (append (list x) acc))) '() catIgnorada
    )
  )
  (listar)
)

; Ignorar autor
(define (ignorarAutor autor) (begin (set! autorIgnorado (append (list autor) autorIgnorado)) (listar)))

; Designirar Autor
(define (designorarAutor autor)
  (set! autorIgnorado
    (foldl (λ (x acc) (if (equal? x autor) acc (append (list x) acc))) '() autorIgnorado
    )
  )
  (listar)
)

; Criar post
(define (postar mensagem)
  (begin
    (set! posts (reverse (cons (list nextId mensagem nome today "Desconhecido" 0) (reverse posts))))
    (set! nextId (add1 nextId))
    (listar)
  )
)

; Define a categoria de um post
(define (seta-categoria postId categoria)
  (set! posts
          (map (λ (post)
                 (if (equal? (id post) postId)
                     (list (id post) (texto post) (autor post) (dia post) categoria (likes post))
                     post
                 )
               )
               posts
          )
    )
    (listar)
)

; Dá um like em um post
(define (like postId)
    (set! posts
          (map (λ (post)
                 (if (equal? (id post) postId)
                     (list (id post) (texto post) (autor post) (dia post) (categoria post) (add1 (likes post)))
                     post
                 )
               )
               posts
          )
    )
    (listar)
)
