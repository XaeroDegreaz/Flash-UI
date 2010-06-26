package net.jerome.utils
{
	import flash.display.MovieClip;
	/**
	 * A class containing geometry based calculations for manipulating MovieClips. 
	 * @author XaeroDegreaz
	 * 
	 */	
	public class Geom {
		/**
		 *Rotate the clip to face the mouse. 
		 * @param clip The target MoveiClip
		 * @param y The mouse's y position
		 * @param x The mouse's x position
		 * @param cy The clip's y position
		 * @param cx The clip's x position
		 * 
		 */		
		public static function RotateToMouse(clip:MovieClip, y:Number, x:Number, cy:Number, cx:Number):void{
			var radians = Math.atan2(y - cy, x - cx);
			var degrees = Math.round((radians*180/Math.PI));
			clip.rotation = degrees+90;
		}		
	}
}