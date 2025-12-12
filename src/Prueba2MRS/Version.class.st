Class {
	#name : 'Version',
	#superclass : 'Object',
	#instVars : [
		'date',
		'vulnerabilities',
		'workflow'
	],
	#category : 'Prueba2MRS',
	#package : 'Prueba2MRS'
}

{ #category : 'as yet unclassified' }
Version >> addVulnerability: aVulnerability [
    (self vulnerabilities) add: aVulnerability.
]

{ #category : 'as yet unclassified' }
Version >> asVulnerabilityRectangle [
    | vulnCount rect color width height minSize |

    "Contar vulnerabilidades de forma segura"
    vulnCount := (self vulnerabilities ifNil: [ OrderedCollection new ]) size.

    "Color seguro: si no hay workflow usar gris claro"
    color := (self workflow ifNil: [ nil ])
        ifNil: [ Color yellow ]
        ifNotNil: [
            (self workflow versions size >= 5)
                ifTrue: [ Color green ]
                ifFalse: [ Color red ] ].

    "Evitar 0: tamaño mínimo"
    minSize := 30.
    width := (vulnCount max: 1) * 30.
    height := (vulnCount max: 1) * 30.
    width := width max: minSize.
    height := height max: minSize.

    rect := BlElement new.
    rect background: color.
    rect geometry: (BlRectangle cornerRadius: 6).
    rect extent: (width @ height).
    rect margin: (BlInsets all: 6).

    ^ rect
]

{ #category : 'as yet unclassified' }
Version >> date [
    ^ date
]

{ #category : 'as yet unclassified' }
Version >> date: aString [
    date := aString
]

{ #category : 'as yet unclassified' }
Version >> gtVulnerabilityRectangleFor: aView [
	<gtView>
	^ aView explicit
		title: 'Vulnerabilities';
		stencil: [
			| size color rect |
			size := self vulnerabilities size.            
			color := ( (self workflow versions size) >= 5 )
				ifTrue: [ Color green ]
				ifFalse: [ Color red ].

			rect := BlElement new
				background: color;
				extent: (size * 30) @ (size * 30);
				geometry: BlRectangle new.
			
			rect
		].
]

{ #category : 'as yet unclassified' }
Version >> initialize [
    super initialize.
    vulnerabilities := OrderedCollection new
]

{ #category : 'as yet unclassified' }
Version >> vulnerabilities [
    ^ vulnerabilities ifNil: [ vulnerabilities := OrderedCollection new ]
]

{ #category : 'as yet unclassified' }
Version >> vulnerabilityCount [
    ^ self vulnerabilities size
]

{ #category : 'as yet unclassified' }
Version >> workflow [
    ^ workflow
]

{ #category : 'as yet unclassified' }
Version >> workflow: aWorkflow [
    workflow := aWorkflow.
]
