extends CanvasLayer

signal btn_apertado
signal btn_apertado_pouse

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func mostar_mensagem(mensagem: String):
	$LabelMensagem.text = mensagem
	$LabelMensagem.show()
	$TimerMensagem.start()
	pass
	
func mostrar_game_over():
	mostar_mensagem("faliceu")
	yield($TimerMensagem, "timeout")  #yield "para??? a função??"
	
	$LabelMensagem.text = "SOBREVIVA!!"
	yield(get_tree().create_timer(1), "timeout")
	$BtnStart.show()
	pass
	
func _modificar_pontuacao(pontuacao: int, morto_vivo: bool, dificuldade: String):
	if morto_vivo == true:
		$labelPontuacao.text = (str(pontuacao) + dificuldade)
	else:
		#var valor: String = (String)pontuacao
		$labelPontuacao.text = ("-")
		$LabelMensagem.text = ("fim de jogo!\npontuação:\n " + str(pontuacao))
		$LabelMensagem.show()
	pass


func _on_BtnStart_pressed():
	$LabelMensagem.hide()
	$BtnStart.hide()
	emit_signal("btn_apertado")
	pass 


func _on_TimerMensagem_timeout():
	
	pass 


func _on_Btnpause_pressed():
	emit_signal("btn_apertado_pouse")
pass 



