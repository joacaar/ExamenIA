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

    (defrule recoger-entregar 
        (declare (salience 10))
        ?robot <- (robot ?cantidadRobot ?pos)
        ?pedido <- (recoger $?resto1 p ?cantPedido ?origen ?destino $?resto2)
        ?table <- (mesa ?destino ?cant)
        ?maximo <- (maxCantidad ?max)

        (test (= ?pos ?origen))
        (test (< ?cantPedido ( + ?max 1))

        =>

        (retract ?robot)
        (retract ?pedido)
        (retract ?table)
        (assert (robot 0 ?destino))
        (assert (recoger $?resto1 $?resto2))
        (assert (mesa ?destino (+ ?cant ?cantPedido)))
        
    )

    (defrule mover
        ?robot <- (robot ?cantidadRobot ?pos)
        ?pedido <- (recoger $?restofinal p ?cantPedido ?origen ?destino $?restoinicio)

        => 

        (retract ?robot)
        (assert (robot ?cantidadRobot ?origen))
    )

