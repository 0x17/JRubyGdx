require 'java'

gdx_path = 'lib/'
['gdx', 'gdx-natives', 'gdx-backend-lwjgl', 'gdx-backend-lwjgl-natives'].each {
	|jar| require gdx_path+jar+".jar"
}

def import_classes(package, classes)
  classes.each { |clazz| eval("java_import " + package + "." + clazz) }
end

import_classes("com.badlogic.gdx", ["ApplicationListener", "Input", "Gdx"])
import_classes("com.badlogic.gdx.graphics", ["Texture", "GL10"])

java_import com.badlogic.gdx.math.Vector2
java_import com.badlogic.gdx.backends.lwjgl.LwjglApplication
java_import com.badlogic.gdx.graphics.g2d.SpriteBatch

MOV_SPEED = 5.0

class Game
	include ApplicationListener
	
	def create
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

	def render
		processInput

		Gdx.gl.glClear(GL10.GL_COLOR_BUFFER_BIT)

		@sb.begin
		@sb.draw(@tex, @pos.x, @pos.y)
		@sb.end
	end

	def resize(width, height)
	end

	def pause
	end

	def resume
	end
end

LwjglApplication.new(Game.new, "GdxTest", 800, 480, false)