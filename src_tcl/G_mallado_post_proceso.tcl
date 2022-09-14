# LA NOMENCLATURA OCUPADA EN ESTE ARCHIVO ES:

#numLayers: número de capas de suelo
#nElemY: elementos en la dirección vertical 
#nElemT: elementos totales 
#nNodeX: nodos en la dirección horizontal  
#sElemX: tamaño del elemento horizontal en cada capa (este dato se genero en el preproceso)
#sElemY: tamaño del elemento vertical en cada capa

# ------------------------------------------------- ----------------------------------------
# 8. CREAR EL ARCHIVO GID FLAVIA.MSH PARA POSPROCESAR
# ------------------------------------------------- ----------------------------------------

set meshFile [open $pathmaster/post_proceso/columna_$p/freeFieldEffective.flavia.msh w]
puts $meshFile "MESH 94quad dimension 2 ElemType Quadrilateral Nnode 4"
puts $meshFile "Coordinates"
puts $meshFile "#node_number   coord_x   coord_y"
set count 1
set layerNodeCount 0
for {set k 1} {$k <= $numLayers} {incr k 1} {
    for {set i 1} {$i <= $nNodeX} {incr i 2} {
        if {$k == 1} {
            set bump 1
        } else {
            set bump 0
        }

        for {set j 1} {$j <= [expr 2*$nElemY($k)+$bump]} {incr j 2} {

            set xCoord  [expr ($i-1)*$sElemX/2]
            set yctr    [expr $j + $layerNodeCount]
			set yCoord  [expr (($yctr-1)*$sElemY($k)/2)]; # coordenada y en los nodos exteriores
            set nodeNum [expr $i + ($yctr-1)*$nNodeX]
			
			if {$xCoord == 0.0} {
                puts $meshFile "$nodeNum  $xCoord  $yCoord";# se escribe en archivo ppNodesInfo
            }
        }
		
		for {set j 1} {$j <= [expr 2*$nElemY($k)+$bump]} {incr j 2} {

            set xCoord  [expr ($i-1)*$sElemX/2]
            set yctr    [expr $j + $layerNodeCount]
			set yCoord  [expr (($yctr-1)*$sElemY($k)/2)]; # coordenada y en los nodos exteriores
            set nodeNum [expr $i + ($yctr-1)*$nNodeX]
			
			if {$xCoord == $sElemX} {
                puts $meshFile "$nodeNum  $xCoord  $yCoord";# se escribe en archivo ppNodesInfo
            }
        }
    }
	set layerNodeCount [expr $yctr + 1]
}

puts $meshFile "end coordinates"
puts $meshFile "Elements"
puts $meshFile "# element   node1   node2   node3   node4"
for {set j 1} {$j <= $nElemT} {incr j 1} {
    set nI  [expr 6*$j - 5]
    set nJ  [expr $nI + 2]
    set nK  [expr $nI + 8]
    set nL  [expr $nI + 6]
    puts $meshFile "$j    $nI    $nJ    $nK    $nL"
}
puts $meshFile "end elements"
close $meshFile