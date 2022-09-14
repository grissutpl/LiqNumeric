# ------------------------------------------------- ----------------------------------------
# 13. ANALISIS DINAMICO
# ------------------------------------------------- ----------------------------------------

model BasicBuilder -ndm 2 -ndf 3

# definir factor de escala constante para velocidad aplicada
set cFactor [expr $colArea*$dashpotCoeff]

# define el archivo de historial de tiempo de velocidad
set velocityFile velocityHistory.out

# objeto de serie temporal para el historial de fuerza
set mSeries "Path -dt $motionDT -filePath $velocityFile -factor $cFactor"

#  cargando objeto
pattern Plain 10 $mSeries {
    load 1  1.0 0.0 0.0
}
puts "Dynamic loading created..."


constraints $constraints_d $c1_d $c2_d
test        $test_d $tol_d $iter_d $salida_d
algorithm   $alg_d $val_d
numberer    $numberer_d
system      $system_d
integrator  $integrator_d $gama_d $beta_d
rayleigh    $a0 $a1 0.0 0.0
analysis    $analysis_d
set curTime  [getTime]
  set mTime $curTime
	
puts "tiempo: $curTime"
# realizar análisis con bucle de reducción de paso de tiempo
set ok [analyze $nSteps  $dT]

# si el análisis falla, reduce el paso del tiempo y continúa con el análisis
if {$ok != 0} {
    puts "did not converge, reducing time step"
    set curTime  [getTime]
    set mTime $curTime
	
    puts "curTime: $curTime"
	
    set curStep  [expr $curTime/$dT]
	
    puts "curStep: $curStep"
	
    set rStep  [expr ($nSteps-$curStep)*2.0]
    set remStep  [expr int(($nSteps-$curStep)*2.0)]
	
    puts "remStep: $remStep"
	
    set dT       [expr $dT/2.0]
	
    puts "dT: $dT"

    set ok [analyze  $remStep  $dT]

    # si el análisis falla, reduce el paso del tiempo y continúa con el análisis
    while {$ok != 0} {
        puts "did not converge, reducing time step"
        set curTime  [getTime]
		
        puts "curTime: $curTime"
		
        set curStep  [expr ($curTime-$mTime)/$dT]
		
        puts "curStep: $curStep"
		
        set remStep  [expr int(($rStep-$curStep)*2.0)]
		
        puts "remStep: $remStep"
		
        set dT       [expr $dT/2.0]
		
        puts "dT: $dT"
		
		set mTime $curTime
		set rStep  [expr ($remStep-$curStep)*2.0]
		
        set ok [analyze  $remStep  $dT]
    }
}
set endT    [clock seconds]

#borrar archivos en caso de existir
#file delete $pathmaster/post_proceso/columna_$p/dinamico/desplazamientos/displacementx.out
#file delete $pathmaster/post_proceso/columna_$p/dinamico/desplazamientos/displacementy.out
#file delete $pathmaster/post_proceso/columna_$p/dinamico/aceleraciones/accelerationx.out
#file delete $pathmaster/post_proceso/columna_$p/dinamico/aceleraciones/accelerationy.out
#file delete $pathmaster/post_proceso/columna_$p/dinamico/velocidades/porePressure.out

#copiar archivos en carpeta
#file copy "displacementx.out"  $pathmaster/post_proceso/columna_$p/dinamico/desplazamientos
#file copy "displacementy.out"  $pathmaster/post_proceso/columna_$p/dinamico/desplazamientos
#file copy "accelerationx.out"  $pathmaster/post_proceso/columna_$p/dinamico/aceleraciones
#file copy "accelerationy.out"  $pathmaster/post_proceso/columna_$p/dinamico/aceleraciones
#file copy "porePressure.out"  $pathmaster/post_proceso/columna_$p/dinamico/velocidades


puts "Finished with dynamic analysis..."
puts "Analysis execution time: [expr $endT-$startT] seconds"
