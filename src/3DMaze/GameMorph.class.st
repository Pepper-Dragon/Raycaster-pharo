"
Holds game loop logic as well as handles player input.

Can start default game with the run method.
Can be loaded with stages: list of {player, map} to run custom levels.
"
Class {
	#name : 'GameMorph',
	#superclass : 'Morph',
	#instVars : [
		'player',
		'level',
		'renderer',
		'stages',
		'stage'
	],
	#category : '3DMaze',
	#package : '3DMaze'
}

{ #category : 'drawing' }
GameMorph >> drawOn: aCanvas [	
	aCanvas drawImage: self frame at: self bounds origin.
]

{ #category : 'accessing' }
GameMorph >> frame [

	^ renderer
]

{ #category : 'event handling' }
GameMorph >> handlesKeyDown: anEvent [
	^ true
]

{ #category : 'initialization' }
GameMorph >> initialize [
	super initialize.
	player := Player new.
	level := Level new.
	renderer := Raycaster new.
	stages := {}.
	stage := 1.
	self extent: renderer extent.


]

{ #category : 'event handling' }
GameMorph >> keyDown: anEvent [

	| key |
	key := anEvent keyCharacter.

	key == $w ifTrue: [
		self player moveIn: self level withDir: 1].	
	key == $s ifTrue: [
		self player moveIn: self level withDir: -1].
	key == $a ifTrue: [
		self player rotateWithDir: 1]. 
	key == $d ifTrue: [
		self player rotateWithDir: -1]. 
]

{ #category : 'accessing' }
GameMorph >> level [

	^ level
]

{ #category : 'accessing' }
GameMorph >> level: anObject [

	level := anObject
]

{ #category : 'running' }
GameMorph >> loadNewStage [

	| stageData |
	self stage > self stages size
		ifTrue: [
			self stages: {  }.
			^ self ].

	stageData := self stages at: self stage.
	self player: stageData first.
	self level: (stageData at: 2).
	self stage: self stage + 1
]

{ #category : 'event handling' }
GameMorph >> mouseEnter: anEvent [	
	anEvent hand newKeyboardFocus: self
]

{ #category : 'event handling' }
GameMorph >> mouseLeave: anEvent [
	anEvent hand releaseKeyboardFocus: self
]

{ #category : 'accessing' }
GameMorph >> player [

	^ player
]

{ #category : 'accessing' }
GameMorph >> player: anObject [

	player := anObject
]

{ #category : 'accessing' }
GameMorph >> renderer [

	^ renderer
]

{ #category : 'accessing' }
GameMorph >> renderer: anObject [

	renderer := anObject
]

{ #category : 'running' }
GameMorph >> run [
	(self stages = {}) ifFalse:[self loadNewStage].
	self openInWorld.
	self startStepping.
]

{ #category : 'accessing' }
GameMorph >> stage [

	^ stage
]

{ #category : 'accessing' }
GameMorph >> stage: anObject [

	stage := anObject
]

{ #category : 'accessing' }
GameMorph >> stages [

	^ stages
]

{ #category : 'accessing' }
GameMorph >> stages: anObject [

	stages := anObject
]

{ #category : 'stepping and presenter' }
GameMorph >> step [
	self updateCheck.
	(self renderer) renderLevel: (self level) withCamera: (self player).
	self changed.
]

{ #category : 'stepping and presenter' }
GameMorph >> stepTime [
	^ 16
]

{ #category : 'running' }
GameMorph >> updateCheck [
	(self stages = {})
	ifTrue:[
		(self player checkEndConditionIn: self level)
		ifTrue: [ self delete].
	]
	ifFalse: [ 
		(self player checkEndConditionIn: self level)
		ifTrue: [ self loadNewStage].
	].
]
