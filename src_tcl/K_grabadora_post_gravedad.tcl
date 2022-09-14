
# ------------------------------------------------- ----------------------------------------
# 12. CREAR GRABADORES POST-GRAVEDAD
# ------------------------------------------------- ----------------------------------------

# tiempo de reinicio y análisis

setTime 0.0
wipeAnalysis
remove recorders

# tiempo de la grabadora
set recDT  [expr 10*$motionDT]

# grabación de desplazamientos, aceleraciones y presión de poros nodales
eval "recorder Node -file $pathmaster/post_proceso/columna_$p/dinamico/desplazamientos/displacementx.out -time -dT $recDT -node $nodeList3 -dof 1 disp"
eval "recorder Node -file $pathmaster/post_proceso/columna_$p/dinamico/desplazamientos/displacementy.out -time -dT $recDT -node $nodeList3 -dof 2 disp"
eval "recorder Node -file $pathmaster/post_proceso/columna_$p/dinamico/aceleraciones/accelerationx.out -time -dT $recDT -node $nodeList3 -dof 1 accel"
eval "recorder Node -file $pathmaster/post_proceso/columna_$p/dinamico/aceleraciones/accelerationy.out -time -dT $recDT -node $nodeList3 -dof 2 accel"
eval "recorder Node -file $pathmaster/post_proceso/columna_$p/dinamico/velocidades/porePressure.out -time -dT $recDT -node $nodeList3 -dof 3 vel"
# registro de estrés y tensión elementales (los archivos son nombres que reflejan la numeración de gd de GiD)
#recorder Element -file stress1.out   -time -dT $recDT  -eleRange 1 $nElemT  material 1 stress
#recorder Element -file stress2.out   -time -dT $recDT  -eleRange 1 $nElemT  material 2 stress
#recorder Element -file stress3.out   -time -dT $recDT  -eleRange 1 $nElemT  material 3 stress
#recorder Element -file stress4.out   -time -dT $recDT  -eleRange 1 $nElemT  material 4 stress
recorder Element -file $pathmaster/post_proceso/columna_$p/dinamico/esfuerzo_deformacion/stress9.out   -time -dT $recDT  -eleRange 1 $nElemT  material 9 stress
#recorder Element -file strain1.out   -time -dT $recDT  -eleRange 1 $nElemT  material 1 strain
#recorder Element -file strain2.out   -time -dT $recDT  -eleRange 1 $nElemT  material 2 strain
#recorder Element -file strain3.out   -time -dT $recDT  -eleRange 1 $nElemT  material 3 strain
#recorder Element -file strain4.out   -time -dT $recDT  -eleRange 1 $nElemT  material 4 strain
recorder Element -file $pathmaster/post_proceso/columna_$p/dinamico/esfuerzo_deformacion/strain9.out   -time -dT $recDT  -eleRange 1 $nElemT  material 9 strain

puts "Finished creating all recorders..."

