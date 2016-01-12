package ;

import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.Lib;
import flash.events.Event;


/**
 * ...
 * @author Ivan Juarez
 */
class Main extends Sprite 
{
	private var manager: Manager;
	private var initialized: Bool;
	
	public function resize(?e:Event) {
		if (!initialized) init();
	}
	
	private function init() {
		if (initialized) return;
		initialized = true;
		manager = new Manager();
		addChild(manager);
	}
	
	private function onMouseMove(e: MouseEvent) {
		manager.emit(e.stageX, e.stageY);
	}
	
	public function onAddedToStage(e) {
		removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		stage.addEventListener(Event.RESIZE, resize);
		stage.addEventListener(Event.ENTER_FRAME, update);
		stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		resize();
	}

	public function new() {
		super();
		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
	}
	
	public function update(e: Event) {
		manager.draw();
		
	}

}
