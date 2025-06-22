"
Holds ray info:
	- status: 1 - ray has hit wall, -1 - ray hasn't hit wall
	- distance
	- side: 0 - if ray hit vertical wall, 1 - if ray hit horizontal wall
	- color
"
Class {
	#name : 'Ray',
	#superclass : 'Object',
	#instVars : [
		'status',
		'distance',
		'side',
		'color'
	],
	#category : '3DMaze',
	#package : '3DMaze'
}

{ #category : 'construction' }
Ray class >> castRayFromPosition: pos withAngle: angle inDirection: rayDir onMap: level [
	| deltaD deltaDx deltaDy cell sideDx sideDy step stepX stepY raySide found mapValue rayColor rayDis |
	
	"get distance if you move only one unit"
	deltaDx := 1e30.
	deltaDy := 1e30.

	(rayDir x = 0)
		ifFalse: [ deltaDx := (1 + ((rayDir y * rayDir y) / (rayDir x * rayDir x)))sqrt ].
		
	(rayDir y = 0)
		ifFalse: [ deltaDy := (1 + ((rayDir x * rayDir x) / (rayDir y * rayDir y))) sqrt ].
		
	deltaD := deltaDx@deltaDy.
	cell := pos truncated.
		
	"DDA prep"
	sideDx :=  (pos x - cell x) * deltaD x.
	stepX := -1.
		
	sideDy :=  (pos y - cell y) * deltaD y.
	stepY := -1.
		
	(rayDir x >= 0)
		ifTrue: [ sideDx :=  (cell x + 1 - pos x) * deltaD x.
					stepX := 1].
		
	(rayDir y >= 0)
		ifTrue: [ sideDy :=  (cell y + 1 - pos y) * deltaD y.
					stepY := 1].
		
	step := stepX@stepY.
		
	"DDA algorithm"
	found := 0.
	raySide := 0.
	rayDis := 0.
	rayColor := Color black.

	[found = 0 ] whileTrue: [ 
		(sideDx < sideDy)
			ifTrue: [ rayDis := sideDx. 
						sideDx :=  sideDx + deltaD x.
						cell := (cell x + step x)@(cell y).
						raySide := 0]
			ifFalse: [ rayDis := sideDy.
						sideDy :=  sideDy + deltaD y.
						cell := (cell x)@(cell y + step y).
						raySide := 1].
			
		((cell x > level mapDim y) | (cell y > level mapDim x) | (cell x < 1) | (cell y < 1))
			ifTrue: [ found := -1 ].
			
		mapValue := (level map  at: (cell y)) at: (cell x).
		((found = 0)  and: [mapValue > 0])
			ifTrue: [ found := 1.
						rayColor := level wallColors at: mapValue ].
	].
	
	^ self new
		side: raySide;
		distance: rayDis * (angle cos);
		status: found;
		color: rayColor;
		yourself.
		
]

{ #category : 'accessing' }
Ray >> color [

	^ color
]

{ #category : 'accessing' }
Ray >> color: anObject [

	color := anObject
]

{ #category : 'accessing' }
Ray >> distance [

	^ distance
]

{ #category : 'accessing' }
Ray >> distance: anObject [

	distance := anObject
]

{ #category : 'initialization' }
Ray >> initialize [ 
	super initialize.
	side := 0.
	distance := 0.
	status := 0.
	color := Color black.
]

{ #category : 'accessing' }
Ray >> side [

	^ side
]

{ #category : 'accessing' }
Ray >> side: anObject [

	side := anObject
]

{ #category : 'accessing' }
Ray >> status [

	^ status
]

{ #category : 'accessing' }
Ray >> status: anObject [

	status := anObject
]
