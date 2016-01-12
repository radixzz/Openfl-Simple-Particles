package;
import flash.geom.Rectangle;
import openfl.display.Graphics;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import haxe.Timer;
import openfl.display.Tilesheet;
/**
 * ...
 * @author Ivan Juarez
 */
class Manager extends Sprite
{	
	public static inline var TILE_FIELDS = 7;
	public static inline var MAX_PARTICLES = 10000;
	private var particles: Array<Particle>;
	private var pool: Array<Particle>;
	private var prevTime = 0.0;
	private var tilesheet: Tilesheet;
	private var tileData: Array<Float>;
	
	public function new() {
		super();
		particles = [];
		pool = [];
		tileData = [];
		createShapesTileSheet();
	}
	
	private function createShapesTileSheet() {
		var bmd = new BitmapData(128, 128, true, 0x00FFFFFF);
		tilesheet = new Tilesheet(bmd);
		bmd.draw(getCircleSprite());
		tilesheet.addTileRect(new Rectangle(0, 0, 128, 128));
	}
		
	private function getCircleSprite(): Sprite {
		var tmpSprite = new Sprite();
		tmpSprite.graphics.clear();
		tmpSprite.graphics.beginFill(0xFFFFFF);
		tmpSprite.graphics.drawCircle(64, 64, 64);
		tmpSprite.graphics.endFill();
		return tmpSprite;
	}
	
	public function emit(x: Float, y: Float) {
		for (i in 0...25) {
			var xStart = x + Math.random() * 100;
			var yStart = y + Math.random() * 100;		
			spawn(xStart, yStart);	
		}
	}
	
	private function spawn(x: Float, y: Float) {
		if (particles.length >= MAX_PARTICLES) {
			pool.push(particles.shift());
		}
		
		var p = pool.length > 0 ? pool.pop() : new Particle();
		particles.push(p);
		p.init(x, y, Utils.rnd(5, 40));
	}
	
	public function draw() {
		
		var currentTime = Timer.stamp();
		var delta = currentTime - prevTime;
		prevTime = currentTime;
		graphics.clear();
		var index = 0;
		var pIndex = particles.length;
		while (pIndex-- > 0) {
			var p = particles[pIndex];
			if (p.alive) {
				p.move(delta);
			} else {
				pool.push(particles.splice(pIndex, 1)[0]);
				continue;
			}
			
			tileData[index + 0] = p.position.x;
			tileData[index + 1] = p.position.y;
			tileData[index + 2] = 0;
			tileData[index + 3] = p.radius / 64;
			tileData[index + 4] = p.color.r;
			tileData[index + 5] = p.color.g;
			tileData[index + 6] = p.color.b;
			
			index += TILE_FIELDS;
		}
		graphics.drawTiles(tilesheet, tileData, true, Tilesheet.TILE_SCALE | Tilesheet.TILE_RGB | Tilesheet.TILE_BLEND_ADD, index);
	}
	
}