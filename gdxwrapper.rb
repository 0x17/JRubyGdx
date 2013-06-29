require 'java'

gdx_path = 'lib/'
['gdx', 'gdx-natives', 'gdx-backend-lwjgl', 'gdx-backend-lwjgl-natives'].each {
	|jar| require gdx_path+jar+".jar"
}

def import_classes(package, classes)
  classes.each { |clazz| eval("java_import " + package + "." + clazz) }
end

import_classes("com.badlogic.gdx", ["ApplicationListener"])
java_import com.badlogic.gdx.backends.lwjgl.LwjglApplication

class Callbacks
	attr_reader :init, :dispose, :draw
	def initialize(initCb, disposeCb, drawCb)
		@init = initCb
		@dispose = disposeCb
		@draw = drawCb
	end
end

$cbacks = nil

def callIfNotNil(procObj)
	unless procObj.nil?
		procObj.call
	end
end

class Game
	include ApplicationListener
	
	def create
		callIfNotNil($cbacks.init)
	end

	def dispose
		callIfNotNil($cbacks.dispose)
	end

	def render
		callIfNotNil($cbacks.draw)
	end

	def resize(width, height)
	end

	def pause
	end

	def resume
	end
end

LwjglApplication.new(Game.new, "GdxTest", 800, 480, false)
