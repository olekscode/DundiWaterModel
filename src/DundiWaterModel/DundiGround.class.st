Class {
	#name : #DundiGround,
	#superclass : #CMSpatialEntityElement,
	#instVars : [
		'grassAmount',
		'waterAmount'
	],
	#category : #DundiWaterModel
}

{ #category : #'as yet unclassified' }
DundiGround class >> diffusionRate [

	^ 0.1
]

{ #category : #'as yet unclassified' }
DundiGround >> diffuse: aSymbol [

	| value neighbourValue setter |
	value := self perform: aSymbol.

	self neighbourhood do: [ :neighbour |
		neighbourValue := neighbour perform: aSymbol.
		neighbourValue := neighbourValue + (value * self class diffusionRate / 8).
		
		setter := aSymbol, ':'.
		
		neighbour
			perform: setter
			with: neighbourValue ].
		
	self perform: setter with: (value * (1 - self class diffusionRate))

]

{ #category : #accessing }
DundiGround >> grassAmount [
	"Getter accessor with default value!! This method was automatically generated by Cormas !!"
	^ grassAmount ifNil: [ grassAmount := self grassAmount_default ]
]

{ #category : #accessing }
DundiGround >> grassAmount: anObject [
	" Set a value for the receiver's grassAmount
	!! This method was automatically generated by Cormas !!"
	 grassAmount := anObject
]

{ #category : #defaults }
DundiGround >> grassAmount_default [
	" Answer a default value for the grassAmount
	!! This method was automatically generated by Cormas !!"
	^ 0
]

{ #category : #'as yet unclassified' }
DundiGround >> growGrass [

	self grassAmount: (Cormas logisticGrowth: self grassAmount r: 0.01 K: 10).
]

{ #category : #initialization }
DundiGround >> initializeRandomGrass [

	^ self grassAmount: (Random new nextIntegerBetween: 0 and: 10)
]

{ #category : #initialization }
DundiGround >> initializeRandomWater [

	^ self waterAmount: (Random new nextIntegerBetween: 0 and: 10)
]

{ #category : #testing }
DundiGround >> isAbstract [ 
	^ false
]

{ #category : #pov }
DundiGround >> povGrass [

	^ self
		povAttribute: #grassAmount
		min: 0
		max: 10
		color: Color green
]

{ #category : #pov }
DundiGround >> povWater [

	^ self
		povAttribute: #waterAmount
		min: 0
		max: 10
		color: Color blue
]

{ #category : #stepping }
DundiGround >> step [

	self growGrass
]

{ #category : #accessing }
DundiGround >> waterAmount [
	"Getter accessor with default value!! This method was automatically generated by Cormas !!"
	^ waterAmount ifNil: [ waterAmount := self waterAmount_default ]
]

{ #category : #accessing }
DundiGround >> waterAmount: anObject [
	" Set a value for the receiver's waterAmount
	!! This method was automatically generated by Cormas !!"
	 waterAmount := anObject
]

{ #category : #defaults }
DundiGround >> waterAmount_default [
	" Answer a default value for the waterAmount
	!! This method was automatically generated by Cormas !!"
	^ 0
]