; La posicion de la cocina tomara el valor 0
; En los hechos, se indica primero los platos y luego la posicion con el valor respectivo del numero de cada mesa
; se supondra que el robot inicialmente esta en la cocina
; Indicamos la cantidad maxima de platos que puede llevar para tener reglas mas genericas

(deffacts datos
    (robot 0 0) (pedidos p 3 3 p 2 2) (recogida r 4 3 r 2 1) (maxCantidad 4) (posConcina 0))

    (defrule entregar 
        ?robot <- (robot ?cantidadRobot ?pos)
        ?pedido <- (pedidos $?resto1 p ?cantPedido ?mesa $?resto2)
        ?cocina <- (posConcina ?coc)
        ?maximo <- (maxCantidad ?max)

        (test (= ?pos ?coc))
        (test (< (+ ?cantidadRobot ?cantPedido) ?max))
       
        =>

        (printout t "Robot " (+ ?cantidadRobot ?cantPedido) ?mesa crlf)
        (printout t "pedidos " $?resto1 $?resto2 crlf)

        (retract ?robot)
        (retract ?pedido)

        (assert (robot (+ ?cantidadRobot ?cantPedido) ?mesa))
        (assert (pedidos $?resto1 $?resto2))
    )

    ;(defrule recoger)

    (defrule final
        ?pedidos <- (pedidos $?listado)
        ;?recogidas <- (recogida $?listado2)

        (test (= (length $?listado) 0))

        => 
        (halt)
    )