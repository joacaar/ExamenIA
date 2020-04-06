; La posicion de la cocina tomara el valor 0
; En los hechos, se indica primero los platos y luego la posicion con el valor respectivo del numero de cada mesa
; se supondra que el robot inicialmente esta en la cocina
; Indicamos la cantidad maxima de platos que puede llevar para tener reglas mas genericas

(deffacts datos

    (robot 0 0)  (maxCantidad 4) (posConcina 0)
    ; recoger 3 platos de cocina y llevar a mesa 3
    (recoger p 3 0 3 p 2 0 2 p 4 3 0 p 2 1 0)

    (mesa 1 2) (mesa 2 0) (mesa 3 4) (mesa 4 0)
    )

    (defrule mover
    
        ?robot <- (robot ?cantidadRobot ?pos)
        ?recogida <- (recoger $?resto1 p ?platos ?origen ?destino $?resto2)

        (test (neq ?pos ?origen))

        =>

        (retract (robot ?cantidadRobot ?origen)

    )


    (defrule entrega 
        ?robot <- (robot ?cantidadRobot ?pos)
        ?pedido <- (pedidos $?resto1 p ?cantPedido ?mesa $?resto2)
        ?recogida <- (recogida $?listaReco)
        ?cocina <- (posConcina ?coc)
        ?maximo <- (maxCantidad ?max)

        (test (= ?pos ?coc))
        (test (< (+ ?cantidadRobot ?cantPedido) ?max))
       
        =>

        (printout t "Robot " (+ ?cantidadRobot ?cantPedido) ?mesa crlf)
        (printout t "pedidos " $?resto1 $?resto2 crlf)

        (retract ?robot)
        (retract ?pedido)
        (retract ?recogida)

        (assert (robot (+ ?cantidadRobot ?cantPedido) ?mesa))
        (assert (pedidos $?resto1 $?resto2))
        (assert (recogida $?listaReco r ?cantPedido ?mesa))
    )

    ;(defrule recoger)

    (defrule final
        ?pedidos <- (pedidos $?listado)
        ;?recogidas <- (recogida $?listado2)

        (test (= (length $?listado) 0))

        => 
        (halt)
    )