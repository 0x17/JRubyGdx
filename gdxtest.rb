require 'gdxwrapper'

import_classes("com.badlogic.gdx", ["Input", "Gdx"])
import_classes("com.badlogic.gdx.graphics", ["Texture", "GL10"])
java_import com.badlogic.gdx.math.Vector2
java_import com.badlogic.gdx.graphics.g2d.SpriteBatch

MOV_SPEED = 5.0

def init
	@tex = Texture.new(Gdx.files.internal("data/test.png"))
	@sb = SpriteBatch.new
	@pos = Vector2.new(10.0, 10.0)
end

def dispose
	@sb.dispose
	@tex.dispose
end

def movement
	if Gdx.input.isKeyPressed(Input::Keys::LEFT)
		@pos.x -= MOV_SPEED
	end
	if Gdx.input.isKeyPressed(Input::Keys::RIGHT)
		@pos.x += MOV_SPEED
	end
	if Gdx.input.isKeyPressed(Input::Keys::UP)
		@pos.y += MOV_SPEED
	end
	if Gdx.input.isKeyPressed(Input::Keys::DOWN)
		@pos.y -= MOV_SPEED
	end
end

def processInput
	if Gdx.input.isKeyPressed(Input::Keys::ESCAPE)
		Gdx.app.exit
	end
	movement
end

def draw
	processInput
	Gdx.gl.glClear(GL10.GL_COLOR_BUFFER_BIT)
	@sb.begin
	@sb.draw(@tex, @pos.x, @pos.y)
	@sb.end
end

$cbacks = Callbacks.new(Proc.new {init}, Proc.new {dispose}, Proc.new {draw})
