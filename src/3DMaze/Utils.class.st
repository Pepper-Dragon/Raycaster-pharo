"
Has methods:
	- rotateDir: rotates a vector by some angle in radians
"
Class {
	#name : 'Utils',
	#superclass : 'Object',
	#category : '3DMaze',
	#package : '3DMaze'
}

{ #category : 'scaling, rotation' }
Utils class >> rotateDir: direction byAngle: angle [
	|newdir|
	newdir := ( (direction x * (angle cos)) - (direction y * (angle sin))) @
             ( (direction x * (angle sin)) + (direction y * (angle cos))).
	^ newdir.
]
