Class {
	#name : #DundiCow,
	#superclass : #CMAgentLocation,
	#instVars : [
		'energy'
	],
	#classVars : [
		'catabolicRate'
	],
	#classInstVars : [
		'harvestRate'
	],
	#category : #DundiWaterModel
}

{ #category : #accessing }
DundiCow class >> catabolicRate [

	^ catabolicRate ifNil: [ catabolicRate := self catabolicRate_default ]
]

{ #category : #accessing }
DundiCow class >> catabolicRate: aNumber [

	catabolicRate := aNumber
]

{ #category : #accessing }
DundiCow class >> catabolicRate_default [

	^ 5
]

{ #category : #'default value' }
DundiCow class >> energy_default [

	^ 50
]

{ #category : #accessing }
DundiCow class >> harvestRate [

	^ harvestRate ifNil: [ harvestRate := self harvestRate_default ]
]

{ #category : #accessing }
DundiCow class >> harvestRate: aNumber [

	harvestRate := aNumber
]

{ #category : #accessing }
DundiCow class >> harvestRate_default [

	^ 0.9
]

{ #category : #'as yet unclassified' }
DundiCow >> burnEnergy [

	self energy: self energy - self class catabolicRate
]

{ #category : #biology }
DundiCow >> die [

	self dead: true
]

{ #category : #biology }
DundiCow >> eat [

	| consumedGrassAmount |
	patch ifNil: [ ^ nil ].
	consumedGrassAmount := self patch grassAmount * self class harvestRate.
	self energy: self energy + consumedGrassAmount.
	self patch grassAmount: self patch grassAmount - consumedGrassAmount
]

{ #category : #accessing }
DundiCow >> energy [
	"Getter accessor with default value!! This method was automatically generated by Cormas !!"
	^ energy ifNil: [ energy := self class energy_default ]
]

{ #category : #accessing }
DundiCow >> energy: anObject [
	" Set a value for the receiver's energy
	!! This method was automatically generated by Cormas !!"
	 energy := anObject
]

{ #category : #running }
DundiCow >> move [

	| tmp1 |
	patch ifNil: [ ^ nil ].
	tmp1 := self patch neighbourhoodAndSelf select: [ :arg1 | 
		        arg1 grassAmount > self class catabolicRate and: [ 
			        arg1 noOccupant ] ].
	tmp1 isEmpty
		ifTrue: [ self randomWalkConstrainedBy: [ :arg2 | arg2 noOccupantType: self class ] ]
		ifFalse: [ 
			self moveTo:
				(tmp1 asSortedCollection: [ :arg3 :arg4 | 
					 arg3 grassAmount > arg4 grassAmount ]) first ]
]

{ #category : #pov }
DundiCow >> pov [

	^ Color red
]

{ #category : #stepping }
DundiCow >> step [

	self burnEnergy.
	self move.
	self eat.
	
	energy <= 0 ifTrue: [ self die ].
]