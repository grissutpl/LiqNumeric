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


# ------------------------------------------------- ----------------------------------------
# 2. CREAR NODOS DE PRESIÓN DE POROS Y RESTRICCIONES
# ------------------------------------------------- ----------------------------------------


model BasicBuilder -ndm 2 -ndf 3 ; # se define que el módelo tiene dos dimensiones y tres grados de libertad


set ppNodesInfo [open post_proceso/Perfil$p/ejercicio$pp/ppNodesInfo.dat w]; #crea archivo con los nodos y sus coordenadas
set count 1
set layerNodeCount 0

set waterHeight [expr $soilThick-$waterTable]; #altura del nivel freático

# bucle sobre capas de suelo
for {set k 1} {$k <= $numLayers} {incr k 1} {
  # bucle en la dirección horizontal
    for {set i 1} {$i <= $nNodeX} {incr i 2} {
      # bucle en la dirección vertical
        if {$k == 1} {
            set bump 1
        } else {
            set bump 0
        }
		if {$i == 1} {
            set valor -1
        } else {
            set valor 1
        }

        for {set j 1} {$j <= [expr 2*$nElemY($k)+$bump]} {incr j 2} {

            set xCoord  [expr ($i-1)*$sElemX/2]; #coordenada x en los nodos exteriores (traslacionales)
            set yctr    [expr $j + $layerNodeCount]
            set nodeNum [expr $i + ($yctr-1)*$nNodeX]; # número de nodo exterior
			
			if {$nodeNum == 1} {
				set yCoord  [expr (($yctr-1)*$sElemY($k)/2)]; # coordenada y en los nodos exteriores
			} elseif {$nodeNum == 3} {
				set yCoord  [expr (($yctr-1)*$sElemY($k)/2)]; # coordenada y en los nodos exteriores
			} else {
				set yCoord  [expr ((($yctr-1)*$sElemY($k)/2)+$valor*$sElemX/2*tan($grade($k)* $pi/180))]; # coordenada y en los nodos exteriores
			}
			

            node $nodeNum  $xCoord  $yCoord
			
			if {$xCoord == 0.0} {

                # output nodal information to data file
                puts $ppNodesInfo "$nodeNum  $xCoord  $yCoord"
            }
			
            if {$yCoord>=$waterHeight} {
                set dryNode($count) $nodeNum; # se registra nodos que estan fuera del nivel freático
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


# ------------------------------------------------- ----------------------------------------
# 3. CREAR NODOS Y RESTRICCIONES INTERIORES
# ------------------------------------------------- ---------------------------------------

model BasicBuilder -ndm 2 -ndf 2; # se define que el módelo tiene dos dimensiones y dos grados de libertad

# columna central de nodos
set xCoord  [expr $sElemX/2]
# bucle sobre capas de suelo
set layerNodeCount 0
for {set k 1} {$k <= $numLayers} {incr k 1} {
  # bucle en la dirección vertical
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

# nodos interiores en los bordes del elemento
# bucle sobre capas
set layerNodeCount 0
for {set k 1} {$k <= $numLayers} {incr k 1} {
  # bucle en la dirección vertical
    for {set j 1} {$j <= $nElemY($k)} {incr j 1} {

        set yctr [expr $j + $layerNodeCount]
        set yCoordL   [expr $sElemY($k)*($yctr-0.5)-1*$sElemX/2*tan($grade($k)* $pi/180)]
        set yCoordR   [expr $sElemY($k)*($yctr-0.5)+1*$sElemX/2*tan($grade($k)* $pi/180)]
		set nodeNumL [expr 6*$yctr - 2]
        set nodeNumR [expr $nodeNumL + 2]
    
        node  $nodeNumL  0.0  $yCoordL
        node  $nodeNumR  $sElemX  $yCoordR

    }
    set layerNodeCount $yctr
}
puts "Finished creating all -ndf 2 nodes..."

# definir las restricciones para los nodos interiores en la base de la columna del suelo
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