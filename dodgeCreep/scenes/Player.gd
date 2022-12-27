extends Area2D

signal batida

export var velocidade = 400
var tamanho_da_tela
var direcao

func _ready():
	tamanho_da_tela = get_viewport_rect().size
	direcao = Vector2.ZERO
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	direcao = delimitar_direcao(direcao)
	movimentar_e_animar(direcao, delta)
	prender_personagem_na_tela()
	
	
pass


func prender_personagem_na_tela():
	position.x = clamp(position.x, 25, tamanho_da_tela.x - 25)
	position.y = clamp(position.y, 35, tamanho_da_tela.y - 35)
pass

func delimitar_direcao(vetor: Vector2) -> Vector2:
	if Input.is_action_pressed("ui_right"):
		vetor.x = 1
	if Input.is_action_just_released("ui_right"):
		vetor.x = 0

	if Input.is_action_pressed("ui_left"):
		vetor.x = -1
	if Input.is_action_just_released("ui_left"):
		vetor.x = 0
		
	if Input.is_action_pressed("ui_up"):
		vetor.y = -1
	if Input.is_action_just_released("ui_up"):
		vetor.y = 0
		
	if Input.is_action_pressed("ui_down"):
		vetor.y = 1
	if Input.is_action_just_released("ui_down"):
		vetor.y = 0
	
	return vetor
pass

func movimentar_e_animar(vetor: Vector2, delta: float):
	if vetor.length() > 0:
		vetor = vetor.normalized() * velocidade
		if vetor.x == 400:
			$AnimatedSprite.animation = "direita"
			$AnimatedSprite.flip_h = false
			$AnimatedSprite.flip_v = false
			$AnimatedSprite.play()
		elif vetor.x == -400:
			$AnimatedSprite.animation = "direita"
			$AnimatedSprite.flip_h = true
			$AnimatedSprite.flip_v = false
			$AnimatedSprite.play()
		
		elif vetor.y == 400:
			$AnimatedSprite.animation = "cima"
			$AnimatedSprite.flip_v = true
			$AnimatedSprite.play()
		
		elif vetor.y == -400:
			$AnimatedSprite.animation = "cima"
			$AnimatedSprite.flip_v = false
			$AnimatedSprite.play()
		position += vetor * delta
	else:
		$AnimatedSprite.stop()
pass

func _on_Player_body_entered(body):
	hide()
	emit_signal("batida")
	$CollisionShape2D.set_deferred("disabled", true) #isso é pra desabilidade os tics de dano
	pass
	
func carregar_personagem():
	position = Vector2((tamanho_da_tela.x / 2), (tamanho_da_tela.y / 2))
	show()
	$CollisionShape2D.disabled = false
pass







#func _on_TempoMob_timeout():
#	pass # Replace with function body.
