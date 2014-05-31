package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	var lastPos:FlxPoint = new FlxPoint(0, 0);
	var cholita:FlxSprite;
	var armFront:PunchingArm;
	var armBack:PunchingArm;
	var armDistance:FlxPoint = new FlxPoint(-47, 5);
	var counter:Int = 0;
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		armBack = new PunchingArm(290-armDistance.x, 215-armDistance.y, "assets/images/antebrazo.png", "assets/images/punio.png",this);
		cholita = new FlxSprite(256, 86, "assets/images/cholita.png");
		add(cholita);
		armFront = new PunchingArm(290, 215, "assets/images/antebrazo.png", "assets/images/punio.png", this);
		super.create();
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		var newPos:FlxPoint = FlxG.mouse.getScreenPosition();
		if (!FlxGeom.vequal(newPos, lastPos)) {
			armFront.setFist(newPos);
			armBack.setFist(new FlxPoint(newPos.x - armDistance.x,newPos.y-armDistance.y));
		}
		////trace("pos " + newPos.y +" " + lastPos.y);
		//if (newPos.y > lastPos.y) {
			////mouse going south
			//
			//if (arm.angle < 100) {
				//arm.angle += 10;
				////arm.updateHitbox();
			//}
			//
			////trace(counter++ +" "+arm.angle);
		//} else if (newPos.y < lastPos.y) {
			////mouse going north
			//if (arm.angle > -80) {
				//arm.angle -= 10;
				////arm.updateHitbox();
			//}	
			////trace(counter++ +" "+arm.angle);
		//}
		lastPos = newPos;
		super.update();
	}	
}