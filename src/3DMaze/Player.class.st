"
Holds player info:
	-position
	- direction

Has input methods moveIn, rotateWith.
Has win condition check method checkEndCondition. 
"
Class {
	#name : 'Player',
	#superclass : 'Object',
	#instVars : [
		'pos',
		'dir',
		'speed'
	],
	#category : '3DMaze',
	#package : '3DMaze'
}

{ #category : 'instance creation' }
Player class >> fromPos: position andDir: direction [

	^ self new
		pos: position;
		dir: direction;
		yourself.
]

{ #category : 'accessing' }
Player >> checkEndConditionIn: level [
	^ ((level map at: self pos y truncated) at: self pos x truncated) = 2.
]

{ #category : 'accessing' }
Player >> dir [

	^ dir
]

{ #category : 'accessing' }
Player >> dir: anObject [

	dir := anObject
]

{ #category : 'initialization' }
Player >> initialize [ 
	super initialize.
	pos:= 2.5@2.5.
	dir:= 0@1.
	speed:= 0.1.
]

{ #category : 'api - input/output' }
Player >> moveIn: level withDir: direction [

	|newX newY|
	newX := self pos x + (direction * (self dir x * self speed)).
	newY := self pos y + (direction * (self dir y * self speed)).
	((level map at: newY truncated) at: newX truncated) = 1
		ifFalse: [ self pos: newX @ newY].

]

{ #category : 'accessing' }
Player >> pos [

	^ pos
]

{ #category : 'accessing' }
Player >> pos: anObject [

	pos := anObject
]

{ #category : 'api - input/output' }
Player >> rotateWithDir: direction [
	|rot|
	rot := self speed / 2  * direction.
	self dir: (Utils rotateDir: self dir byAngle: rot). 
]

{ #category : 'accessing' }
Player >> speed [

	^ speed
]

{ #category : 'accessing' }
Player >> speed: anObject [

	speed := anObject
]
