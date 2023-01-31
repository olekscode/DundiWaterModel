Class {
	#name : #DundiTree,
	#superclass : #CMAgentLocation,
	#category : #DundiWaterModel
}

{ #category : #accessing }
DundiTree class >> entityName [

	^ 'Tree'
]

{ #category : #'as yet unclassified' }
DundiTree class >> waterConsumptionRate [

	^ 7
]

{ #category : #'as yet unclassified' }
DundiTree >> consumeWater [

	patch ifNil: [ ^ nil ].
	self patch waterAmount: (self patch waterAmount - self class waterConsumptionRate).
	
	"self patch diffuseWater.
	self patch neighbourhood do: [ :neighbour | neighbour diffuseWater ]."
]

{ #category : #pov }
DundiTree >> pov [

	^ Color pink
]

{ #category : #accessing }
DundiTree >> sizeOfPOV [

	^ 35
]

{ #category : #stepping }
DundiTree >> step [

	self consumeWater
]
