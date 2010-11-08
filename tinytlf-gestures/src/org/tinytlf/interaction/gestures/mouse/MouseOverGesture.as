package org.tinytlf.interaction.gestures.mouse
{
	import flash.events.MouseEvent;
	
	import org.tinytlf.interaction.gestures.Gesture;
	
	[Event("mouseMove")]
	[Event("mouseOver")]
	[Event("rollOver")]
	
	public class MouseOverGesture extends Gesture
	{
		public function MouseOverGesture()
		{
			super();
			
			hsm.appendChild(<move/>);
		}
		
		public function move(event:MouseEvent):Boolean
		{
			return (
				event.type == MouseEvent.ROLL_OVER ||
				event.type == MouseEvent.MOUSE_MOVE ||
				event.type == MouseEvent.MOUSE_OVER
				);
		}
	}
}