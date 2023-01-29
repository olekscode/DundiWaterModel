Class {
	#name : #DundiGrass,
	#superclass : #CMAgentLocation,
	#instVars : [
		'biomass',
		'waterAmount'
	],
	#category : #DundiWaterModel
}

{ #category : #'default value' }
DundiGrass class >> biomass_default [

	^ 5
]

{ #category : #'as yet unclassified' }
DundiGrass class >> dryingRate [

	^ 2
]

{ #category : #'default value' }
DundiGrass class >> waterAmount_default [

	^ 10
]

{ #category : #'as yet unclassified' }
DundiGrass class >> waterConsumptionRate [

	^ 0.2
]

{ #category : #accessing }
DundiGrass >> biomass [

	^ biomass ifNil: [ biomass := self class biomass_default ]
]

{ #category : #accessing }
DundiGrass >> biomass: aNumber [

	biomass := aNumber
]

{ #category : #'as yet unclassified' }
DundiGrass >> consumeWater [

	| consumedWaterAmount |
	
	self patch ifNil: [ ^ self ].
	self isCompletelyDry ifTrue: [ ^ self ].
	
	consumedWaterAmount := self patch waterAmount * self class waterConsumptionRate.
	self waterAmount: self waterAmount + consumedWaterAmount.
	self patch waterAmount: self patch waterAmount - consumedWaterAmount.
]

{ #category : #'as yet unclassified' }
DundiGrass >> dry [

	waterAmount := (waterAmount - self class dryingRate) max: 0
]

{ #category : #private }
DundiGrass >> grow [

	self isCompletelyDry ifTrue: [ ^ self ].
	
	biomass := Cormas logisticGrowth: biomass r: 0.01 K: 10.
]

{ #category : #testing }
DundiGrass >> isCompletelyDry [

	^ waterAmount = 0
]

{ #category : #pov }
DundiGrass >> pov [ 

	^ self
		povAttribute: #biomass
		min: 0
		max: 10
		color: (self isCompletelyDry ifTrue: [ Color yellow ] ifFalse: [ Color green ]).
]

{ #category : #stepping }
DundiGrass >> step [

	self consumeWater.
	self dry.
	self grow.
]

{ #category : #accessing }
DundiGrass >> waterAmount [

	^ waterAmount ifNil: [ waterAmount := self class waterAmount_default ]
]

{ #category : #accessing }
DundiGrass >> waterAmount: aNumber [

	waterAmount := aNumber
]
