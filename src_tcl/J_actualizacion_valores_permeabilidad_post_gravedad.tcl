# ------------------------------------------------- ----------------------------------------
# 11. ACTUALIZAR LOS VALORES DE PERMEABILIDAD DEL ELEMENTO PARA EL ANÁLISIS POST-GRAVEDAD
# ------------------------------------------------- ----------------------------------------

# elija el número base para las ID de los parámetros que es más alto que otras etiquetas utilizadas en el análisis
set ctr 10000.0
# bucle sobre elementos para definir ID de parámetros
for {set i 1} {$i<=$nElemT} {incr i 1} {
    parameter [expr int($ctr+1.0)] element $i vPerm
    parameter [expr int($ctr+2.0)] element $i hPerm
    set ctr [expr $ctr+2.0]
}

# actualizar los parámetros de permeabilidad para cada elemento utilizando los ID de parámetros
set ctr 10000.0
for {set j 1} {$j <= $nElemT} {incr j 1} {

    set lowerBound 0.0
    for {set i 1} {$i <= $numLayers} {incr i 1} {

        if {[expr $j*$sElemY($i)] <= $layerBound($i) && [expr $j*$sElemY($i)] > $lowerBound} {
            updateParameter [expr int($ctr+1.0)] $vPerm($i)
            updateParameter [expr int($ctr+2.0)] $hPerm($i)
        }
            set lowerBound $layerBound($i)
    }
    set ctr [expr $ctr+2.0]
}
puts "Finished updating permeabilities for dynamic analysis..."
