# ------------------------------------------------- ----------------------------------------
# 10. ANALISIS DE GRAVEDAD
# ------------------------------------------------- ----------------------------------------

# Actualizar los materiales para garantizar un comportamiento elástico.

for {set k 1} {$k <= $numLayers} {incr k} {
    updateMaterialStage -material $k -stage 0
}

constraints $constraints_e $c1_e $c2_e
test        $test_e $tol_e $iter_e $salida_e
algorithm   $alg_e $val_e
numberer    $numberer_e
system      $system_e
integrator  $integrator_e $gama_e $beta_e
analysis    $analysis_e

set startT  [clock seconds]
analyze     10 5.0e2
puts "Finished with elastic gravity analysis..."

# Actualizar materiales para considerar el comportamiento plástico

for {set k 1} {$k <= $numLayers} {incr k} {
    updateMaterialStage -material $k -stage 1
}


# carga plástico por gravedad 
 set ok  [analyze     40 5.0e2]
 
file delete $pathmaster/post_proceso/Error.dat

if { $ok !=0 } {
puts " error de convergencia en analisis estatico"
set error [open $pathmaster/post_proceso/Error.dat w]
puts $error "Error en el analisis estatico de la columna_$p"
break
}

#borrar archivos en caso de existir
#file delete $pathmaster/post_proceso/columna_$p/estatico/desplazamientos/Gdisplacementx.out
#file delete $pathmaster/post_proceso/columna_$p/estatico/desplazamientos/Gdisplacementy.out
#file delete $pathmaster/post_proceso/columna_$p/estatico/aceleraciones/Gaccelerationx.out
#file delete $pathmaster/post_proceso/columna_$p/estatico/aceleraciones/Gaccelerationy.out
#file delete $pathmaster/post_proceso/columna_$p/estatico/velocidades/GporePressure.out

#copiar archivos en carpeta
#file copy "Gdisplacementx.out"  $pathmaster/post_proceso/columna_$p/estatico/desplazamientos
#file copy "Gdisplacementy.out"  $pathmaster/post_proceso/columna_$p/estatico/desplazamientos
#file copy "Gaccelerationx.out"  $pathmaster/post_proceso/columna_$p/estatico/aceleraciones
#file copy "Gaccelerationy.out"  $pathmaster/post_proceso/columna_$p/estatico/aceleraciones
#file copy "GporePressure.out"  $pathmaster/post_proceso/columna_$p/estatico/velocidades


puts " análisis exitoso"

puts "Finished with plastic gravity analysis..."
