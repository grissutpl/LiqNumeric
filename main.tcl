###########################################################
#                                                         #
# Effective stress site response analysis for a layered   #
# soil profile located on a 2% slope and underlain by an  #
# elastic half-space.  9-node quadUP elements are used.   #
# The finite rigidity of the elastic half space is        #
# considered through the use of a viscous damper at the   #
# base.                                                   #
#                                                         #
#   Created by:  Chris McGann                             #
#                HyungSuk Shin                            #
#                Pedro Arduino                            #
#                Peter Mackenzie-Helnwein                   #
#              --University of Washington--               #
#                                                         #
# ---> Basic units are kN and m   (unless specified)      #
#                                                         #
###########################################################

wipe


#-----------------------------------------------------------------------------------------
#  a. DATOS IMPORTADOS DE LOS ARCHIVOS TXT
#-----------------------------------------------------------------------------------------

#abrir fichero donde se encuentra carpeta para analisis

source src_tcl/path.txt

#abrir archivo de algoritmo
source $pathmaster/pre_proceso/algoritmo_analisis.txt

#DATOS GENERALES
source src_tcl/constantes.tcl

# función para grabar log de análisis
source src_tcl/logs.tcl

# limpiar logs
puts [limpiar_logs $pathmaster]

for {set p 1} {$p <= $columnas} {incr p 1} {
		puts [escribir_log "Column $p starts analysis" $pathmaster]

		#DATOS PARA ANALISIS
		source $pathmaster/pre_proceso/columna_$p/columna_$p.txt
		
		#VERIFICACION DE DATOS
		source src_tcl/A_imprimir_datos_generales.tcl


		#-----------------------------------------------------------------------------------------
		#  1. DEFINE SOIL AND MESH GEOMETRY
		#-----------------------------------------------------------------------------------------
		#definir geometria del suelo

		source src_tcl/B_geometria_suelo.tcl

		#-----------------------------------------------------------------------------------------
		#  2. CREATE PORE PRESSURE NODES AND FIXITIES
		#-----------------------------------------------------------------------------------------
		#-----------------------------------------------------------------------------------------
		#  3. CREATE INTERIOR NODES AND FIXITIES
		#-----------------------------------------------------------------------------------------
		#creación de nodos y restricciones
		
		source src_tcl/C_condiciones_frontera.tcl
		
		#source C1_condiciones_frontera.tcl
		
		#source C2_condiciones_frontera.tcl
		
		#-----------------------------------------------------------------------------------------
		#  4. CREATE SOIL MATERIALS
		#-----------------------------------------------------------------------------------------
		#-----------------------------------------------------------------------------------------
		#  5. CREATE SOIL ELEMENTS
		#-----------------------------------------------------------------------------------------
		#creación de materiales y de elementos 

		source src_tcl/D_tipo_material_y_elementos.tcl
		
		#-----------------------------------------------------------------------------------------
		#  6. LYSMER DASHPOT
		#-----------------------------------------------------------------------------------------
		#definición de amortiguamiento de Lysmer

		source src_tcl/E_amortiguamiento.tcl
		
		#-----------------------------------------------------------------------------------------
		#  7. CREATE GRAVITY RECORDERS
		#-----------------------------------------------------------------------------------------
		#grabadora estatica

		source src_tcl/F_grabacion_estatica.tcl
		
		#-----------------------------------------------------------------------------------------
		#  8. CREATE GID FLAVIA.MSH FILE FOR POSTPROCESSING
		#-----------------------------------------------------------------------------------------
		#creación de mallado pra post_proceso

		source src_tcl/G_mallado_post_proceso.tcl

		#-----------------------------------------------------------------------------------------
		#  9. DEFINE ANALYSIS PARAMETERS
		#-----------------------------------------------------------------------------------------

		source src_tcl/H_parametros_analisis.tcl

		#-----------------------------------------------------------------------------------------
		#  10. GRAVITY ANALYSIS
		#-----------------------------------------------------------------------------------------

		source src_tcl/I_analisis_gravitacional.tcl
		
		#-----------------------------------------------------------------------------------------
		#  11. UPDATE ELEMENT PERMEABILITY VALUES FOR POST-GRAVITY ANALYSIS
		#-----------------------------------------------------------------------------------------

		source src_tcl/J_actualizacion_valores_permeabilidad_post_gravedad.tcl

		#-----------------------------------------------------------------------------------------
		#  12. CREATE POST-GRAVITY RECORDERS
		#-----------------------------------------------------------------------------------------

		source src_tcl/K_grabadora_post_gravedad.tcl
		
		#-----------------------------------------------------------------------------------------
		#  13. DYNAMIC ANALYSIS
		#-----------------------------------------------------------------------------------------

		source src_tcl/L_analisis_dinamico.tcl
		
		wipe
				
		puts [escribir_log "Column $p was analyzed successfully" $pathmaster]	

}

