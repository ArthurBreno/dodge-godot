extends Node

export(PackedScene) var cena_mob
var pontuacao = 0
var dificuldades = [ "", " - muito facil", " - facil", " - normal", " - um pouco dificil", " - dificil", " - muito dificil", " - AAAAAAAAAAAA"]
var dificuldade_atual
var contador_dificuldade = 1

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
	$Musica.pitch_scale = 0.15
	$Musica.stop()
	$Sommorte.play()
	get_tree().call_group("mob", "queue_free")
	pass
	
func _inicio_de_jogo():
	randomize()
	dificuldade_atual = dificuldades[1]
	contador_dificuldade = 1
	$Player.carregar_personagem()
	$TempoInicio.start()
	$TempoMob.start()
	$TempoPontuacao.start()
	
	$Musica.play()
	pass
	

func _on_TempoInicio_timeout():
	contador_dificuldade += 1
	dificuldade_atual = dificuldades[contador_dificuldade]
	get_tree().call_group("mob", "queue_free")
	$Musica.pitch_scale = 0.15 * contador_dificuldade
	# realizar update do texto e da dificuldade do jogo
	pass # Replace with function body.


func _on_TempoPontuacao_timeout():
	pontuacao += 1
	$camadaCanvasHud._modificar_pontuacao(pontuacao, true, dificuldade_atual)
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
	
	var velocidade = Vector2((rand_range(10.0 * pontuacao,20.0 * pontuacao)),(0.0))
	
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
	$camadaCanvasHud._modificar_pontuacao(pontuacao, false, dificuldade_atual)
	
	pass
