package ;
import flixel.FlxSprite;
import flixel.util.FlxPoint;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxColor;
/**
 * ...
 * @author LunaFromTheMoon
 */
class PunchingArm
{
	
	var arm:FlxSprite;
	var forearm:FlxSprite;
	var origin:FlxPoint;
	var fist:FlxPoint;
	var offset:Float = 8;
	var maxLenght:Float;
	var flxStage:FlxSprite;
	var stage:PlayState;

	public function new(x:Float,y:Float,forearm:String,arm:String,stage:PlayState) 
	{
		this.forearm = new FlxSprite(x, y, forearm);
		this.forearm.offset.set(offset, this.forearm.height / 2);
		this.forearm.origin.set(offset, this.forearm.height / 2);
		this.forearm.height = 2;
		this.forearm.width -= offset*2;
		stage.add(this.forearm);
		this.arm = new FlxSprite(x + this.forearm.width, y, arm);
		this.arm.offset.set(offset, this.arm.height / 2);
		this.arm.origin.set(offset, this.arm.height / 2);
		this.arm.height = 2;
		this.arm.width -= offset;
		stage.add(this.arm);
				

		this.origin = new FlxPoint(x, y );
		this.fist = new FlxPoint(this.arm.x + this.arm.width, y );
		
		maxLenght = FlxGeom.vdistsqr(origin, fist);
		
		this.fist = new FlxPoint(this.arm.x + this.arm.width/2, y+10 );
		
		flxStage = new FlxSprite();
		flxStage.makeGraphic(640, 480,FlxColor.TRANSPARENT);
		stage.add(flxStage);

		setFist(this.fist);
	}
	
	public function setFist(newFist:FlxPoint) {
		//obtain distance between origin and fist
		fist = newFist;
		var directLine = FlxGeom.vdistsqr(origin, fist);
		if (directLine >= maxLenght) {
			directLine = maxLenght;
		}
		var distAngle:Float = FlxGeom.angle(origin, fist);
		//angle for forearm is arm_angle - distAngle
		var armAngle:Float = FlxGeom.cosineTheorem(arm.width, forearm.width, directLine)-distAngle;
		//armAngle = FlxGeom.toDegrees(armAngle);
		var forearmEndpoint:FlxPoint = FlxGeom.vPoint(new FlxPoint(forearm.x, forearm.y), forearm.width, armAngle);
		//angle for arm is -forearm_angle - distAngle
		var forearmAngle:Float = FlxGeom.cosineTheorem(forearm.width, arm.width, directLine)+distAngle;
		//forearmAngle = -FlxGeom.toDegrees(forearmAngle);
		var armEndpoint:FlxPoint = FlxGeom.vPoint(forearmEndpoint, arm.width, -forearmAngle);
		//change all to degrees and set arm and forearm angles
		forearm.angle = FlxGeom.toDegrees(armAngle);		
		arm.angle = FlxGeom.toDegrees( -forearmAngle);
		arm.x = forearmEndpoint.x;
		arm.y = forearmEndpoint.y;
		//draw shite if needed
		//drawShite(origin, forearmEndpoint, armEndpoint);
		//drawShite(origin, forearmEndpoint, fist);
	}
	
	private function drawShite(p1:FlxPoint,p2:FlxPoint,p3:FlxPoint) {
		flxStage.makeGraphic(640, 480,FlxColor.TRANSPARENT);
		FlxSpriteUtil.drawLine(flxStage, p1.x,p1.y, p2.x,p2.y, { color: FlxColor.YELLOW, thickness: 2 }  );	
		FlxSpriteUtil.drawLine(flxStage, p2.x,p2.y, p3.x,p3.y, { color: FlxColor.BLUE, thickness: 2 }  );	
	}
	
}