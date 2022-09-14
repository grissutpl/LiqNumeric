# LA NOMENCLATURA OCUPADA EN ESTE ARCHIVO ES:

#nNodeT: nodos totales 
#sElemX: tamaño del elemento horizontal en cada capa (este dato se genero en el preproceso)
#numLayers: número de capas de suelo
#thick(): espesor de elemento
#rockVS: velocidad de corte en roca madre (definida en preproceso)
#rockDen: densidad de roca madre (definida en preproceso)



#-----------------------------------------------------------------------------------------
#  6. AMORTIGUADOR DE LYSMER 
#-----------------------------------------------------------------------------------------

# Definir los nodos del amortiguamiento y sus coordenadas
set dashF [expr $nNodeT+1]
set dashS [expr $nNodeT+2]

node $dashF  0.0 0.0
node $dashS  0.0 0.0

# defición de restricciones para los nodos de amortiguamiento
fix $dashF  1 1
fix $dashS  0 1

# define equal DOF for dashpot and base soil node
equalDOF 1 $dashS  1

puts "Finished creating dashpot nodes and boundary conditions..."

# definición de material de amortiguamiento
set colArea       [expr $sElemX*$thick(1)]

set dashpotCoeff  [expr $rockVS*$rockDen]
uniaxialMaterial Viscous [expr $numLayers+1] [expr $dashpotCoeff*$colArea] 1

# definición de elemento de amortiguamiento (elemento de longitud cero)
element zeroLength [expr $nElemT+1]  $dashF $dashS -mat [expr $numLayers+1]  -dir 1

puts "Finished creating dashpot material and element..."

