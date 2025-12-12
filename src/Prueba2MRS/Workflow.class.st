Class {
	#name : 'Workflow',
	#superclass : 'Object',
	#instVars : [
		'owner',
		'repoName',
		'name',
		'versions'
	],
	#category : 'Prueba2MRS',
	#package : 'Prueba2MRS'
}

{ #category : 'as yet unclassified' }
Workflow >> addVersion: aVersion [
    self versions add: aVersion.
    aVersion workflow: self.
]

{ #category : 'as yet unclassified' }
Workflow >> gtHomeFor: aView [
	<gtHome>
	^ aView explicit
		title: 'Vulnerabilities Evolution';
		stencil: [
			| container |
			container := BlElement new
				layout: (BlFlowLayout new);
				constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical fitContent ].
			
			self versions do: [ :version |
				| size color rect |
				size := version vulnerabilities size.            
				color := ( self versions size >= 5 )
					ifTrue: [ Color green ]
					ifFalse: [ Color red ].

				rect := BlElement new
					background: color;
					extent: (size * 30) @ (size * 30);
					geometry: BlRectangle new;
					margin: (BlInsets all: 5).
				
				container addChild: rect.
			].
			
			container
		].
]

{ #category : 'as yet unclassified' }
Workflow >> gtVersionFor: aView [ 
		<gtHome> 
		^ aView list 
			title: 'Versions'; 
			items: self versions; 
			itemTitle: [:ver | ver date asString ];
			itemView: [:ver :host | ver gtVulnerabilityRectangleFor: host ].
]

{ #category : 'as yet unclassified' }
Workflow >> gtVulnerabilitiesEvolutionFor: aView [
	<gtView>
	^ aView explicit
		title: 'Vulnerabilities Evolution';
		stencil: [
			| container |
			container := BlElement new
				layout: (BlFlowLayout new);
				constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical fitContent ].
			
			self versions do: [ :version |
				| size color rect |
				size := version vulnerabilities size.            
				color := ( self versions size >= 5 )
					ifTrue: [ Color green ]
					ifFalse: [ Color red ].

				rect := BlElement new
					background: color;
					extent: (size * 30) @ (size * 30);
					geometry: BlRectangle new;
					margin: (BlInsets all: 5).
				
				container addChild: rect.
			].
			
			container
		].

]

{ #category : 'as yet unclassified' }
Workflow >> initialize [
    super initialize.
    versions := OrderedCollection new
]

{ #category : 'as yet unclassified' }
Workflow >> name [ 
	^ name
]

{ #category : 'as yet unclassified' }
Workflow >> name: aString [ 
	name := aString.
]

{ #category : 'as yet unclassified' }
Workflow >> owner [
    ^ owner
]

{ #category : 'as yet unclassified' }
Workflow >> owner: aString [
    owner := aString
]

{ #category : 'as yet unclassified' }
Workflow >> repoName [
    ^ repoName
]

{ #category : 'as yet unclassified' }
Workflow >> repoName: aString [
    repoName := aString
]

{ #category : 'as yet unclassified' }
Workflow >> versions [
    ^ versions ifNil: [ versions := OrderedCollection new ]

]
