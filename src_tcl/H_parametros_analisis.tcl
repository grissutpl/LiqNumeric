# LA NOMENCLATURA OCUPADA EN ESTE ARCHIVO ES:

#damp:  amortiguamiento
#vsMax: velocidad máxima de corte

# ------------------------------------------------- ----------------------------------------
# 9. DEFINIR PARÁMETROS DE ANÁLISIS
# ------------------------------------------------- ----------------------------------------

# --- PARÁMETROS DE MOVIMIENTO

# paso de tiempo en el registro de movimiento de tierra

# número de pasos en el registro de movimiento de tierra


# --- PARÁMETROS DE AMORTIGUACIÓN RAYLEIGH

# relación de amortiguación

# menor frecuencia
set omega1  [expr 2*$pi*0.2]

# mayor frecuencia
set omega2  [expr 2*$pi*20]

# coeficientes de amortiguamiento
set a0      [expr 2*$damp*$omega1*$omega2/($omega1 + $omega2)]
set a1      [expr 2*$damp/($omega1 + $omega2)]

puts "damping coefficients: a_0 = $a0;  a_1 = $a1"

# --- DETERMINAR EL ANÁLISIS ESTABLE EN EL TIEMPO USANDO LA CONDICIÓN CFL

# duración del movimiento del suelo (s)
set duration    [expr $motionDT*$motionStep]

# tamaño mínimo del elemento
set minSize $sElemY(1)
set vsMax $Vs(1)
for {set i 2} {$i <= $numLayers} {incr i 1} {
    if {$sElemY($i) < $minSize} {
        set minSize $sElemY($i)
    }
	 if {$Vs($i) > $vsMax} {
        set vsMax $Vs($i)
    }
}

# tiempo de análisis de prueba
set kTrial      [expr $minSize/(pow($vsMax,0.5))]

# definir paso de tiempo y número de pasos para el análisis
if { $motionDT <= $kTrial } {
    set nSteps  $motionStep
    set dT      $motionDT
} else {
    set nSteps  [expr int(floor($duration/$kTrial)+1)]
    set dT      [expr $duration/$nSteps]
}
puts "number of steps in analysis: $nSteps"
puts "analysis time step: $dT"

