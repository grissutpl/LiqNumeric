
# ------------------------------------------------- ----------------------------------------
# 7. CREAR GRABADORES DE GRAVEDAD
# ------------------------------------------------- ----------------------------------------

# create list for pore pressure nodes
set nodeList3 {}
set channel [open "$pathmaster/post_proceso/columna_$p/ppNodesInfo.dat" r]
set count 0;
foreach line [split [read -nonewline $channel] \n] {
set count [expr $count+1];
set lineData($count) $line
set nodeNumber [lindex $lineData($count) 0]
lappend nodeList3 $nodeNumber
}
close $channel

# grabación de desplazamientos, aceleraciones y presión de poros nodales

eval "recorder Node -file $pathmaster/post_proceso/columna_$p/estatico/desplazamientos/Gdisplacementx.out -time -node $nodeList3 -dof 1  disp"
eval "recorder Node -file $pathmaster/post_proceso/columna_$p/estatico/desplazamientos/Gdisplacementy.out -time -node $nodeList3 -dof 2  disp"
eval "recorder Node -file $pathmaster/post_proceso/columna_$p/estatico/aceleraciones/Gaccelerationx.out -time -node $nodeList3 -dof 1  accel"
eval "recorder Node -file $pathmaster/post_proceso/columna_$p/estatico/aceleraciones/Gaccelerationy.out -time -node $nodeList3 -dof 2  accel"
eval "recorder Node -file $pathmaster/post_proceso/columna_$p/estatico/velocidades/GporePressure.out -time -node $nodeList3 -dof 3 vel"
  

#registro de estrés y tensión elementales (los archivos son nombres que reflejan la numeración de gd de GiD)

#recorder Element -file Gstress1.out   -time  -eleRange 1 $nElemT  material 1 stress
#recorder Element -file Gstress2.out   -time  -eleRange 1 $nElemT  material 2 stress
#recorder Element -file Gstress3.out   -time  -eleRange 1 $nElemT  material 3 stress
#recorder Element -file Gstress4.out   -time  -eleRange 1 $nElemT  material 4 stress
recorder Element -file $pathmaster/post_proceso/columna_$p/estatico/esfuerzo_deformacion/Gstress9.out   -time  -eleRange 1 $nElemT  material 9 stress
#recorder Element -file Gstrain1.out   -time  -eleRange 1 $nElemT  material 1 strain
#recorder Element -file Gstrain2.out   -time  -eleRange 1 $nElemT  material 2 strain
#recorder Element -file Gstrain3.out   -time  -eleRange 1 $nElemT  material 3 strain
#recorder Element -file Gstrain4.out   -time  -eleRange 1 $nElemT  material 4 strain
recorder Element -file $pathmaster/post_proceso/columna_$p/estatico/esfuerzo_deformacion/Gstrain9.out   -time  -eleRange 1 $nElemT  material 9 strain

puts "Finished creating gravity recorders..."
