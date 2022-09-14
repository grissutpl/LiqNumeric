
# VERIFICACION DATOS GENERALES 

set soilThick 0
for {set i 1} {$i <= $numLayers} {incr i 1} {
	set soilThick [expr $soilThick+$layerThick($i)]
}
#altura del suelo
puts "Espesor de columna: $soilThick" 
#ancho de suelo
puts "Ancho de columna: $sElemX"
#profundidad nivel freático
puts "Mesa de agua: $waterTable"
#amortiguamiento
puts "Amortiguamiento: $damp"
#número de estratos
puts "Numero de estratos: $numLayers"
#densidad de la roca
puts "Densidad de la roca: $rockDen"
#velocidad de onda cortante
puts "Velocidad de onda de corte de roca: $rockVS" 
#incremento de tiempo
puts "Incremento de tiempo: $motionDT"

puts "Pasos  para analisis: $motionStep"
puts ""
# Verificacion de los datos de cada estrato

for {set i 1} {$i <= $numLayers} {incr i 1} {
	
	
	puts "Tipo de suelo de capa ($i): $tipo($i)"
	if { $tipo($i) == 1 } {
		puts "Espesor de capa ($i): $layerThick($i)"
		puts "Pendiente en estrato ($i): $grade($i)"
		puts "Densidad saturada en estrato ($i): $rho($i)"
		puts "refShearModul($i): $refShearModul($i)"
		puts "refBulkModul($i): $refBulkModul($i)"
		puts "uBulk($i): $uBulk($i)"
		puts "Angulo de friccion en estrato ($i): $frictionAng($i)"
		puts "e($i): $e($i)"
		puts "vPerm($i): $vPerm($i)"
		puts "hPerm($i): $hPerm($i)"
		puts "Vs($i): $Vs($i)"
		puts ""
		puts "PTAng($i): $PTAng($i)"
		puts "coef. contraccion1($i): $contrac1($i)"
		puts "coef. contraccion3($i): $contrac3($i)"
		puts "coef. dilatacion1($i): $dilat1($i)"
		puts "coef. dilatacion3($i): $dilat3($i)"
		puts "refPress($i): $refPress($i)"
	} else {
		puts "Espesor de capa ($i): $layerThick($i)"
		puts "Pendiente en estrato ($i): $grade($i)"
		puts "Densidad saturada en estrato ($i): $rho($i)"
		puts "refShearModul($i): $refShearModul($i)"
		puts "refBulkModul($i): $refBulkModul($i)"
		puts "uBulk($i): $uBulk($i)"
		puts "Angulo de friccion en estrato ($i): $frictionAng($i)"
		puts "Vs($i): $Vs($i)"
		puts "vPerm($i): $vPerm($i)"
		puts "hPerm($i): $hPerm($i)"
		puts "c($i): $c($i)"
		puts "refPress($i): $refPress($i)"
	}
    puts ""
    puts ""
}