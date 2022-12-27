extends Node

export(PackedScene) var cena_mob
var pontuacao = 0

func _ready():
	randomize()
	pass 
	
func _process(delta):
	pass

func _fim_de_jogo():
	$TempoPontuacao.stop()
	$TempoMob.stop()
	$TempoInicio.stop()
	$camadaCanvasHud/BtnStart.show()
	exibir_pontuacao()
	pontuacao = 0
	pass
	
func _inicio_de_jogo():
	#$Player.start($PosicaoInicio.position)
	randomize()
	$Player.carregar_personagem()
	$TempoInicio.start()
	$TempoMob.start()
	$TempoPontuacao.start()
	pass
	

func _on_TempoInicio_timeout():
	
	pass # Replace with function body.


func _on_TempoPontuacao_timeout():
	pontuacao += 1
	$camadaCanvasHud._modificar_pontuacao(pontuacao, true)
	pass # Replace with function body.


func _on_TempoMob_timeout():
	instanciar_mob()
	pass # Replace with function body.

func instanciar_mob():
	# criar todas as variaveis --- instancia -- localizacao --- direcao
	var mob = cena_mob.instance()
	
	var localizacao_do_spaw_do_mob = get_node("CaminhoDosMob/localizacaoDoSpawDoMob") #instanciar localização 
	localizacao_do_spaw_do_mob.offset = randi() #instanciar localização 
	#pegar o nó do caminho taçado
	
	var direcao_mob = localizacao_do_spaw_do_mob.rotation + PI / 2 #instnaciar a direção q o bixu vai
	
	mob.position = localizacao_do_spaw_do_mob.position #atribuindo a posição aleatoria na posição de spaw do mob 
	
	direcao_mob += rand_range(-PI / 4, PI / 4) 
	mob.rotation = direcao_mob
	
	var velocidade = Vector2((rand_range(150.0,1000.0)),(0.0)) #instanciar a velocidade 
	mob.linear_velocity = velocidade.rotated(direcao_mob)
	
	add_child(mob)
	pass

func _on_camadaCanvasHud_btn_apertado():
	_inicio_de_jogo()
	
	pass # Replace with function body.

func _on_Player_batida():
	_fim_de_jogo()
	pass # Replace with function body.
	
func exibir_pontuacao():
	$camadaCanvasHud._modificar_pontuacao(pontuacao, false)
	
	pass
