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
	var armOffset = new FlxPoint (55, 185);
	var cholitaPosition = new FlxPoint (115, 125); //x= 184 y=315
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		var armPositionX :Float = cholitaPosition.x + armOffset.x;
		var armPositionY :Float = cholitaPosition.y + armOffset.y;
		var background = new FlxSprite (0,0, "assets/images/cafeteria.png");
		add(background);
		armBack = new PunchingArm(armPositionX-armDistance.x, armPositionY-armDistance.y, "assets/images/antebrazo.png", "assets/images/punio.png",this);
		cholita = new FlxSprite(cholitaPosition.x, cholitaPosition.y, "assets/images/cholita.png");
		add(cholita);
		armFront = new PunchingArm(armPositionX, armPositionY, "assets/images/antebrazo.png", "assets/images/punio.png", this);
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

		// weird math

		var maxAngle:Float = Math.PI/3;
		var minAngle:Float = 11*Math.PI/6;
		var maxPosBottom :FlxPoint = new FlxPoint ( 237, 424 ); 
		var armPosition :FlxPoint = new FlxPoint ( cholitaPosition.x + armOffset.x, cholitaPosition.y + armOffset.y );

		if (!FlxGeom.vequal(newPos, lastPos)) {
				var maxRad :Float = FlxGeom.vdistsqr ( armPosition, maxPosBottom );
				var armAngle :Float = FlxGeom.angle ( armPosition , newPos );

				if (armAngle <= maxAngle && armAngle >= maxAngle)
				{
					var armPoint :FlxPoint = FlxGeom.vPoint ( armPosition , maxRad , armAngle );
					armFront.setFist(armPoint);
					armBack.setFist(new FlxPoint(armPoint.x - armDistance.x,armPoint.y-armDistance.y));
					trace (armPoint);
				}
		
		/* mouseStart:

		x = 245 y = 330

		mouseMoves:

		x = 265 y = 350

		mouse end: 

		x = 320 y = 404

		lowermouse: x= 290 y = 475

		topmouse: x= 395 y = 165


		*/
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
}