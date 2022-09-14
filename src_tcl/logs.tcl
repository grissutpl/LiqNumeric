
proc escribir_log {mensaje path} {
   set fileId [open "$path/post_proceso/Analysis_executed.txt" a]
   puts $fileId $mensaje
   close $fileId
}

proc limpiar_logs {path} {
   set fileId [open "$path/post_proceso/Analysis_executed.txt" w]
   #puts $fileId ""
   close $fileId
}