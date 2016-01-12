package ;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.geom.Point;
import openfl.display.Sprite;
import Utils;

/**
 * ...
 * @author Ivan Juarez
 */
class Particle
{
	public static var TWO_PI = Math.PI * 2;
	public static var COLORS = [0xC8FF00, 0xFA023C, 0x0069FF, 0xFFAA00, 0xAA00FF, 0xAA00FF];
	
	private var wander: Float;
	private var theta: Float;
	private var drag: Float;
	private var velocity: Point;
	public var position: Point;
	public var radius: Float;
	public var alive: Bool;
	public var color: RGB;

	public function new() {
		velocity = new Point();
		position = new Point();
	}
	
	public static inline function getRandomColor(): RGB {
		return Utils.toRGB(COLORS[Std.int(Math.random() * COLORS.length)]);
	}
	
	/**
	 * Reset all properties for respawning particle
	 */
	public function init(x: Float = 0, y: Float = 0, radius: Float = 0) {
		alive = true;
		this.radius = radius;
		this.color = getRandomColor();
		wander = Utils.rnd(0.5, 2.0);
		theta = Math.random() * TWO_PI;
		drag = Utils.rnd(0.9, 0.99);
		position.x = x;
		position.y = y;
		var force = Utils.rnd(2, 8);
		velocity.x = Math.sin(theta) * force;
		velocity.y = Math.cos(theta) * force;
	}
	
	/**
	 * Update the particle position
	 */
	public function move(delta: Float) {
		position.x += velocity.x;
		position.y += velocity.y;
		velocity.x *= drag;
		velocity.y *= drag;
		theta += (Math.random() - 0.5) * wander;
		velocity.x += Math.sin(theta) * delta;
		velocity.y += Math.cos(theta) * delta;
		radius *= 0.96;
		alive = radius > 0.5;
		
	}
}