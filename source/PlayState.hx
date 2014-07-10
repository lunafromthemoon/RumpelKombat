package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;
import flixel.util.FlxRandom;

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
	var playerStake :Int = 0;

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
		var rockButton :FlxButton = new FlxButton ( 325, 350, "Rock", choseRock );
		var paperButton :FlxButton = new FlxButton ( 325, 375, "Paper", chosePaper );
		var scissorsButton :FlxButton = new FlxButton ( 325, 400, "Scissors", choseScissors );
		add( rockButton );
		add ( paperButton );
		add ( scissorsButton );
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
   		super.update();
    }

    public function playerDefense():Void 
    {
    	var newPos:FlxPoint = FlxG.mouse.getScreenPosition();

	   	// weird math

	   	var maxAngle:Float = Math.PI/3;
	   	var minAngle:Float = -Math.PI/6;
	   	var maxPosBottom :FlxPoint = new FlxPoint ( 285, 276 );
	   	var armPosition :FlxPoint = new FlxPoint ( cholitaPosition.x + armOffset.x, cholitaPosition.y + armOffset.y );

	   	if (!FlxGeom.vequal(newPos, lastPos)) {
	   		trace (newPos);
	   		var maxRad :Float = FlxGeom.vdistsqr ( armPosition, maxPosBottom );
	   		var armAngle :Float = FlxGeom.angle ( armPosition , newPos );
	   		trace(armAngle);
	   		if (armAngle <= maxAngle && armAngle >= minAngle)
	   		{
	   			var armPoint :FlxPoint = FlxGeom.vPoint ( armPosition , maxRad , -armAngle );
	   			armFront.setFist(armPoint);
	   			armBack.setFist(new FlxPoint(armPoint.x - armDistance.x,armPoint.y-armDistance.y));
	   			 
	   		}
	   	 }    
	   	 lastPos = newPos;
    }

    public function decideStakes ( playerStake:Int, enemyStake:Int ) {

    	var next :Int = (playerStake + 1) % 3;
    	
    	if ( playerStake == enemyStake ) {

    		trace ( "draw!" );

    	} else if ( enemyStake == next ) {

    		trace ( "enemy attack!" );
    		trace ( "player defense!" );
    		playerDefense();
    	
    	} else {

    		trace ( "player attack!" );
    		trace ( "enemy defense!" );
    	} 
    }

    public function choseRock() {

    	var enemyStake :Int = FlxRandom.intRanged ( 0, 2);
    	playerStake = 0;
    	
    	decideStakes (playerStake, enemyStake);

		trace ( "enemyStake: " + enemyStake + " " + "playerStake" + playerStake );
    }

    public function chosePaper() {

    	var enemyStake :Int = FlxRandom.intRanged ( 0, 2);
    	playerStake = 1;

    	decideStakes (playerStake, enemyStake);
		
		trace ( "enemyStake: " + enemyStake + " " + "playerStake" + playerStake );
    }

    public function choseScissors() {

        var enemyStake :Int = FlxRandom.intRanged ( 0, 2);
    	playerStake = 2;
    	
    	decideStakes (playerStake, enemyStake);
		
		trace ( "enemyStake: " + enemyStake + " " + "playerStake" + playerStake );	
    }
}