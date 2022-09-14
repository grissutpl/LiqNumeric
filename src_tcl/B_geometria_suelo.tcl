# LA NOMENCLATURA OCUPADA EN ESTE ARCHIVO ES:

#LayerBound: límite de capa
#layerThick: espesor de capa de suelo
#numLayers: número de capas de suelo
#nElemX: elementos en la dirección horizontal
#nElemY: elementos en la dirección vertical 
#nElemT: elementos totales 
#nNodeX: nodos en la dirección horizontal
#nNodeY: nodos en la dirección vertical 
#nNodeT: nodos totales 
#sElemX: tamaño del elemento horizontal en cada capa (este dato se genero en el preproceso)
#sElemY: tamaño del elemento vertical en cada capa


# --- GEOMETRÍA DEL SUELO

# espesores del perfil del suelo (m);

# número de capas de suelo;

# grosores de capa

# profundidad del nivel freático;

# definir límites de capa


set layerBound(1) $layerThick(1); # se define el límite para la primera capa

puts "layer bound: $layerBound(1)"

for {set i 2} {$i <= $numLayers} {incr i 1} {
    set layerBound($i) [expr $layerBound([expr $i-1])+$layerThick($i)]; # se define los límites de las capss restantes sumando el espesor de cada capa a la capa anterior
	
    puts "layer bound: $layerBound($i)"
}


# --- GEOMETRÍA DE LA MALLA

# número de elementos en dirección horizontal
set nElemX  1

# número de nodos en dirección horizontal
set nNodeX  [expr 2*$nElemX+1]														

# número total de elementos en dirección vertical


set nElemT 0
for {set i 1} {$i <=$numLayers} {incr i 1} {

	set nElemY($i) [expr 2*$layerThick($i)]; # número de elementos en dirección vertical para cada capa
	
	set nElemT [expr $nElemT+$nElemY($i)]; # número de elementos totales
	
    if { $nElemY($i) > [expr int($nElemY($i))] } {
        set nElemY($i)  [expr int(floor($nElemY($i))+1)]
    } else {
        set nElemY($i)  [expr int($nElemY($i))]  ; # se realiza una correción del número de elementos en vertical para dejar de lado valores con decimales y que hayan solo enteros
    }
	
    puts "Cantidad de elementos en capa ($i):  $nElemY($i)"
    
    set sElemY($i) [expr $layerThick($i)*1.00/$nElemY($i)] ; # tamaño del elemento vertical en cada capa

    puts "Tamaño de elementos en capa ($i):  $sElemY($i)"
}

# número de nodos en dirección vertical
set nNodeY  [expr 2*$nElemT+1]

# número total de nodos
set nNodeT  [expr $nNodeX*$nNodeY]
