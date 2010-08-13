/*
 * Copyright (c) 2010 the original author or authors
 *
 * Permission is hereby granted to use, modify, and distribute this file
 * in accordance with the terms of the license agreement accompanying it.
 */
package org.tinytlf.layout
{
    import flash.display.DisplayObjectContainer;
    import flash.display.Sprite;
    import flash.text.engine.TextBlock;
    import flash.text.engine.TextLine;
    
    import org.tinytlf.ITextEngine;
    
	/**
	 * <p>
	 * <code>ITextContainer</code> is the layout controller for a 
	 * <code>DisplayObjectContainer</code> used in text layout. Tinytlf can 
	 * render <code>TextLines</code> across multiple 
	 * <code>DisplayObjectContainer</code>s, but it delegates final control over
	 * layout and line creation to the <code>ITextContainer</code>s.
	 * </p>
	 * <p>
	 * For a <code>DisplayObjectContainer</code> to be used for layout, it must
	 * belong to an <code>ITextContainer</code> registered with the
	 * <code>ITextLayout</code> layout actor. <code>ITextLayout</code> handles
	 * rendering across containers. <code>ITextContainer</code> participates
	 * in layout by rendering as many lines as possible into its target
	 * <code>DisplayObjectContainer</code>, then returning either:
	 * <ul>
	 * <li>the last line successfully rendered, meaning there's no more room for
	 * lines in the target <code>DisplayObjectContainer</code>, or</li>
	 * <li><code>null</code>, meaning all the lines from the TextBlock were
	 * rendered and there's still more space in the target 
	 * <code>DisplayObjectContainer</code></li>
	 * </ul>
	 * </p>
	 * <p>
	 * <code>ITextContainer</code> exposes a <code>shapes</code> Sprite, used 
	 * for drawing decorations into the target 
	 * <code>DisplayObjectContainer</code>.
	 * </p>
	 * 
	 * @see org.tinytlf.layout.ITextLayout
	 */
    public interface ITextContainer
    {
		/**
		 * <p>
		 * Reference to the central <code>ITextEngine</code> facade for this
		 * <code>container</code>.
		 * </p>
		 * 
		 * @see org.tinytlf.ITextEngine
		 */
        function get engine():ITextEngine;
        function set engine(textEngine:ITextEngine):void;
        
		/**
		 * <p>
		 * The target <code>DisplayObjectContainer</code> for this 
		 * <code>ITextContainer</code>. <code>TextLine</code>s are added to and 
		 * removed from the target during layout.
		 * </p>
		 * 
		 * @see org.tinytlf.layout.ITextLayout
		 */
        function get target():DisplayObjectContainer;
        function set target(textContainer:DisplayObjectContainer):void;
        
		/**
		 * <p>
		 * The Sprite which decorations are rendered into.
		 * </p>
		 * 
		 * @see org.tinytlf.decor.ITextDecor
		 * @see org.tinytlf.decor.ITextDecoration
		 */
        function get shapes():Sprite;
        function set shapes(shapesContainer:Sprite):void;
        
		/**
		 * <p>
		 * The defined width to render TextLines during layout. If this value is
		 * not set, lines are created with <code>TextBlock</code>'s default size
		 * for <code>TextLine</code>s, 1000000.
		 * </p>
		 */
        function get explicitWidth():Number;
        function set explicitWidth(value:Number):void;
        
		/**
		 * <p>
		 * The height within which to render and lay out TextLines. If this
		 * value is not set, the <code>ITextContainer</code> will render lines
		 * into this container indefinitely, never signaling that the container
		 * is full.
		 * </p>
		 */
        function get explicitHeight():Number;
        function set explicitHeight(value:Number):void;
        
		/**
		 * <p>
		 * The width of the widest <code>TextLine</code> in this
		 * <code>ITextContainer</code>. If the lines aren't justified, the Flash
		 * Text Engine will attempt to render lines into a certain width. If the
		 * FTE determines an atom or word won't fit, it will defer the atom or 
		 * word to the next TextLine. The result is that the actual width of the
		 * rendered TextLine is less than the specifiedWidth.
		 * </p>
		 */
        function get measuredWidth():Number;
		
		/**
		 * <p>
		 * The measured height of all the TextLines, including lineHeight and 
		 * paddingTop/paddingBottom.
		 * </p>
		 */
        function get measuredHeight():Number;
        
		/**
		 * <p>
		 * Clears all lines from the <code>ITextContainer</code> and resets the
		 * measuredWidth/measuredHeight.
		 * </p>
		 */
        function clear():void;
		
		/**
		 * <p>
		 * Clears the graphics and removes all children from the 
		 * <code>shapes</code> Sprite.
		 * </p>
		 */
        function resetShapes():void;
        
		/**
		 * <p>
		 * Called just before layout to prepare the <code>ITextContainer</code>.
		 * </p>
		 */
        function prepLayout():void;
		
		/**
		 * <p>
		 * Renders as many <code>TextLine</code>s from the specified
		 * <code>TextBlock</code> into the target as possible.
		 * </p>
		 * <p>
		 * There is a special contract between this method and 
		 * <code>ITextLayout#render</code>.
		 * </p>
		 * 
		 * @see org.tinytlf.layout.ITextLayout#render
		 */
        function layout(block:TextBlock, line:TextLine):TextLine;
		
        function hasLine(line:TextLine):Boolean;
    }
}
