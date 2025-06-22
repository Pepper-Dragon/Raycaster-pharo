"
Renders a map from the perspective of the player.
"
Class {
	#name : 'Raycaster',
	#superclass : 'Form',
	#instVars : [
		'fov',
		'rayNr',
		'lineW'
	],
	#category : '3DMaze',
	#package : '3DMaze'
}

{ #category : 'drawing' }
Raycaster >> drawBackgroundOf: map [

	|i|
	"draw background"
	self getCanvas fillRectangle: (0@0 extent: self extent) color: map backgroundColor.
	
	"draw ground"
	i := 1.
	self height to: self height/2 by: (self lineW negated) do: [:h |
		self getCanvas fillRectangle: (0@h extent: (self width)@(self lineW)) color: map groundColor/i.
		i := i + 0.01.
	].
]

{ #category : 'drawing' }
Raycaster >> drawRay: ray at: i [

	| lineH startP brightness color |
	ray status = -1 ifTrue: [ ^ self ].

	lineH := (self height / ray distance) truncated min: self height.
	startP := i * self lineW @ (self height / 2 - (lineH / 2) truncated).
	brightness := (1 / ray distance) min: 0.8.
	color := ray color.
	ray side = 0 ifTrue: [ color := color / 2 ].
	color := color * brightness.
	self getCanvas
		fillRectangle:
		(startP extent: (self lineW)@ lineH)
		color: color
]

{ #category : 'accessing' }
Raycaster >> fov [

	^ fov
]

{ #category : 'accessing' }
Raycaster >> fov: anObject [

	fov := anObject
]

{ #category : 'initialization' }
Raycaster >> initialize [
	super initialize.
	self setExtent: 1280@800 depth: 32.
	fov := 60.
	rayNr := 640.
	lineW := (self width / rayNr) truncated.
]

{ #category : 'accessing' }
Raycaster >> lineW [

	^ lineW
]

{ #category : 'accessing' }
Raycaster >> lineW: anObject [

	lineW := anObject
]

{ #category : 'accessing' }
Raycaster >> rayNr [

	^ rayNr
]

{ #category : 'accessing' }
Raycaster >> rayNr: anObject [

	rayNr := anObject
]

{ #category : 'rendering' }
Raycaster >> renderLevel: level withCamera: player [
	|i angStep ray|
	angStep := (self fov / self rayNr) negated.
	i := 0.
	
	self drawBackgroundOf: level.
	
	"for every ray"
	self fov/2 to: ((self fov/2) negated) by: angStep do: [:angOff |
		"get ray direction"
		| angRad rayDir |
		angRad := angOff degreesToRadians.
		rayDir := Utils rotateDir: player dir byAngle: angRad. 
		
		ray := Ray castRayFromPosition: player pos withAngle: angRad inDirection: rayDir onMap: level.		
		self drawRay: ray at: i. 

		i := i +1.
	]. 
]
