"
Holds level info:
	- map (matrix of integers: 0 - path, 1 - wall, 2 - goal) 
	- map dimensions
	- level colors

"
Class {
	#name : 'Level',
	#superclass : 'Object',
	#instVars : [
		'map',
		'mapDim',
		'wallColors',
		'groundColor',
		'backgroundColor'
	],
	#category : '3DMaze',
	#package : '3DMaze'
}

{ #category : 'instance creation' }
Level class >> fromMap: m [
	^ self new
		map: m;
		mapDim: (m size)@((m first) size);
		yourself.
]

{ #category : 'accessing' }
Level >> backgroundColor [

	^ backgroundColor
]

{ #category : 'accessing' }
Level >> backgroundColor: anObject [

	backgroundColor := anObject
]

{ #category : 'accessing' }
Level >> groundColor [

	^ groundColor
]

{ #category : 'accessing' }
Level >> groundColor: anObject [

	groundColor := anObject
]

{ #category : 'initialization' }
Level >> initialize [ 
	super initialize.
	map := {
   		{1. 1. 1. 1. 1. 1. 1. 1. 1. 1. 1. 1}.
    	{1. 0. 0. 0. 0. 0. 0. 0. 1. 0. 0. 1}.
    	{1. 1. 1. 1. 1. 1. 1. 0. 1. 0. 1. 1}.
    	{1. 0. 0. 0. 0. 0. 0. 0. 1. 0. 0. 1}.
    	{1. 0. 1. 1. 1. 1. 1. 1. 1. 1. 0. 1}.
    	{1. 0. 1. 0. 0. 0. 0. 0. 0. 0. 0. 1}.
    	{1. 0. 1. 0. 1. 1. 1. 1. 1. 1. 0. 1}.
    	{1. 0. 1. 0. 1. 0. 0. 0. 0. 1. 0. 1}.
    	{1. 0. 1. 0. 1. 0. 1. 1. 0. 1. 0. 1}.
    	{1. 0. 0. 0. 1. 0. 0. 1. 0. 1. 0. 1}.
    	{1. 1. 1. 1. 1. 1. 0. 2. 0. 0. 0. 1}.
    	{1. 1. 1. 1. 1. 1. 1. 1. 1. 1. 1. 1}
	}.

	mapDim := (map size)@((map first) size).
	
	backgroundColor := Color black.
	groundColor :=	Color gray.
	wallColors := Dictionary new.
	wallColors at: 1 put: Color white.
	wallColors at: 2 put: Color green.

]

{ #category : 'accessing' }
Level >> map [

	^ map
]

{ #category : 'accessing' }
Level >> map: anObject [

	map := anObject
]

{ #category : 'accessing' }
Level >> mapDim [

	^ mapDim
]

{ #category : 'accessing' }
Level >> mapDim: anObject [

	mapDim := anObject
]

{ #category : 'accessing' }
Level >> wallColors [

	^ wallColors
]

{ #category : 'accessing' }
Level >> wallColors: anObject [

	wallColors := anObject
]
