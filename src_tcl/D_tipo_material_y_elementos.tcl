# LA NOMENCLATURA OCUPADA EN ESTE ARCHIVO ES:

#numLayers: número de capas de suelo
#grade(): pendiente de cada estrato
#tipe: tipo de suelo
#g: valor de gravedad(se encuentra en archivo constantes)




# ------------------------------------------------- ----------------------------------------
# 4. CREAR MATERIALES DEL SUELO
# ------------------------------------------------- ----------------------------------------

# definir grado de pendiente (%)

for {set k 1} {$k <= $numLayers} {incr k 1} {
	set slope [expr atan($grade($k))]
	if {$tipo($k) == 1 } {
	nDMaterial PressureDependMultiYield02 $k 2 $rho($k) $refShearModul($k) $refBulkModul($k) \
                                    $frictionAng($k) 0.1 $refPress($k) 0.5 $PTAng($k) $contrac1($k) \
                                    $contrac3($k) $dilat1($k) $dilat3($k) $surf($k) 5.0 3.0 1.0 0.0 \
                                    $e($k) 0.9 0.02 0.7 101.0
    
	} else {
	# se debe corregir estos valores en función de los datos de entrada en el preproceso
	nDMaterial PressureIndependMultiYield $k 2 $rho($k) $refShearModul($k) $refBulkModul($k) $cohesion($k) 0.1 \
                                           $frictionAng($k) $refPress($k) 0 $surf($k)\
	}
	
    set thick($k) 1.0 ; # espesor del estrato
    set xWgt($k)  [expr $g*sin($slope)]; # carga en la dirección x
    set yWgt($k)  [expr $g*cos($slope)]; # carga en la dirección y

}


puts "Finished creating all soil materials..."

# ------------------------------------------------- ----------------------------------------
# 5. CREAR ELEMENTOS DEL SUELO
# ------------------------------------------------- ----------------------------------------
for {set j 1} {$j <= $nElemT} {incr j 1} {
	
	# generación de orden de nodos para un elemento cuadrilátero de nueve nodos
    set nI  [expr 6*$j - 5]
    set nJ  [expr $nI + 2]
    set nK  [expr $nI + 8]
    set nL  [expr $nI + 6]
    set nM  [expr $nI + 1]
    set nN  [expr $nI + 5]
    set nP  [expr $nI + 7]
    set nQ  [expr $nI + 3]
    set nR  [expr $nI + 4]

    set lowerBound 0.0
    for {set i 1} {$i <= $numLayers} {incr i 1} {

        if {[expr $j*$sElemY($i)] <= $layerBound($i) && [expr $j*$sElemY($i)] > $lowerBound} {

          # las permeabilidades se establecen inicialmente a 1.0 m / s para el análisis de la gravedad, los valores se actualizan después de la gravedad
            element 9_4_QuadUP $j $nI $nJ $nK $nL $nM $nN $nP $nQ $nR \
                           $thick($i) $i $uBulk($i) 1.0 1.0 1.0 $xWgt($i) $yWgt($i)
        }
        set lowerBound $layerBound($i)
    }
}
puts "Finished creating all soil elements..."

