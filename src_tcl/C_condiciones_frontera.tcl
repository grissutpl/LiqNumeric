# LA NOMENCLATURA OCUPADA EN ESTE ARCHIVO ES:

#ppNodesInfo: archivo de nodos y coordenadas
#layerNodeCount: 
#waterHeight: altura del nivel freático
#soilThick: espesor del suelo
#nElemX: elementos en la dirección horizontal
#nElemY: elementos en la dirección vertical 
#nNodeX: nodos en la dirección horizontal
#nNodeY: nodos en la dirección vertical 
#nNodeT: nodos totales 
#sElemX: tamaño del elemento horizontal en cada capa (este dato se genero en el preproceso)
#sElemY: tamaño del elemento vertical en cada capa
#numLayers: número de capas de suelo
#nodeNum: número de nodo

#-----------------------------------------------------------------------------------------
#  2. CREATE PORE PRESSURE NODES AND FIXITIES
#-----------------------------------------------------------------------------------------
model BasicBuilder -ndm 2 -ndf 3

# crear carpetas de almacenamiento de resultados
file mkdir  "$pathmaster/post_proceso/columna_$p"
file mkdir  "$pathmaster/post_proceso/columna_$p/dinamico/aceleraciones"
file mkdir  "$pathmaster/post_proceso/columna_$p/dinamico/desplazamientos"
file mkdir  "$pathmaster/post_proceso/columna_$p/dinamico/esfuerzo_deformacion"
file mkdir  "$pathmaster/post_proceso/columna_$p/dinamico/velocidades"
file mkdir  "$pathmaster/post_proceso/columna_$p/estatico/aceleraciones"
file mkdir  "$pathmaster/post_proceso/columna_$p/estatico/desplazamientos"
file mkdir  "$pathmaster/post_proceso/columna_$p/estatico/esfuerzo_deformacion"
file mkdir  "$pathmaster/post_proceso/columna_$p/estatico/velocidades"

#
set ppNodesInfo [open $pathmaster/post_proceso/columna_$p/ppNodesInfo.dat w]

set count 1
set layerNodeCount 0
# loop over soil layers
for {set k 1} {$k <= $numLayers} {incr k 1} {
  # loop in horizontal direction
    for {set i 1} {$i <= $nNodeX} {incr i 2} {
      # loop in vertical direction
        if {$k == 1} {
            set bump 1
        } else {
            set bump 0
        }
        for {set j 1} {$j <= [expr 2*$nElemY($k)+$bump]} {incr j 2} {
 
            set xCoord  [expr ($i-1)*$sElemX/2]
            set yctr    [expr $j + $layerNodeCount]
            set yCoord  [expr ($yctr-1)*$sElemY($k)/2]
            set nodeNum [expr $i + ($yctr-1)*$nNodeX]
 
            node $nodeNum  $xCoord  $yCoord
			if {$xCoord == 0.0} {
                puts $ppNodesInfo "$nodeNum  $xCoord  $yCoord";# se escribe en archivo ppNodesInfo
            }
			
          # designate nodes above water table
            set waterHeight [expr $soilThick-$waterTable]
            if {$yCoord>=$waterHeight} {
                set dryNode($count) $nodeNum
                set count [expr $count+1]
            }
        }
    }
    set layerNodeCount [expr $yctr + 1]
}
close $ppNodesInfo

puts "Finished creating all -ndf 3 nodes..."
 
# define fixities for pore pressure nodes above water table
for {set i 1} {$i < $count} {incr i 1} {
    fix $dryNode($i)  0 0 1
}
 
# define fixities for pore pressure nodes at base of soil column
fix 1  0 1 0
fix 3  0 1 0
puts "Finished creating all -ndf 3 boundary conditions..."
 
 
# define equal degrees of freedom for pore pressure nodes
for {set i 1} {$i <= [expr 3*$nNodeY-2]} {incr i 6} {
    equalDOF $i [expr $i+2]  1 2
}
puts "Finished creating equalDOF for pore pressure nodes..."

#-----------------------------------------------------------------------------------------
#  3. CREATE INTERIOR NODES AND FIXITIES
#-----------------------------------------------------------------------------------------
model BasicBuilder -ndm 2 -ndf 2
 
# central column of nodes
set xCoord  [expr $sElemX/2]
# loop over soil layers
set layerNodeCount 0
for {set k 1} {$k <= $numLayers} {incr k 1} {
  # loop in vertical direction
    if {$k == 1} {
        set bump 1
    } else {
        set bump 0
    }
    for {set j 1} {$j <= [expr 2*$nElemY($k)+$bump]} {incr j 1} {
 
        set yctr    [expr $j + $layerNodeCount]
        set yCoord  [expr ($yctr-1)*$sElemY($k)/2]
        set nodeNum [expr 3*$yctr - 1] 
 
        node  $nodeNum  $xCoord  $yCoord 
    }
    set layerNodeCount $yctr
}
 
# interior nodes on the element edges
# loop over layers
set layerNodeCount 0
for {set k 1} {$k <= $numLayers} {incr k 1} {
  # loop in vertical direction
    for {set j 1} {$j <= $nElemY($k)} {incr j 1} {
 
        set yctr [expr $j + $layerNodeCount]
        set yCoord   [expr $sElemY($k)*($yctr-0.5)]
        set nodeNumL [expr 6*$yctr - 2]
        set nodeNumR [expr $nodeNumL + 2]
 
        node  $nodeNumL  0.0  $yCoord
        node  $nodeNumR  $sElemX  $yCoord
    }
    set layerNodeCount $yctr
}
puts "Finished creating all -ndf 2 nodes..."
 
# define fixities for interior nodes at base of soil column
fix 2  0 1
puts "Finished creating all -ndf 2 boundary conditions..."
 
# define equal degrees of freedom which have not yet been defined
for {set i 1} {$i <= [expr 3*$nNodeY-6]} {incr i 6} {
    equalDOF $i          [expr $i+1]  1 2
    equalDOF [expr $i+3] [expr $i+4]  1 2
    equalDOF [expr $i+3] [expr $i+5]  1 2
}
equalDOF [expr $nNodeT-2] [expr $nNodeT-1]  1 2
puts "Finished creating equalDOF constraints..."
 